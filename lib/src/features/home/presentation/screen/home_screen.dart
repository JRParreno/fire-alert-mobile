import 'package:fire_alert_mobile/src/core/bloc/common/common_event.dart';
import 'package:fire_alert_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:fire_alert_mobile/src/core/common_widget/common_widget.dart';
import 'package:fire_alert_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:fire_alert_mobile/src/core/local_storage/local_storage.dart';
import 'package:fire_alert_mobile/src/features/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void handleLogout() async {
    CommonDialog.showMyDialog(
      context: context,
      body: "Are you sure? you want to logout?",
      buttons: [
        TextButton(
          child: const Text("Yes"),
          onPressed: () async {
            BlocProvider.of<ProfileBloc>(context).add(const InitialEvent());
            await LocalStorage.deleteLocalStorage('_user');
            await LocalStorage.deleteLocalStorage('_refreshToken');
            await LocalStorage.deleteLocalStorage('_token');

            Future.delayed(const Duration(microseconds: 300), () {
              Navigator.of(context).pop();
            });
            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                OnboadingScreen.routeName,
                (route) => false,
              );
            });
          },
        ),
        TextButton(
          child: const Text("No"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, showBackBtn: true),
      floatingActionButton: FloatingActionButton(
        onPressed: handleLogout,
        child: const Icon(Icons.logout),
      ),
      body: Container(),
    );
  }
}
