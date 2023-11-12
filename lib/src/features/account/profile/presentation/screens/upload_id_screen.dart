import 'package:fire_alert_mobile/gen/assets.gen.dart';
import 'package:fire_alert_mobile/src/core/bloc/common/common_event.dart';
import 'package:fire_alert_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:fire_alert_mobile/src/core/common_widget/common_widget.dart';
import 'package:fire_alert_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:fire_alert_mobile/src/core/common_widget/v_space.dart';
import 'package:fire_alert_mobile/src/core/config/app_constant.dart';
import 'package:fire_alert_mobile/src/core/utils/profile_utils.dart';
import 'package:fire_alert_mobile/src/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:fire_alert_mobile/src/features/account/profile/presentation/bloc/upload_id/upload_id_bloc.dart';
import 'package:fire_alert_mobile/src/features/account/profile/presentation/widgets/update_account/verify_camera.dart';
import 'package:fire_alert_mobile/src/features/account/profile/presentation/widgets/update_account/verify_preview_photo.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/bloc/fire_alert_bloc/fire_alert_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ndialog/ndialog.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class UploadIDScreen extends StatefulWidget {
  static const String routeName = 'upload-id';

  const UploadIDScreen({super.key});

  @override
  State<UploadIDScreen> createState() => _UploadIDScreenState();
}

class _UploadIDScreenState extends State<UploadIDScreen> {
  final infoText =
      "Note: Please submit a picture of you holding your Identification Card front and back for fast verification by the Admin. \n\nThe following ID's will be accepted only:\n\n✅ Student ID\n✅ National ID\n✅ Driver's License\n✅ Postal ID\n✅ Passport ID\n✅ SSS ID";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<UploadIdBloc>(context).add(const InitialEvent());
        return true;
      },
      child: Scaffold(
        appBar: buildAppBar(
            context: context,
            title: "Verify Account",
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
              ),
              onPressed: () {
                BlocProvider.of<UploadIdBloc>(context)
                    .add(const InitialEvent());
                Navigator.of(context).pop(false);
              },
            )),
        body: SingleChildScrollView(
          child: BlocBuilder<UploadIdBloc, UploadIdState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Column(
                      children: [
                        buildCardBtn(
                          btnTitle: 'Take Photo',
                          cardTitle: 'Front Photo ID',
                          previewPhoto: (imagePath) {
                            handlePreviewPhoto(
                              context: context,
                              imagePath: imagePath,
                            );
                          },
                          takePhoto: () {
                            handleTakePhoto(context: context);
                          },
                          state: state,
                          viewTitle: "View Front Photo ID",
                        ),
                        buildCardBtn(
                          btnTitle: 'Take Photo',
                          cardTitle: 'Back Photo ID',
                          previewPhoto: (imagePath) {
                            handlePreviewPhoto(
                              context: context,
                              imagePath: imagePath,
                              isFrontPhoto: false,
                            );
                          },
                          takePhoto: () {
                            handleTakePhoto(
                                context: context, isFrontPhoto: false);
                          },
                          state: state,
                          viewTitle: "View Back Photo ID",
                          isFrontPhoto: false,
                        ),
                      ],
                    ),
                    Vspace.md,
                    CustomText(text: infoText),
                    Vspace.md,
                    Assets.images.infoCard.image(),
                    Vspace.md,
                    CustomBtn(
                      label: "Submit",
                      onTap: state is UploadIdLoaded &&
                              state.backPhotoPath != null &&
                              state.frontPhotoPath != null
                          ? () {
                              handleUploadId(state);
                            }
                          : null,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildCardBtn({
    required UploadIdState state,
    required String btnTitle,
    required String viewTitle,
    required VoidCallback takePhoto,
    required Function(String) previewPhoto,
    required String cardTitle,
    bool isFrontPhoto = true,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: cardTitle,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            if (state is UploadIdLoaded) ...[
              if (isFrontPhoto && state.frontPhotoPath != null) ...[
                CustomBtn(
                  label: viewTitle,
                  onTap: () {
                    previewPhoto(state.frontPhotoPath!);
                  },
                  backgroundColor: Colors.blue,
                  style: const TextStyle(color: Colors.white),
                ),
                const Divider(
                  height: 20,
                ),
              ],
              if (!isFrontPhoto && state.backPhotoPath != null) ...[
                CustomBtn(
                  label: viewTitle,
                  onTap: () {
                    previewPhoto(state.backPhotoPath!);
                  },
                  backgroundColor: Colors.blue,
                  style: const TextStyle(color: Colors.white),
                ),
                const Divider(
                  height: 20,
                ),
              ],
            ],
            CustomBtn(
              label: btnTitle,
              onTap: takePhoto,
            )
          ],
        ),
      ),
    );
  }

  void handleTakePhoto({
    bool isFrontPhoto = true,
    required BuildContext context,
  }) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: VerifyCamera(isFrontPhoto: isFrontPhoto),
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  void handlePreviewPhoto({
    bool isFrontPhoto = true,
    required BuildContext context,
    required String imagePath,
  }) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: VerifyPreviewPhoto(
        imagePath: imagePath,
        isPreviewOnly: true,
      ),
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  void handleUploadId(UploadIdLoaded state) {
    final profile = ProfileUtils.userProfile(context);
    EasyLoading.show();

    ProfileRepositoryImpl()
        .uploadIds(
            pk: profile!.profilePk,
            frontImagePath: state.frontPhotoPath!,
            backImagePath: state.backPhotoPath!)
        .then((value) async {
      NDialog(
        dialogStyle: DialogStyle(titleDivider: true),
        title: const CustomText(text: AppConstant.appName),
        content: const CustomText(
            text:
                "Successfully submitted your ids please wait for confirmation of admin."),
        actions: <Widget>[
          TextButton(
              child: const CustomText(text: "Close"),
              onPressed: () {
                Navigator.pop(context);
                handleFetchProfile();
              }),
        ],
      ).show(context);
    }).catchError((onError) {
      EasyLoading.dismiss();
      showDialogReport("Something went wrong");
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  void handleFetchProfile() async {
    EasyLoading.show();
    BlocProvider.of<UploadIdBloc>(context).add(const InitialEvent());

    final userProfile = await ProfileRepositoryImpl().fetchProfile();
    Future.delayed(const Duration(milliseconds: 500), () {
      BlocProvider.of<ProfileBloc>(context).add(
        SetProfileEvent(profile: userProfile),
      );
      BlocProvider.of<FireAlertBloc>(context).add(
        OnFetchFireAlert(),
      );
      Navigator.of(context).pop();
    });

    EasyLoading.dismiss();
  }

  void showDialogReport(String message) {
    Future.delayed(const Duration(milliseconds: 500), () {
      NDialog(
        dialogStyle: DialogStyle(titleDivider: true),
        title: const CustomText(text: AppConstant.appName),
        content: CustomText(text: message),
        actions: <Widget>[
          TextButton(
              child: const CustomText(text: "Close"),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ).show(context);
    });
  }
}
