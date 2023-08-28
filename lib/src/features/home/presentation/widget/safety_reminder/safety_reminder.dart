import 'package:fire_alert_mobile/gen/assets.gen.dart';
import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/common_widget/v_space.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/safety_reminder/safety_reminder_card.dart';
import 'package:fire_alert_mobile/src/features/safety_reminder/fire_safety/fire_safety_tips_screen.dart';
import 'package:fire_alert_mobile/src/features/safety_reminder/first_aid_tips/first_aid_tips_screen.dart';
import 'package:fire_alert_mobile/src/features/safety_reminder/tips_to_avoid_accident/tips_to_avoid_accident_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class SafetyReminder extends StatelessWidget {
  const SafetyReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: ColorName.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Safety Reminder',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Vspace(Vspace.sm.size),
          SafetyReminderCard(
            image: AssetImage(Assets.images.fireSafetyTips.path),
            title: 'Fire Safety Tips',
            onTap: () => handleNavigate(
                context: context, screen: const FireSafetyTipsScreen()),
          ),
          Vspace(Vspace.xs.size),
          SafetyReminderCard(
            image: AssetImage(Assets.images.firstAidTips.path),
            title: 'Fire Aid Tips',
            onTap: () => handleNavigate(
                context: context, screen: const FirstAidTipsScreen()),
          ),
          Vspace(Vspace.xs.size),
          SafetyReminderCard(
            image: AssetImage(Assets.images.tipsAvoidAccident.path),
            title: 'Tips to avoid accident',
            onTap: () => handleNavigate(
                context: context, screen: const TipsToAvoidAccidentScreen()),
          ),
        ],
      ),
    );
  }

  void handleNavigate({
    required BuildContext context,
    required Widget screen,
  }) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: screen,
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
