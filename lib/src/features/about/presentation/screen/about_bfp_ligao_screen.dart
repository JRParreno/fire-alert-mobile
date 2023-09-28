import 'package:fire_alert_mobile/src/features/about/presentation/screen/about_screen_dynamic.dart';
import 'package:fire_alert_mobile/src/features/about/presentation/widgets/about_card.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AboutBFPLigaoScreen extends StatefulWidget {
  const AboutBFPLigaoScreen({super.key});

  @override
  State<AboutBFPLigaoScreen> createState() => _AboutBFPLigaoScreenState();
}

class _AboutBFPLigaoScreenState extends State<AboutBFPLigaoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context: context, title: "About"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AboutCard(
              onTap: () {
                navigateScreen(
                  content:
                      'A modern fireservice fully capable ofensuring a fire safe nation by 2034.',
                  title: 'BFP VISION',
                );
              },
              title: "Vision",
            ),
            AboutCard(
              onTap: () {
                navigateScreen(
                  content:
                      'We commit to prevent and suppressdestructive fires, investigate its causes;enforce Fire Code and other related laws; respondto man-made and natural disasters and other emergencies.',
                  title: 'BFP MISSION',
                );
              },
              title: "Mission",
            ),
            AboutCard(
              onTap: () {
                navigateScreen(
                  content:
                      "The Bureau of Fire Protection (BFP) in Ligao City, Albay, is a dedicated and essential public service agency responsible for fire prevention, suppression, and safety management within the city. Committed to safeguarding the lives and properties of its residents, BFP Ligao City works tirelessly to ensure the community is well-prepared to handle fire emergencies. With a highly trained team of firefighters and state-of-the-art equipment, they are the city's first line of defense against fire disasters, making Ligao City a safer place to live and work.",
                  title: 'About BFP Ligao City',
                  isAboutContent: true,
                );
              },
              title: "About BFP Ligao City",
            ),
          ],
        ),
      ),
    );
  }

  void navigateScreen({
    required String title,
    required String content,
    bool isAboutContent = false,
  }) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: AboutBFPDynamic(
          content: content, title: title, isAboutContent: isAboutContent),
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
