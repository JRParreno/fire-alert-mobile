import 'package:fire_alert_mobile/src/features/home/data/models/carousel.dart';
import 'package:fire_alert_mobile/src/features/home/data/repositories/carousel/carousel_repository_impl.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/carousel/home_carousel.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/carousel/home_carousel_list_scroll_indicators.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/carousel/home_carousel_loading.dart';
import 'package:flutter/material.dart';

class InformationScreen extends StatefulWidget {
  static const String routeName = '/information';
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  bool isLoading = true;
  int currentIndex = 0;
  List<Carousel> carousels = [];
  int currentTab = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => handleGetCarousel());
  }

  void handleGetCarousel() async {
    Future.delayed(const Duration(seconds: 3), () async {
      final tempCarousel = await CarouselRepositoryImpl().fetchCarousel();
      setState(() {
        carousels = tempCarousel;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                if (isLoading) ...[
                  HomeCarouselLoading(
                    onChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  HomeCarouselListScrollIndicators(
                    carousels: carousels,
                    currentCarousel: currentIndex,
                    isLoading: isLoading,
                  ),
                ] else ...[
                  Column(
                    children: [
                      HomeCarousel(
                        carousels: carousels,
                        onChanged: (value) {
                          setState(() {
                            currentIndex = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      HomeCarouselListScrollIndicators(
                        carousels: carousels,
                        isLoading: isLoading,
                        currentCarousel: currentIndex,
                      ),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
