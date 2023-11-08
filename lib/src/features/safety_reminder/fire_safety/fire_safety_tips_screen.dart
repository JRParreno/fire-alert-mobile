import 'dart:convert';

import 'package:fire_alert_mobile/gen/assets.gen.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/home_appbar.dart';
import 'package:fire_alert_mobile/src/features/safety_reminder/fire_safety/widgets/content_tab.dart';
import 'package:fire_alert_mobile/src/features/safety_reminder/fire_safety/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FireSafetyTipsScreen extends StatefulWidget {
  const FireSafetyTipsScreen({super.key});

  static const String routeName = '/fire-safety-tips-screen';

  @override
  State<FireSafetyTipsScreen> createState() => _FireSafetyTipsScreenState();
}

class _FireSafetyTipsScreenState extends State<FireSafetyTipsScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  List<String> beforeListText = [];
  List<String> duringListText = [];
  List<String> afterListText = [];
  List<String> atHomeListText = [];
  List<String> atWorkplaceListText = [];

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    handleLoadFixture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(
        context: context,
        title: 'Fire Safety Tips',
        backgroundColor: Colors.white,
        isDark: false,
        bottom: CustomTabBar(tabController: _tabController),
      ),
      body: TabBarView(controller: _tabController, children: [
        ContentTab(
          imageWidget: Assets.images.fireSafetyTabs.beforeFire.image(),
          isLoading: beforeListText.isEmpty,
          content: beforeListText,
        ),
        ContentTab(
          imageWidget: Assets.images.fireSafetyTabs.duringFire.image(),
          isLoading: duringListText.isEmpty,
          content: duringListText,
        ),
        ContentTab(
          imageWidget: Assets.images.fireSafetyTabs.afterFire.image(),
          isLoading: afterListText.isEmpty,
          content: afterListText,
        ),
        ContentTab(
          imageWidget: Assets.images.fireSafetyTabs.atHomeFire.image(),
          isLoading: atHomeListText.isEmpty,
          content: atHomeListText,
        ),
        ContentTab(
          imageWidget: Assets.images.fireSafetyTabs.atWorkplaceFire.image(),
          isLoading: atWorkplaceListText.isEmpty,
          content: atWorkplaceListText,
        )
      ]),
    );
  }

  Future<void> handleLoadFixture() async {
    final jsonPath = Assets.fixtures.fireSafetyTips;
    final jsonResponse = await rootBundle.loadString(jsonPath);
    final jsonDecode = await json.decode(jsonResponse);
    final content = jsonDecode['content'];
    setState(() {
      beforeListText = List<String>.from(content['before']);
      duringListText = List<String>.from(content['during']);
      afterListText = List<String>.from(content['after']);
      atHomeListText = List<String>.from(content['at_home']);
      atWorkplaceListText = List<String>.from(content['at_workplace']);
    });
  }
}
