import 'dart:async';

import 'package:fire_alert_mobile/src/features/account/login/presentation/widgets/login_body.dart';
import 'package:fire_alert_mobile/src/features/account/login/presentation/widgets/login_form.dart';
import 'package:fire_alert_mobile/src/features/account/login/presentation/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  late StreamSubscription<bool> keyboardSubscription;
  final TextEditingController emailSignupCtrl = TextEditingController();
  final TextEditingController passwordSignupCtrl = TextEditingController();
  final TextEditingController mobileNoCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final TextEditingController completeAddressCtrl = TextEditingController();
  FocusNode passwordSignupFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

  bool isCheck = false;

  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  bool isLogin = true;
  bool _passwordVisible = true;
  bool _passwordConfirmVisible = true;
  double heightForm = 0.2;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    emailSignupCtrl.dispose();
    passwordSignupCtrl.dispose();
    mobileNoCtrl.dispose();
    confirmPasswordCtrl.dispose();
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {});

    passwordSignupFocus.addListener(onCheckFocusPassword);
    confirmPasswordFocus.addListener(onCheckFocusPassword);
  }

  void handleLogin() {
    if (loginFormKey.currentState!.validate()) {
      // Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
    }
  }

  void handleSignup() {
    if (signupFormKey.currentState!.validate()) {
      // Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
    }
  }

  void handeChangeForm() {
    setState(() {
      isLogin = !isLogin;
      _passwordVisible = true;
    });
  }

  void handeCheckForm() {
    setState(() {
      isCheck = !isCheck;
    });
  }

  void handleOnChangePassVisible() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void handleOnConfirmChangePassVisible() {
    setState(() {
      _passwordConfirmVisible = !_passwordConfirmVisible;
    });
  }

  void onCheckFocusPassword() {
    keyboardSubscription.onData((data) {
      setState(() {
        heightForm = data ? 0.05 : 0.2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SizedBox(
            child: Stack(
          alignment: AlignmentDirectional.center,
          fit: StackFit.passthrough,
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .35,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/login_header.png"),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * heightForm,
              child: LoginBody(
                onChangeForm: handeChangeForm,
                isLogin: isLogin,
                widget: !isLogin
                    ? SignupForm(
                        isCheck: isCheck,
                        onChangeCheckBox: (value) {
                          setState(() {
                            isCheck = value;
                          });
                        },
                        confirmPasswordFocus: confirmPasswordFocus,
                        passwordSignupFocus: passwordSignupFocus,
                        emailCtrl: emailCtrl,
                        passwordCtrl: passwordCtrl,
                        completeAddressCtrl: completeAddressCtrl,
                        confirmPasswordCtrl: confirmPasswordCtrl,
                        mobileNoCtrl: mobileNoCtrl,
                        formKey: signupFormKey,
                        onSubmit: () {},
                        confirmPasswordVisible: _passwordConfirmVisible,
                        confirmSuffixIcon: GestureDetector(
                          onTap: handleOnConfirmChangePassVisible,
                          child: Icon(!_passwordConfirmVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        passwordVisible: _passwordVisible,
                        suffixIcon: GestureDetector(
                          onTap: handleOnChangePassVisible,
                          child: Icon(!_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      )
                    : LoginForm(
                        emailController: emailSignupCtrl,
                        passwordController: passwordSignupCtrl,
                        formKey: signupFormKey,
                        onSubmit: () {},
                        passwordVisible: _passwordVisible,
                        suffixIcon: GestureDetector(
                          onTap: handleOnChangePassVisible,
                          child: Icon(!_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
