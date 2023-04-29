import 'package:flutter/material.dart';

import '../../../../../core/common_widget/common_widget.dart';

class SignupForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final Widget suffixIcon;
  final bool passwordVisible;
  final VoidCallback onSubmit;

  const SignupForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.suffixIcon,
    required this.passwordVisible,
    required this.onSubmit,
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
                textController: emailController,
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
                textController: emailController,
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
                textController: emailController,
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
                textController: passwordController,
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
                textController: passwordController,
                labelText: "Confirm Password",
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
                suffixIcon: suffixIcon,
                obscureText: passwordVisible,
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
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
