import 'dart:convert';

import 'package:fire_alert_mobile/src/core/provider/custom_notification.dart';
import 'package:fire_alert_mobile/src/fire_alert_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await CustomNotification.initialize();
  await initFirebaseMessaging();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const FireAlertApp());
}

Future<void> initFirebaseMessaging() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
  //   return;
  // });
  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message == null) return;
    CustomNotification.onSelectNotification(jsonEncode(message.data));
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    CustomNotification.onSelectNotification(jsonEncode(message.data));
  });

  FirebaseMessaging.onMessage.listen(firebaseNotificationHandler);
}
