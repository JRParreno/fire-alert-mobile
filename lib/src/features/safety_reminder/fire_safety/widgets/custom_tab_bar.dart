import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorName.dimGray,
      child: TabBar(
        controller: tabController,
        enableFeedback: true,
        indicatorColor: ColorName.primary,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'HenrySans',
          fontSize: 15,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 15,
          fontFamily: 'HenrySans',
          fontWeight: FontWeight.w400,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: const <Widget>[
          Tab(
            text: 'Before',
          ),
          Tab(
            text: 'During',
          ),
          Tab(
            text: 'After',
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
