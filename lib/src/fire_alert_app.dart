import 'package:fire_alert_mobile/src/core/routes/app_route.dart';
import 'package:fire_alert_mobile/src/features/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

class FireAlertApp extends StatefulWidget {
  const FireAlertApp({super.key});

  @override
  State<FireAlertApp> createState() => _FireAlertAppState();
}

class _FireAlertAppState extends State<FireAlertApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: generateRoute,
      home: const OnboadingScreen(),
    );
  }
}
