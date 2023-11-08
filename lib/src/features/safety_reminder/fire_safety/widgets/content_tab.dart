import 'package:fire_alert_mobile/src/core/common_widget/v_space.dart';
import 'package:flutter/material.dart';

class ContentTab extends StatelessWidget {
  const ContentTab({
    super.key,
    required this.content,
    this.imageWidget,
    this.isLoading = false,
  });

  final List<String> content;
  final bool isLoading;
  final Widget? imageWidget;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  if (imageWidget != null) ...[
                    imageWidget!,
                  ],
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFFFCEA2B),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: content.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (findTitle(content[index]).isNotEmpty) ...[
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
                                      Text(
                                        findTitle(content[index]),
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
                                    child: Text(
                                      findDescription(content[index]),
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ] else ...[
                              Text(
                                content[index],
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
    );
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
