import 'package:fire_alert_mobile/src/fire_alert_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const FireAlertApp());
}
