import 'package:fire_alert_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:flutter/material.dart';

class UpdateAccountScreen extends StatefulWidget {
  static const String routeName = 'update-account';

  const UpdateAccountScreen({super.key});

  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: "Account"),
      body: Container(),
    );
  }
}
