import 'package:fire_alert_mobile/src/core/common_widget/common_widget.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/bloc/media_bloc.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/widgets/preview_photo.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/widgets/preview_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ReportFrom extends StatelessWidget {
  final TextEditingController locationCtrl;
  final TextEditingController incidentTypeCtrl;
  final TextEditingController messageCtrl;
  final TextEditingController googleMapUrlCtrl;
  final GlobalKey<FormState> formKey;

  final Widget suffixLocationIcon;
  final Widget suffixIncidentIcon;
  final Widget suffixGoogleMapIcon;

  const ReportFrom({
    super.key,
    required this.formKey,
    required this.locationCtrl,
    required this.suffixLocationIcon,
    required this.suffixIncidentIcon,
    required this.incidentTypeCtrl,
    required this.messageCtrl,
    required this.googleMapUrlCtrl,
    required this.suffixGoogleMapIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(
              textController: locationCtrl,
              labelText: "Your Location",
              padding: EdgeInsets.zero,
              parametersValidate: 'required',
              suffixIcon: suffixLocationIcon,
            ),
            CustomTextField(
              textController: incidentTypeCtrl,
              labelText: "Incident Type",
              padding: EdgeInsets.zero,
              parametersValidate: 'required',
              suffixIcon: suffixIncidentIcon,
              // readOnly: true,
            ),
            CustomTextField(
              textController: googleMapUrlCtrl,
              labelText: "Google Map Link",
              padding: EdgeInsets.zero,
              parametersValidate: 'required',
              suffixIcon: suffixGoogleMapIcon,
            ),
            CustomTextField(
              textController: messageCtrl,
              labelText: "Message",
              padding: EdgeInsets.zero,
              parametersValidate: 'required',
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              minLines: 3,
            ),
            BlocBuilder<MediaBloc, MediaState>(
              builder: (context, state) {
                if (state is MediaLoaded) {
                  return Column(
                    children: [
                      if (state.imagePath != null &&
                          state.imagePath!.isNotEmpty) ...[
                        CustomBtn(
                          label: "View Image",
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: PreviewPhoto(
                                imagePath: state.imagePath!,
                                isPreviewOnly: true,
                              ),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                        ),
                      ],
                      const SizedBox(
                        height: 10,
                      ),
                      if (state.videoPath != null &&
                          state.videoPath!.isNotEmpty) ...[
                        CustomBtn(
                          label: "View Video",
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: PreviewVideo(
                                filePath: state.videoPath!,
                                isPreviewOnly: true,
                              ),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                        ),
                      ],
                    ],
                  );
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
