import 'package:fire_alert_mobile/src/core/common_widget/custom_btn.dart';
import 'package:flutter/material.dart';

import '../../core/common_widget/common_widget.dart';

class OnboadingScreen extends StatefulWidget {
  static const String routeName = '/onboarding-screen';

  const OnboadingScreen({super.key});

  @override
  State<OnboadingScreen> createState() => _OnboadingScreenState();
}

class _OnboadingScreenState extends State<OnboadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/onboarding.png"),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      CustomText(
                        text: "Welcome",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 64,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        text: "Stay alert, stay safe:",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      CustomText(
                        text: "Prevent fires before they ignite",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 0,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.only(bottom: 50),
                  width: double.infinity,
                  child: CustomBtn(
                    onTap: () {},
                    label: "Get Started",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
