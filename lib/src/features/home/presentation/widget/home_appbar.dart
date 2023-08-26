import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/config/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget homeAppBar({
  required BuildContext context,
  String? title,
  Color? backgroundColor,
  bool isDark = true,
  PreferredSizeWidget? bottom,
}) {
  return AppBar(
    toolbarHeight: kToolbarHeight,
    titleSpacing: 0,
    backgroundColor: backgroundColor ?? ColorName.primary,
    centerTitle: true,
    foregroundColor: isDark ? Colors.white : Colors.black,
    title: Text(
      title ?? AppConstant.appName,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: .3,
      ),
    ),
    bottom: bottom,
  );
}
