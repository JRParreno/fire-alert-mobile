import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ignore: avoid_classes_with_only_static_members
class CustomNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future onSelectNotification(
    String? payload,
  ) async {}

  static void initialize(GlobalKey<NavigatorState> newKey) {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('app_icon'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        notificationResponse.payload;
      },
    );
  }

  static Future show(RemoteMessage message) async {
    print("onMessage: ${message.data}");
    if (Platform.isAndroid) {
      const channelId = 'com.thesis.fire_guard';
      const channelName = 'FireGuard';
      // const channelDescription = 'to be use of customer';

      const platformChannelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
          // channelDescription,
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(''),
        ),
      );

      final notification = message.notification;
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification!.title,
        notification.body,
        platformChannelSpecifics,
        payload: jsonEncode(message.data),
      );
    }
  }
}
