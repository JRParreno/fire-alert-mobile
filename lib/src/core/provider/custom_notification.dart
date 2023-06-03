import 'dart:convert';
import 'dart:io';

import 'package:fire_alert_mobile/src/core/bloc/common/common_event.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/data/models/alert_notification.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/bloc/fire_alert_bloc/fire_alert_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ignore: avoid_classes_with_only_static_members
class CustomNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future onSelectNotification(
    String? payload,
  ) async {}

  static Future<void> initialize() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        onSelectNotification(notificationResponse.payload);
      },
    );
  }

  static Future show(RemoteMessage message) async {
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
        payload: "test",
      );
    }
  }

  static void onCheckFireAlertNotification(
      {required GlobalKey<NavigatorState> navKey,
      required RemoteMessage message}) {
    final fireAlertBloc =
        BlocProvider.of<FireAlertBloc>(navKey.currentState!.context);
    final fireAlertState = fireAlertBloc.state;
    if (message.data.containsKey('json') && fireAlertState is FireAlertLoaded) {
      final alertNotificationJson = jsonDecode(message.data['json']);
      final alertNotification =
          AlertNotification.fromMap(alertNotificationJson);
      if ((alertNotification.isDone || alertNotification.isRejected) &&
          fireAlertState.fireAlert.pk == alertNotification.pk) {
        BlocProvider.of<FireAlertBloc>(navKey.currentState!.context).add(
          const InitialEvent(),
        );
      }
    }
  }
}
