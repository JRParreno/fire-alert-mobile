import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/common_widget/v_space.dart';
import 'package:flutter/material.dart';

class ContentTab extends StatelessWidget {
  const ContentTab({
    super.key,
    required this.content,
    this.isLoading = false,
  });

  final List<String> content;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorName.primary,
      ),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: content.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content[index],
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Vspace(Vspace.sm.size),
                  ],
                );
              },
            ),
    );
  }
}
