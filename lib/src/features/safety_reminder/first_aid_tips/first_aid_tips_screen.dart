import 'dart:convert';

import 'package:fire_alert_mobile/gen/assets.gen.dart';
import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/common_widget/v_space.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstAidTipsScreen extends StatefulWidget {
  const FirstAidTipsScreen({super.key});

  static const String routeName = 'first-aid-tips-screen';

  @override
  State<FirstAidTipsScreen> createState() => _FirstAidTipsScreenState();
}

class _FirstAidTipsScreenState extends State<FirstAidTipsScreen> {
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
            final text = contents[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (text[0] == '✔') ...[
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
                Vspace(Vspace.sm.size),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> handleLoadFixture() async {
    final jsonPath = Assets.fixtures.firstAidTips;
    final jsonResponse = await rootBundle.loadString(jsonPath);
    final jsonDecode = await json.decode(jsonResponse);
    final content = jsonDecode['content'];
    setState(() {
      contents = List<String>.from(content);
    });
  }
}
