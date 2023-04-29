import 'package:fire_alert_mobile/src/features/account/login/presentation/screen/login_screen.dart';
import 'package:fire_alert_mobile/src/features/onboarding/onboarding_screen.dart';
import 'package:fire_alert_mobile/src/features/splash/screen/splash_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  return MaterialPageRoute(builder: (context) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return const SplashScreen();
    }
    switch (settings.name) {
      case OnboadingScreen.routeName:
        return const OnboadingScreen();
    }
    switch (settings.name) {
      case LoginScreen.routeName:
        return const LoginScreen();
    }
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Center(
        child: Text('no screen'),
      ),
    );
  });
}
