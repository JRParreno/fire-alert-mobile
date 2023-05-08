import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/common_widget/common_widget.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final TextStyle? style;
  final dynamic btnStyle;
  final bool unsetWidth;
  final bool unsetHeight;
  final Widget? icon;

  const CustomBtn({
    super.key,
    required this.label,
    this.onTap,
    this.backgroundColor,
    this.height,
    this.width,
    this.style,
    this.btnStyle,
    this.unsetHeight = false,
    this.unsetWidth = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: unsetWidth ? null : width ?? MediaQuery.of(context).size.width,
      height: unsetHeight ? null : height ?? 48,
      child: icon != null
          ? ElevatedButton.icon(
              icon: icon!,
              onPressed: onTap,
              style: btnStyle ??
                  ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor ?? ColorName.primary,
                    shape: const StadiumBorder(),
                  ),
              label: CustomText(
                text: label,
                style:
                    style ?? const TextStyle(color: Colors.black, fontSize: 14),
              ),
            )
          : ElevatedButton(
              onPressed: onTap,
              style: btnStyle ??
                  ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor ?? ColorName.primary,
                    shape: const StadiumBorder(),
                  ),
              child: CustomText(
                text: label,
                style:
                    style ?? const TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
    );
  }
}
