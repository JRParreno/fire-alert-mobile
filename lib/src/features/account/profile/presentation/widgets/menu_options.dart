import 'package:fire_alert_mobile/src/core/common_widget/common_widget.dart';
import 'package:fire_alert_mobile/src/core/utils/profile_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuOptions extends StatelessWidget {
  final BuildContext ctx;
  const MenuOptions({super.key, required this.ctx});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: const CustomText(text: 'About Us'),
            leading: const Icon(Icons.people),
            onTap: () {},
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: const CustomText(text: 'Notifications'),
            leading: const Icon(Icons.notifications_active),
            onTap: () {},
            trailing: const Icon(Icons.chevron_right),
            enableFeedback: true,
          ),
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: const CustomText(text: 'Terms and Condition'),
            leading: const Icon(CupertinoIcons.doc_text_fill),
            onTap: () {},
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: const CustomText(text: 'Privacy Policy'),
            leading: const Icon(Icons.fingerprint),
            onTap: () {},
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: const CustomText(text: 'Help'),
            leading: const Icon(Icons.help),
            onTap: () {},
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: const CustomText(text: 'Account Settings'),
            leading: const Icon(Icons.person),
            onTap: () {},
            trailing: const Icon(Icons.chevron_right),
            enableFeedback: true,
          ),
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: const CustomText(text: 'Update Password'),
            leading: const Icon(Icons.visibility_off),
            onTap: () {},
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: const CustomText(text: 'Send Feeback'),
            leading: const Icon(Icons.email),
            onTap: () {},
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 1),
          child: ListTile(
            title: const CustomText(text: 'Logout'),
            leading: const Icon(Icons.logout),
            onTap: () async {
              ProfileUtils.handleLogout(context);
              // final user = await LocalStorage.readLocalStorage('_user');

              // if (user == null) {
              //   Future.delayed(const Duration(milliseconds: 500), () {
              //     BlocProvider.of<ProfileBloc>(context)
              //         .add(SetProfileLogoutEvent());
              //   });
              // }
            },
          ),
        ),
      ],
    );
  }
}
