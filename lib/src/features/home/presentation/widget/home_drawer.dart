import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/common_widget/common_widget.dart';
import 'package:fire_alert_mobile/src/core/utils/profile_utils.dart';
import 'package:fire_alert_mobile/src/features/about/presentation/screen/about_bfp_ligao_screen.dart';
import 'package:fire_alert_mobile/src/features/account/profile/presentation/screens/update_account_screen.dart';
import 'package:fire_alert_mobile/src/features/webview/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = ProfileUtils.userProfile(context);

    return Drawer(
      backgroundColor: ColorName.primary,
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: DrawerHeader(
                  padding: EdgeInsets.zero,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: profile?.profilePhoto != null
                                  ? NetworkImage(profile!.profilePhoto!)
                                  : null,
                              radius: 35,
                              child: profile?.profilePhoto != null
                                  ? null
                                  : const Icon(Icons.person, size: 30),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text:
                                  '${profile?.firstName} ${profile?.lastName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 1,
                        child: IconButton(
                          onPressed: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: const UpdateAccountScreen(),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: const CustomText(text: "Director's Message"),
                      onTap: () => {},
                    ),
                    const Divider(
                      height: 0,
                      color: ColorName.border,
                    ),
                    ListTile(
                      title: const CustomText(text: "Citizen's Charter"),
                      onTap: () => {
                        handleNavigateWebView(
                            context: context,
                            url:
                                'https://region5.bfp.gov.ph/good-governance/bfp-citizens-charter/',
                            title: "Citizen's Charter"),
                      },
                    ),
                    const Divider(
                      height: 0,
                      color: ColorName.border,
                    ),
                    ListTile(
                      title: const CustomText(text: "Mandates and Functions"),
                      onTap: () => {
                        handleNavigateWebView(
                            context: context,
                            url:
                                'https://region5.bfp.gov.ph/about-us/mandates-and-functions/',
                            title: "Mandates and Functions"),
                      },
                    ),
                    const Divider(
                      height: 0,
                      color: ColorName.border,
                    ),
                    ListTile(
                      title: const CustomText(text: "News"),
                      onTap: () => {
                        handleNavigateWebView(
                            context: context,
                            url: 'https://region5.bfp.gov.ph/',
                            title: "News"),
                      },
                    ),
                    const Divider(
                      height: 0,
                      color: ColorName.border,
                    ),
                    ListTile(
                      title: const CustomText(text: "FAQ"),
                      onTap: () => {},
                    ),
                    const Divider(
                      height: 0,
                      color: ColorName.border,
                    ),
                    ListTile(
                      title: const CustomText(text: "About BFP Ligao"),
                      onTap: () => {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const AboutBFPLigaoScreen(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        )
                      },
                    ),
                    const Divider(
                      height: 0,
                      color: ColorName.border,
                    ),
                    ListTile(
                      title: const CustomText(text: "Directory"),
                      onTap: () => {},
                    ),
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                    ),
                    horizontalTitleGap: 0,
                    title: const CustomText(text: "Logout"),
                    onTap: () {
                      ProfileUtils.handleLogout(context);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void handleNavigateWebView({
    required String url,
    required String title,
    required BuildContext context,
  }) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: WebViewScreen(title: title, url: url),
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
