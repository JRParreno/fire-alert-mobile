import 'package:fire_alert_mobile/src/features/safety_reminder/first_aid_tips/first_aid_content_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:fire_alert_mobile/gen/assets.gen.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/home_appbar.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/safety_reminder/safety_reminder_card.dart';

class ScreenData {
  final String path;
  final String jsonKey;
  final String title;
  final String fixturePath;

  ScreenData({
    required this.path,
    required this.jsonKey,
    required this.title,
    required this.fixturePath,
  });
}

class FirstAidTipsScreen extends StatefulWidget {
  const FirstAidTipsScreen({super.key});

  static const String routeName = 'first-aid-tips-screen';

  @override
  State<FirstAidTipsScreen> createState() => _FirstAidTipsScreenState();
}

class _FirstAidTipsScreenState extends State<FirstAidTipsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(
        context: context,
        title: 'First Aid Tips',
        backgroundColor: Colors.white,
        isDark: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              firstAidCategoryCard('CUTS_AND_SCRAPES'),
              firstAidCategoryCard('BURNS'),
              firstAidCategoryCard('NOSEBLEEDS'),
              firstAidCategoryCard('BITES'),
            ],
          ),
        ),
      ),
    );
  }

  void handleNavigate({
    required BuildContext context,
    required ScreenData screenData,
  }) {
    final args = FirstAidContentScreenArgs(
        imagePath: screenData.path,
        jsonKey: screenData.jsonKey,
        title: screenData.title,
        jsonFixturePath: screenData.fixturePath);

    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
      settings: RouteSettings(
          arguments: FirstAidContentScreenArgs(
              imagePath: screenData.path,
              jsonKey: screenData.jsonKey,
              title: screenData.title,
              jsonFixturePath: screenData.fixturePath)),
      context,
      screen: FirstAidContentScreen(args: args),
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  Widget firstAidCategoryCard(String category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.75),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 5),
          )
        ],
      ),
      height: 80,
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(50),
        child: SafetyReminderCard(
          image: AssetImage(setupData(category).path),
          title: '',
          onTap: () =>
              handleNavigate(context: context, screenData: setupData(category)),
        ),
      ),
    );
  }

  ScreenData setupData(String category) {
    switch (category) {
      case 'CUTS_AND_SCRAPES':
        return ScreenData(
          path: Assets.images.firstAidCategory.cutsAndScrapes.path,
          jsonKey: 'cuts_scrapes',
          title: 'Cuts and Scrapes',
          fixturePath: Assets.fixtures.cutsScrapes,
        );
      case 'BURNS':
        return ScreenData(
          path: Assets.images.firstAidCategory.burns.path,
          jsonKey: 'burns',
          title: 'Burns',
          fixturePath: Assets.fixtures.burns,
        );
      case 'NOSEBLEEDS':
        return ScreenData(
          path: Assets.images.firstAidCategory.nosebleeds.path,
          jsonKey: 'nosebleeds',
          title: 'Nosebleeds',
          fixturePath: Assets.fixtures.nosebleeds,
        );
      default:
        return ScreenData(
          path: Assets.images.firstAidCategory.bites.path,
          jsonKey: 'bites',
          title: 'Bites',
          fixturePath: Assets.fixtures.bites,
        );
    }
  }
}
