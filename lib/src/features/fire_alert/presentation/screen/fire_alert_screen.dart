import 'package:app_settings/app_settings.dart';
import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/bloc/common/common_event.dart';
import 'package:fire_alert_mobile/src/core/common_widget/common_widget.dart';
import 'package:fire_alert_mobile/src/core/config/app_constant.dart';
import 'package:fire_alert_mobile/src/core/location/get_current_location.dart';
import 'package:fire_alert_mobile/src/core/location/url_launcher_google_map.dart';
import 'package:fire_alert_mobile/src/core/permission/app_permission.dart';
import 'package:fire_alert_mobile/src/core/utils/profile_utils.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/data/models/fire_alert.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/data/models/incident_type.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/data/repositories/fire_alert_repository_impl.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/bloc/fire_alert_bloc/fire_alert_bloc.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/bloc/media_bloc/media_bloc.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/widgets/camera.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/widgets/select_incident_type.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/widgets/report_form.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/widgets/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ndialog/ndialog.dart';
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
  bool isFormDisabled = false;
  IncidentType? incidentType;

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
      EasyLoading.show();

      final mediaBlocState = BlocProvider.of<MediaBloc>(context).state;
      final profile = ProfileUtils.userProfile(context);
      final currentReport =
          await FireAlertRepositoryImpl().fetchCurrentFireAlert();
      final urlMap = UrlLauncherGoogleMap.getUrlMap(googleMapUrlCtrl.text);

      if (profile != null && currentReport == null && urlMap != null) {
        FireAlert fireAlert = FireAlert(
          sender: profile.profilePk,
          googleMapUrl: urlMap,
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
          BlocProvider.of<FireAlertBloc>(context).add(OnFetchFireAlert());
          BlocProvider.of<MediaBloc>(context).add(const InitialEvent());
        }).whenComplete(() {
          EasyLoading.dismiss();
        });
      } else {
        EasyLoading.dismiss();
        showDialogReport();
      }
    }
  }

  void showDialogReport() {
    Future.delayed(const Duration(milliseconds: 500), () {
      NDialog(
        dialogStyle: DialogStyle(titleDivider: true),
        title: const CustomText(text: AppConstant.appName),
        content: const CustomText(text: "You have existing report"),
        actions: <Widget>[
          TextButton(
              child: const CustomText(text: "Close"),
              onPressed: () {
                BlocProvider.of<FireAlertBloc>(context).add(
                  OnFetchFireAlert(),
                );
                Navigator.pop(context);
              }),
        ],
      ).show(context);
    });
  }

  void setTextForm(FireAlertLoaded state) {
    final alert = state.fireAlert;
    locationCtrl.text = alert.message;
    incidentTypeCtrl.text = alert.incidentType;
    messageCtrl.text = alert.message;
    googleMapUrlCtrl.text = alert.googleMapUrl;

    if (alert.video != null) {
      // BlocProvider.of<MediaBloc>(context)
      //                   .add(AddVideoEvent(''));
    }
    if (alert.image != null) {
// BlocProvider.of<MediaBloc>(context)
//                         .add(AddVideoEvent(widget.filePath));
    }

    isFormDisabled = true;
  }

  void selectIncidentType() {
    NDialog(
      title: const CustomText(
        text: "Select Incident Type",
        style: TextStyle(fontSize: 18),
      ),
      content: SelectIncidentType(
        incidentType: incidentType,
        incidentTypes: AppConstant.incidentTypes,
        onSelect: (IncidentType value) {
          incidentTypeCtrl.text = value.name;
          setState(() {
            incidentType = value;
          });

          Navigator.pop(context);
        },
      ),
      actions: [
        TextButton(
            child: const CustomText(text: "Close"),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FireAlertBloc, FireAlertState>(
      builder: (context, state) {
        if (state is FireAlertLoaded) {
          setTextForm(state);
        }

        return Container(
          color: position != null ? ColorName.primary : Colors.white,
          padding: const EdgeInsets.all(15),
          child: position != null
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        child: ReportFrom(
                          state: state,
                          formKey: reportFormKey,
                          locationCtrl: locationCtrl,
                          incidentTypeCtrl: incidentTypeCtrl,
                          googleMapUrlCtrl: googleMapUrlCtrl,
                          messageCtrl: messageCtrl,
                          suffixLocationIcon: const Icon(Icons.location_pin),
                          suffixIncidentIcon: GestureDetector(
                            onTap: () {
                              selectIncidentType();
                            },
                            child: const Icon(Icons.chevron_right),
                          ),
                          suffixGoogleMapIcon: GestureDetector(
                            onTap: () async {
                              if (position != null) {
                                if (isFormDisabled) {
                                  UrlLauncherGoogleMap.openGoogleMapLink(
                                      googleMapUrlCtrl.text);
                                } else {
                                  UrlLauncherGoogleMap.openMap(
                                      position!.latitude, position!.longitude);
                                }
                              }
                            },
                            child: const Icon(Icons.maps_home_work),
                          ),
                        ),
                      ),
                      if (state is! FireAlertLoaded) ...[
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
                        ),
                      ],
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CustomText(
                          text:
                              "Can't determine your location, please try again"),
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
      },
    );
  }
}
