import 'dart:async';

import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/common_widget/common_widget.dart';
import 'package:fire_alert_mobile/src/core/common_widget/v_space.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

import 'package:fire_alert_mobile/gen/assets.gen.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/data/models/fire_alert.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/home_appbar.dart';

class TrackingScreenArgs {
  const TrackingScreenArgs(this.fireAlert);

  final FireAlert fireAlert;
}

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({
    super.key,
    required this.args,
  });

  final TrackingScreenArgs args;
  static const String routeName = 'tracking-screen';

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late Timer _timer;
  late int remainingSeconds;

  @override
  void initState() {
    setRemainingMinutes();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context: context, title: 'Track'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: ColorName.primary,
        child: const Icon(Icons.phone),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (remainingSeconds > 0) ...[
            const CustomText(
              text: 'Estimated time arrival at',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            CustomText(
              text: getArrivalTime(),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ] else ...[
            const CustomText(
              text:
                  'Timer is up, still not arriving? \nPlease tap contact BFP station',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          Vspace(Vspace.xl.size),
          Center(
            child: CircleAvatar(
              backgroundImage: Assets.images.fireTruckNew.provider(),
              radius: MediaQuery.of(context).size.height * 0.20,
            ),
          ),
        ],
      ),
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (remainingSeconds == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            remainingSeconds--;
          });
        }
      },
    );
  }

  String getArrivalTime() {
    double tempInMinutes = 0;
    if (remainingSeconds > 0) {
      tempInMinutes = remainingSeconds / 60;
    }

    if (tempInMinutes > 60) {
      final duration = tempInMinutes / 60;
      return '${duration.toStringAsFixed(0)} hours';
    }
    return '${tempInMinutes.toStringAsFixed(0)} minutes';
  }

  int getTotalMinutes() {
    DateTime today = DateTime.now();
    final DateTime dateCreated =
        DateTime.parse(widget.args.fireAlert.dateCreated!);

    Duration diffenceTime = today.difference(dateCreated);
    final travelTime = widget.args.fireAlert.travelTime.toStringAsFixed(0);

    return int.parse(travelTime) - diffenceTime.inMinutes;
  }

  void setRemainingMinutes() {
    final tempSeconds = getTotalMinutes() * 60;

    remainingSeconds = int.parse(tempSeconds.toStringAsFixed(0));
  }
}
