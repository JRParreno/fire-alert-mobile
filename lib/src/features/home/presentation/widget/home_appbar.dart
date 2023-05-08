import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget homeAppBar({
  required BuildContext context,
}) {
  return AppBar(
    toolbarHeight: kToolbarHeight,
    titleSpacing: 0,
    backgroundColor: ColorName.primary,
    centerTitle: true,
    title: Text(
      'FireGuard',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: .3,
      ),
    ),
  );
}
