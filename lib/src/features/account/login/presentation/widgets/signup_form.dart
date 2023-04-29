import 'package:flutter/material.dart';

import '../../../../../core/common_widget/common_widget.dart';

class SignupForm extends StatelessWidget {
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmPasswordCtrl;
  final TextEditingController mobileNoCtrl;
  final TextEditingController completeAddressCtrl;
  final FocusNode passwordSignupFocus;
  final FocusNode confirmPasswordFocus;

  final GlobalKey<FormState> formKey;
  final Widget suffixIcon;
  final bool passwordVisible;
  final Widget confirmSuffixIcon;
  final bool confirmPasswordVisible;
  final bool isCheck;
  final Function(bool) onChangeCheckBox;

  final VoidCallback onSubmit;

  const SignupForm({
    super.key,
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.confirmPasswordCtrl,
    required this.mobileNoCtrl,
    required this.completeAddressCtrl,
    required this.formKey,
    required this.suffixIcon,
    required this.passwordVisible,
    required this.onSubmit,
    required this.confirmPasswordVisible,
    required this.confirmSuffixIcon,
    required this.confirmPasswordFocus,
    required this.passwordSignupFocus,
    required this.onChangeCheckBox,
    required this.isCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Divider(
                color: Colors.transparent,
                height: 20,
              ),
              CustomTextField(
                textController: emailCtrl,
                labelText: "Email",
                keyboardType: TextInputType.emailAddress,
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              CustomTextField(
                textController: mobileNoCtrl,
                labelText: "Mobile no.",
                keyboardType: TextInputType.emailAddress,
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              CustomTextField(
                textController: completeAddressCtrl,
                labelText: "Complete Address",
                keyboardType: TextInputType.emailAddress,
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              CustomTextField(
                focusNode: passwordSignupFocus,
                textController: passwordCtrl,
                labelText: "Password",
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
                suffixIcon: suffixIcon,
                obscureText: passwordVisible,
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              CustomTextField(
                textController: confirmPasswordCtrl,
                focusNode: confirmPasswordFocus,
                labelText: "Confirm Password",
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
                suffixIcon: confirmSuffixIcon,
                obscureText: confirmPasswordVisible,
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              Row(
                children: [
                  Checkbox(
                      value: isCheck,
                      onChanged: (value) {
                        onChangeCheckBox(value ?? false);
                      }),
                  const Expanded(
                    child: CustomText(
                      text:
                          "By creating you agree to the terms and Use and Privacy Policy",
                    ),
                  ),
                ],
              )
            ],
          ),
          const Divider(
            height: 50,
            color: Colors.transparent,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomBtn(
                label: "Signup",
                onTap: onSubmit,
                width: 275,
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
            ],
          )
        ],
      ),
    );
  }
}
