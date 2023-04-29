import 'package:fire_alert_mobile/src/features/account/login/presentation/widgets/login_body.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  bool isLogin = true;
  bool _passwordVisible = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void handleLogin() {
    if (loginFormKey.currentState!.validate()) {
      // Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
    }
  }

  void handeChangeForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              top: MediaQuery.of(context).size.height * .2,
              child: LoginBody(
                onChangeForm: handeChangeForm,
                isLogin: isLogin,
                emailController: emailController,
                passwordController: passwordController,
                formKey: loginFormKey,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  child: Icon(_passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                passwordVisible: _passwordVisible,
                onSubmit: handleLogin,
              ),
            )
          ],
        )),
      ),
    );
  }
}
