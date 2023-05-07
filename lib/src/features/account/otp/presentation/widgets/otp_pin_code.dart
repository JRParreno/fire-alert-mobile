import 'dart:async';

import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPPinCode extends StatelessWidget {
  final StreamController<ErrorAnimationType>? errorController;
  final VoidCallback verifyEmpty;
  final TextEditingController otp;

  const OTPPinCode({
    super.key,
    required this.verifyEmpty,
    required this.otp,
    this.errorController,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8.r),
        fieldHeight: 64.h,
        fieldWidth: 48.w,
        activeColor: ColorName.primary,
        selectedColor: ColorName.gray,
        inactiveColor: ColorName.border,
        borderWidth: 1,
      ),
      animationDuration: const Duration(milliseconds: 300),
      textStyle: TextStyle(
        fontSize: 32.sp,
        letterSpacing: 0.5,
      ),
      errorAnimationController: errorController,
      cursorColor: ColorName.placeHolder,
      keyboardType: TextInputType.number,
      controller: otp,
      onChanged: (value) {
        verifyEmpty();
      },
      enablePinAutofill: true,
      useHapticFeedback: true,
    );
  }
}
