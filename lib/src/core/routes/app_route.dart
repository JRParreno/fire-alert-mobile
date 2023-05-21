import 'package:fire_alert_mobile/src/features/account/login/presentation/screen/login_screen.dart';
import 'package:fire_alert_mobile/src/features/account/otp/presentation/screen/otp_screen.dart';
import 'package:fire_alert_mobile/src/features/account/profile/presentation/screens/profile_screen.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/screen/fire_alert_screen.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/widgets/camera.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/widgets/video.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/screen/home_screen.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/screen/information_screen.dart';
import 'package:fire_alert_mobile/src/features/onboarding/onboarding_screen.dart';
import 'package:fire_alert_mobile/src/features/splash/screen/splash_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) {
      switch (settings.name) {
        case SplashScreen.routeName:
          return const SplashScreen();
        case OnBoardingScreen.routeName:
          return const OnBoardingScreen();
        case LoginScreen.routeName:
          return const LoginScreen();
        case OTPSCreen.routeName:
          final args = settings.arguments! as OTPArgs;
          return OTPSCreen(args: args);
        case HomeScreen.routeName:
          return const HomeScreen();
        case ProfileScreen.routeName:
          return const ProfileScreen();
        case InformationScreen.routeName:
          return const InformationScreen();
        case FireAlertScreen.routeName:
          return const FireAlertScreen();
        case TakePictureScreen.routeName:
          return const TakePictureScreen();
        case TakeVideoScreen.routeName:
          return const TakeVideoScreen();
      }

      return const Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue,
        body: Center(
          child: Text('no screen'),
        ),
      );
    },
  );
}
