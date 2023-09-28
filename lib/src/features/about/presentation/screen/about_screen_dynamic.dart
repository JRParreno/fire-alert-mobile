import 'package:fire_alert_mobile/gen/assets.gen.dart';
import 'package:fire_alert_mobile/src/core/common_widget/custom_text.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/home_appbar.dart';
import 'package:flutter/material.dart';

class AboutBFPDynamic extends StatefulWidget {
  const AboutBFPDynamic({
    super.key,
    required this.content,
    required this.title,
    this.isAboutContent = false,
  });

  final String title;
  final String content;
  final bool isAboutContent;

  @override
  State<AboutBFPDynamic> createState() => _AboutBFPDynamicState();
}

class _AboutBFPDynamicState extends State<AboutBFPDynamic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context: context, title: widget.title),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          if (!widget.isAboutContent) ...[
            Assets.images.bfpLogo.image()
          ] else ...[
            Assets.images.missionVission.image()
          ],
          const SizedBox(
            height: 20,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomText(
                text: widget.content,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 17),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
