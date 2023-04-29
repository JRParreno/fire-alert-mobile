import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/common_widget/custom_btn.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatelessWidget {
  final VoidCallback onChangeForm;
  final bool isLogin;
  final Widget widget;

  const LoginBody({
    super.key,
    required this.isLogin,
    required this.onChangeForm,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: CustomBtn(
                    label: "Login",
                    btnStyle: ElevatedButton.styleFrom(
                      backgroundColor:
                          isLogin ? ColorName.primary : Colors.white,
                      elevation: isLogin ? null : 0,
                      side: !isLogin
                          ? const BorderSide(
                              color: ColorName.primary,
                              width: 1,
                            )
                          : null,
                    ),
                    onTap: onChangeForm,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: CustomBtn(
                    label: "Signup",
                    btnStyle: ElevatedButton.styleFrom(
                      backgroundColor:
                          !isLogin ? ColorName.primary : Colors.white,
                      elevation: !isLogin ? null : 0,
                      side: isLogin
                          ? const BorderSide(
                              color: ColorName.primary,
                              width: 1,
                            )
                          : null,
                    ),
                    onTap: onChangeForm,
                  ),
                ),
              ],
            ),
            widget,
          ],
        ),
      ),
    );
  }
}
