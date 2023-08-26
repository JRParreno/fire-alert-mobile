import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/bloc/common/common_state.dart';
import 'package:fire_alert_mobile/src/core/location/url_launcher_google_map.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/bloc/fire_alert_bloc/fire_alert_bloc.dart';
import 'package:fire_alert_mobile/src/features/home/data/bloc/home_carousel/home_carousel_bloc.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/carousel/home_carousel.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/carousel/home_carousel_list_scroll_indicators.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/carousel/home_carousel_loading.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/home_appbar.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/home_drawer.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/safety_reminder/safety_reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InformationScreen extends StatefulWidget {
  static const String routeName = '/information';
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  late final HomeCarouselBloc homeCarouselBloc;
  late final FireAlertBloc fireAlertBloc;

  @override
  void initState() {
    super.initState();
    setupBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FireAlertBloc, FireAlertState>(
      bloc: fireAlertBloc,
      builder: (context, state) {
        return Scaffold(
          drawer: const HomeDrawer(),
          appBar: homeAppBar(
            context: context,
          ),
          floatingActionButton: state is FireAlertLoaded
              ? FloatingActionButton(
                  backgroundColor: ColorName.primary,
                  onPressed: () {
                    final state = BlocProvider.of<FireAlertBloc>(context).state;

                    if (state is FireAlertLoaded) {
                      final urlMap = UrlLauncherGoogleMap.getUrlMap(
                          state.fireAlert.googleMapUrl);

                      if (urlMap != null) {
                        UrlLauncherGoogleMap.openGoogleMapLink(urlMap);
                      }
                    }
                  },
                  heroTag: null,
                  child: const Icon(Icons.fire_truck),
                )
              : null,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Column(
                children: [
                  Flexible(
                    flex: 0,
                    child: BlocBuilder<HomeCarouselBloc, HomeCarouselState>(
                      bloc: homeCarouselBloc,
                      builder: (context, state) {
                        if (state is InitialState || state is LoadingState) {
                          return Column(
                            children: [
                              HomeCarouselLoading(
                                onChanged: handleOnChangedCarousel,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const HomeCarouselListScrollIndicators(
                                carousels: [],
                                isLoading: true,
                                currentCarousel: 0,
                              ),
                            ],
                          );
                        }

                        if (state is HomeCarouselLoaded) {
                          return Column(
                            children: [
                              HomeCarousel(
                                carousels: state.carousels,
                                onChanged: handleOnChangedCarousel,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              HomeCarouselListScrollIndicators(
                                carousels: state.carousels,
                                isLoading: false,
                                currentCarousel: state.index,
                              ),
                            ],
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  ),
                  const SafetyReminder(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void setupBloc() {
    fireAlertBloc = BlocProvider.of<FireAlertBloc>(context);
    homeCarouselBloc = BlocProvider.of<HomeCarouselBloc>(context);

    homeCarouselBloc.add(GetHomeCarouselEvent());
  }

  void handleOnChangedCarousel(int index) {
    homeCarouselBloc.add(OnChangedCarousel(index));
  }
}
