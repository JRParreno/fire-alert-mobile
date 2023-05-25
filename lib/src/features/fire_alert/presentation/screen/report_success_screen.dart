import 'package:fire_alert_mobile/gen/assets.gen.dart';
import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/common_widget/common_widget.dart';
import 'package:flutter/material.dart';

class ReportSuccessScreen extends StatefulWidget {
  static const String routeName = 'report-success-screen';
  const ReportSuccessScreen({super.key});

  @override
  State<ReportSuccessScreen> createState() => _ReportSuccessScreenState();
}

class _ReportSuccessScreenState extends State<ReportSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: ColorName.primary,
          child: Container(
            margin: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 40,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.svgs.reportSuccess.svg(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CustomText(
                      textAlign: TextAlign.justify,
                      text:
                          "The report is already sent to Bureau of Fire Protection Ligao City",
                      style: TextStyle(fontSize: 20, height: 1.5),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomBtn(
                    label: "Okay",
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    width: 120,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
