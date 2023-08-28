import 'dart:convert';

import 'package:fire_alert_mobile/gen/assets.gen.dart';
import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/common_widget/v_space.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TipsToAvoidAccidentScreen extends StatefulWidget {
  const TipsToAvoidAccidentScreen({super.key});

  static const String routeName = 'tips-to-avoid-accident-screen';

  @override
  State<TipsToAvoidAccidentScreen> createState() =>
      _TipsToAvoidAccidentScreenState();
}

class _TipsToAvoidAccidentScreenState extends State<TipsToAvoidAccidentScreen> {
  List<String> contents = [];

  @override
  void initState() {
    handleLoadFixture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(
        context: context,
        title: 'First Aid Tips',
        backgroundColor: Colors.white,
        isDark: false,
      ),
      body: Container(
        color: ColorName.primary,
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: contents.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contents[index],
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                Vspace(Vspace.sm.size),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> handleLoadFixture() async {
    final jsonPath = Assets.fixtures.tipsToAvoidAccident;
    final jsonResponse = await rootBundle.loadString(jsonPath);
    final jsonDecode = await json.decode(jsonResponse);
    final content = jsonDecode['content'];
    setState(() {
      contents = List<String>.from(content);
    });
  }
}
