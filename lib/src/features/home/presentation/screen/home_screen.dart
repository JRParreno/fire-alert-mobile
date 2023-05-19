import 'package:fire_alert_mobile/src/features/account/profile/presentation/screens/profile_screen.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/screen/fire_alert_screen.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/screen/information_screen.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/home_appbar.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/home_drawer.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/navigation/persistent_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  final _buildScreens = [
    const InformationScreen(),
    const FireAlertScreen(),
    const ProfileScreen(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.bell_fill, color: Colors.white),
        title: ("FireGuard"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: const HomeDrawer(),
        appBar: homeAppBar(
          context: context,
        ),
        body: SizedBox(
          child: PersistentBottomNavigation(
            buildScreens: _buildScreens,
            controller: _controller,
            navBarsItems: _navBarsItems(),
          ),
        ));
  }
}
