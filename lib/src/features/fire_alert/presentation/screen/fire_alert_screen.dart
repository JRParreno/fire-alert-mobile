import 'package:app_settings/app_settings.dart';
import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/common_widget/common_widget.dart';
import 'package:fire_alert_mobile/src/core/location/get_current_location.dart';
import 'package:fire_alert_mobile/src/core/permission/app_permission.dart';
import 'package:fire_alert_mobile/src/core/utils/profile_utils.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/data/models/fire_alert.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/data/repositories/fire_alert_repository_impl.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/bloc/media_bloc.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/widgets/camera.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/widgets/report_form.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/widgets/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FireAlertScreen extends StatefulWidget {
  static const String routeName = 'fire-alert-screen';

  const FireAlertScreen({super.key});

  @override
  State<FireAlertScreen> createState() => _FireAlertScreenState();
}

class _FireAlertScreenState extends State<FireAlertScreen> {
  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController incidentTypeCtrl = TextEditingController();
  final TextEditingController messageCtrl = TextEditingController();
  final TextEditingController googleMapUrlCtrl = TextEditingController();
  final reportFormKey = GlobalKey<FormState>();
  Position? position;

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => checkLocationPermission(ctx: context));
    super.initState();
  }

  Future<void> checkCameraPermission({bool isCamera = true}) async {
    final cameraPermGranted = await AppPermission.cameraPermission();

    if (cameraPermGranted) {
      // naviate from other screen; return;
      navigateCameraScreen(isCamera);
      return;
    }
    return AppSettings.openAppSettings();
  }

  Future<void> checkLocationPermission({BuildContext? ctx}) async {
    final locationPermGranted = await AppPermission.locationPermission();

    if (locationPermGranted) {
      EasyLoading.show();
      final currentLocation = await getCurrentLocation();
      setState(() {
        position = currentLocation;
      });
      EasyLoading.dismiss();
      return;
    }
    return AppSettings.openAppSettings();
  }

  void navigateCameraScreen(bool isCamera) {
    if (isCamera) {
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const TakePictureScreen(),
        withNavBar: true, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
      return;
    }

    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: const TakeVideoScreen(),
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  Future<void> handleSubmitAlert() async {
    if (reportFormKey.currentState!.validate() && position != null) {
      final mediaBlocState = BlocProvider.of<MediaBloc>(context).state;
      final profile = ProfileUtils.userProfile(context);
      EasyLoading.show();
      if (profile != null) {
        FireAlert fireAlert = FireAlert(
          sender: profile.profilePk,
          googleMapUrl: googleMapUrlCtrl.text,
          longitude: position!.latitude,
          latitude: position!.latitude,
          incidentType: "sample",
          message: messageCtrl.text,
        );
        if (mediaBlocState is MediaLoaded) {
          fireAlert = fireAlert.copyWith(
            image: mediaBlocState.imagePath != null &&
                    mediaBlocState.imagePath!.isNotEmpty
                ? mediaBlocState.imagePath
                : null,
            video: mediaBlocState.videoPath != null &&
                    mediaBlocState.videoPath!.isNotEmpty
                ? mediaBlocState.videoPath
                : null,
          );
        }
        await FireAlertRepositoryImpl().sendFireAlert(fireAlert).then((value) {
          // set bloc fire alert exists
        }).whenComplete(() {
          EasyLoading.dismiss();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: position != null ? ColorName.primary : Colors.white,
      padding: const EdgeInsets.all(15),
      child: position != null
          ? SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    // height: MediaQuery.of(context).size.height * 0.55,
                    child: ReportFrom(
                      formKey: reportFormKey,
                      locationCtrl: locationCtrl,
                      incidentTypeCtrl: incidentTypeCtrl,
                      googleMapUrlCtrl: googleMapUrlCtrl,
                      messageCtrl: messageCtrl,
                      suffixLocationIcon: GestureDetector(
                        onTap: () {
                          checkLocationPermission();
                        },
                        child: const Icon(Icons.location_pin),
                      ),
                      suffixIncidentIcon: GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.chevron_right),
                      ),
                      suffixGoogleMapIcon: GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.maps_home_work),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: IconButton(
                                  onPressed: () async {
                                    await checkCameraPermission();
                                  },
                                  icon: const Icon(
                                    Icons.photo_camera,
                                    size: 50,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: IconButton(
                                  onPressed: () async {
                                    await checkCameraPermission(
                                        isCamera: false);
                                  },
                                  icon: const Icon(
                                    Icons.video_camera_back,
                                    size: 50,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        CustomBtn(
                          label: "Submit",
                          onTap: () async {
                            await handleSubmitAlert();
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomText(
                      text: "Can't determine your location, please try again"),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomBtn(
                      label: "Enable Location",
                      onTap: () {
                        checkLocationPermission();
                      })
                ],
              ),
            ),
    );
  }
}
