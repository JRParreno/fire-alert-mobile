import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class HomeCarouselIndicator extends StatelessWidget {
  final int currentIndex;
  final int indicatorIndex;

  const HomeCarouselIndicator({
    super.key,
    required this.currentIndex,
    required this.indicatorIndex,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 10),
      width: currentIndex == indicatorIndex ? 32 : 6,
      decoration: BoxDecoration(
        color: ColorName.primary,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
