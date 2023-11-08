import 'dart:convert';

import 'package:fire_alert_mobile/gen/assets.gen.dart';
import 'package:fire_alert_mobile/src/core/common_widget/v_space.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formatted_text/formatted_text.dart';

class NaturalDisasterScreen extends StatefulWidget {
  const NaturalDisasterScreen({super.key});

  static const String routeName = 'safety-reminder/natural-disaster';

  @override
  State<NaturalDisasterScreen> createState() => _NaturalDisasterScreenState();
}

class _NaturalDisasterScreenState extends State<NaturalDisasterScreen> {
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
        title: 'Natural Disaster',
        backgroundColor: Colors.white,
        isDark: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Assets.images.naturalDisasters.image(),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFFFCEA2B),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: contents.length,
                  itemBuilder: (context, index) {
                    final text = contents[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (findTitle(text).isNotEmpty) ...[
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    '✔ ',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  FormattedText(
                                    findTitle(text),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              Vspace.xxs,
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: FormattedText(
                                  findDescription(text),
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ] else ...[
                          Text(
                            text,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                        Vspace(Vspace.sm.size),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> handleLoadFixture() async {
    final jsonPath = Assets.fixtures.naturalDisaster;
    final jsonResponse = await rootBundle.loadString(jsonPath);
    final jsonDecode = await json.decode(jsonResponse);
    final content = jsonDecode['natural_disaster'];
    setState(() {
      contents = List<String>.from(content);
    });
  }

  String findTitle(String str) {
    RegExp exp = RegExp(r'--([^]*?)--');
    RegExpMatch? match = exp.firstMatch(str);
    return match?.group(1) ?? '';
  }

  String findDescription(String str) {
    RegExp exp = RegExp(r'==([^]*?)==');
    RegExpMatch? match = exp.firstMatch(str);
    return match?.group(1) ?? '';
  }
}
