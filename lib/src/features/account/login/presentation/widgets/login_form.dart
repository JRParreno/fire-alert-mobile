import 'package:flutter/material.dart';

import '../../../../../core/common_widget/common_widget.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final Widget suffixIcon;
  final bool passwordVisible;
  final VoidCallback onSubmit;

  const LoginForm({
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
                height: 10,
              ),
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
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: CustomTextLink(
                  text: "Forgot Password?",
                ),
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
                label: "Log In",
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
