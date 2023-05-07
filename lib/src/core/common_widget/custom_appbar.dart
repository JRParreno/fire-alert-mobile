import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget buildAppBar({
  required BuildContext context,
  String? title,
  Widget? leading,
  bool showBackBtn = false,
}) {
  return AppBar(
    toolbarHeight: kToolbarHeight,
    titleSpacing: 0,
    backgroundColor: ColorName.primary,
    centerTitle: true,
    leading: leading != null
        ? !showBackBtn
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              )
            : null
        : null,
    title: Text(
      title ?? 'FireGuard',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: .3,
      ),
    ),
  );
}
