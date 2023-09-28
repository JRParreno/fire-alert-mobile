import 'dart:async';
import 'package:fire_alert_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:fire_alert_mobile/src/core/common_widget/common_widget.dart';
import 'package:fire_alert_mobile/src/core/local_storage/local_storage.dart';
import 'package:fire_alert_mobile/src/features/account/login/data/repositories/login_repository_impl.dart';
import 'package:fire_alert_mobile/src/features/account/login/presentation/widgets/login_body.dart';
import 'package:fire_alert_mobile/src/features/account/login/presentation/widgets/login_form.dart';
import 'package:fire_alert_mobile/src/features/account/login/presentation/widgets/signup_form.dart';
import 'package:fire_alert_mobile/src/features/account/otp/presentation/screen/otp_screen.dart';
import 'package:fire_alert_mobile/src/features/account/profile/data/models/profile.dart';
import 'package:fire_alert_mobile/src/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:fire_alert_mobile/src/features/account/signup/data/models/signup.dart';
import 'package:fire_alert_mobile/src/features/account/signup/data/repositories/signup_repository_impl.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();

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
    // testLoginValues();
    // testSignupValues();
  }

  void testLoginValues() {
    emailCtrl.text = "jhonrhayparreno22@gmail.com";
    passwordCtrl.text = "2020Rtutest@";
  }

  void testSignupValues() {
    emailSignupCtrl.text = "jhonrhayparreno22@gmail.com";
    passwordSignupCtrl.text = "2020Rtutest@";
    mobileNoCtrl.text = "09321764095";
    confirmPasswordCtrl.text = "2020Rtutest@";
    completeAddressCtrl.text = "1977C FB Harrison Pasay City";
    firstNameCtrl.text = "Jhon Rhay";
    lastNameCtrl.text = "Parreno";
    setState(() {
      isCheck = true;
    });
  }

  void handleLogin() {
    if (loginFormKey.currentState!.validate()) {
      LoaderDialog.show(context: context);

      LoginRepositoryImpl()
          .login(email: emailCtrl.value.text, password: passwordCtrl.value.text)
          .then((value) async {
        await LocalStorage.storeLocalStorage(
            '_token', value['data']['access_token']);
        await LocalStorage.storeLocalStorage(
            '_refreshToken', value['data']['refresh_token']);
        handleGetProfile();
      }).catchError((onError) {
        LoaderDialog.hide(context: context);
        Future.delayed(const Duration(milliseconds: 500), () {
          CommonDialog.showMyDialog(
            context: context,
            title: "FireGuard",
            body: "Invalid email or password",
            isError: true,
          );
        });
      });
    }
  }

  void handleGetProfile() async {
    await ProfileRepositoryImpl().fetchProfile().then((profile) async {
      if (profile.otpVerified) {
        await LocalStorage.storeLocalStorage('_user', profile.toJson());

        handleSetProfileBloc(profile);
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName,
            (route) => false,
          );
        });
      } else {
        Future.delayed(const Duration(milliseconds: 500), () {
          // Navigate OTP screen
          Navigator.of(context).pushNamed(
            OTPSCreen.routeName,
            arguments: OTPArgs(
              userId: profile.pk,
              email: profile.email,
            ),
          );
        });
      }
    }).catchError((onError) {
      Future.delayed(const Duration(milliseconds: 500), () {
        CommonDialog.showMyDialog(
          context: context,
          title: "FireGuard",
          body: onError['data']['error_message'],
          isError: true,
        );
      });
    });
    // ignore: use_build_context_synchronously
    LoaderDialog.hide(context: context);
  }

  void handleSetProfileBloc(Profile profile) {
    BlocProvider.of<ProfileBloc>(context).add(
      SetProfileEvent(profile: profile),
    );
  }

  void handleSignup() {
    if (signupFormKey.currentState!.validate()) {
      if (isCheck) {
        LoaderDialog.show(context: context);
        final signup = Signup(
          email: emailSignupCtrl.text,
          mobileNumber: mobileNoCtrl.text,
          completeAddress: completeAddressCtrl.text,
          password: passwordSignupCtrl.text,
          confirmPassword: confirmPasswordCtrl.text,
          firstName: firstNameCtrl.text,
          lastName: lastNameCtrl.text,
        );
        SignupImpl().register(signup).then((value) {
          LoaderDialog.hide(context: context);

          Future.delayed(const Duration(milliseconds: 500), () {
            // Navigate OTP screen
            Navigator.of(context).pushNamed(
              OTPSCreen.routeName,
              arguments: OTPArgs(
                userId: value['data']['id'].toString(),
                email: emailSignupCtrl.value.text,
              ),
            );
          });
        }).catchError((onError) {
          LoaderDialog.hide(context: context);
          Future.delayed(const Duration(milliseconds: 500), () {
            CommonDialog.showMyDialog(
              context: context,
              title: "FireGuard",
              body: onError['data']['error_message'],
              isError: true,
            );
          });
        });
      } else {
        CommonDialog.showMyDialog(
          context: context,
          title: "FireGuard",
          body: "Please agreed to terms and conditions",
        );
      }
    } else {}
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
        heightForm = data ? 1 : 0.2;
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
              top: isLogin
                  ? MediaQuery.of(context).size.height * heightForm
                  : null,
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
                        firstNameCtrl: firstNameCtrl,
                        lastNameCtrl: lastNameCtrl,
                        confirmPasswordFocus: confirmPasswordFocus,
                        passwordSignupFocus: passwordSignupFocus,
                        emailCtrl: emailSignupCtrl,
                        passwordCtrl: passwordSignupCtrl,
                        completeAddressCtrl: completeAddressCtrl,
                        confirmPasswordCtrl: confirmPasswordCtrl,
                        mobileNoCtrl: mobileNoCtrl,
                        formKey: signupFormKey,
                        onSubmit: handleSignup,
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
                        emailController: emailCtrl,
                        passwordController: passwordCtrl,
                        formKey: loginFormKey,
                        onSubmit: handleLogin,
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
