import 'dart:async';

import 'package:fire_alert_mobile/gen/assets.gen.dart';
import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/utils/size_config.dart';
import 'package:fire_alert_mobile/src/features/account/otp/presentation/widgets/otp_pin_code.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPBody extends StatelessWidget {
  final String email;
  final ValueNotifier<String> duration;
  final Timer timer;
  final int resendCtr;
  final StreamController<ErrorAnimationType>? errorController;
  final VoidCallback verifyEmpty;
  final TextEditingController otp;
  final VoidCallback resendOTP;

  const OTPBody({
    super.key,
    required this.email,
    required this.duration,
    required this.resendCtr,
    required this.verifyEmpty,
    required this.otp,
    required this.timer,
    required this.resendOTP,
    this.errorController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Assets.svgs.iconVerification.svg(),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Text(
                    'OTP Verification',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      letterSpacing: 0.3,
                      color: ColorName.primary,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Text.rich(
                    const TextSpan(
                      children: [
                        TextSpan(text: "Enter the 4-digit code sent to "),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      letterSpacing: 0.1,
                      // wordSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  email,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                    letterSpacing: 0.1,
                  ),
                ),
                SizedBox(height: 36.sp),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: OTPPinCode(
                    otp: otp,
                    verifyEmpty: verifyEmpty,
                    errorController: errorController,
                  ),
                ),
                SizedBox(height: 32.h),
                Container(
                  padding: const EdgeInsets.only(top: 12, bottom: 12).r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: ValueListenableBuilder(
                          valueListenable: duration,
                          builder: (context, String dur, _) => Text.rich(
                            TextSpan(
                              children: [
                                if (timer.isActive) ...[
                                  TextSpan(
                                    text: "Resend in ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                      // SizeConfig.getProportionateScreenHeight(14),
                                    ),
                                  ),
                                  TextSpan(
                                    text: dur,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                      // SizeConfig.getProportionateScreenHeight(14),
                                    ),
                                  ),
                                ],
                                if (!timer.isActive) ...[
                                  if (resendCtr >= 5) ...[
                                    const TextSpan(text: "Max Limit Reached."),
                                    TextSpan(
                                      text: "Try again in 10 Mins",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                  if (resendCtr <= 4) ...[
                                    TextSpan(
                                      text: "Didn't receive a code? ",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          resendOTP();
                                        },
                                      text: "Resend",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ]
                                ],
                              ],
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.getProportionateScreenWidth(
                            20,
                          ),
                        ),
                        child: Text.rich(
                          TextSpan(
                              children: [
                                TextSpan(
                                  text: "You may resend up to 5 times ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: "($resendCtr out of 5)",
                                  style: TextStyle(
                                      fontFamily: "HenrySans",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                      color: resendCtr >= 5
                                          ? ColorName.error
                                          : null),
                                )
                              ],
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10.sp,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )),
      ],
    );
  }
}
