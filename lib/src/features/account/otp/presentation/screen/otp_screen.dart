import 'package:flutter/material.dart';

class OTPArgs {
  final String emailAddress;
  final String password;

  OTPArgs({
    required this.emailAddress,
    required this.password,
  });
}

class OTPSCreen extends StatefulWidget {
  static const String routeName = '/otp';
  final OTPArgs args;

  const OTPSCreen({super.key, required this.args});

  @override
  State<OTPSCreen> createState() => _OTPSCreenState();
}

class _OTPSCreenState extends State<OTPSCreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
