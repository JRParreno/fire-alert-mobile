import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/features/address/presentation/screens/widgets/app_bar_search_widget.dart';
import 'package:flutter/material.dart';

class SmCustomAppBar extends AppBar {
  SmCustomAppBar({Key? key}) : super(key: key);

  SmCustomAppBar.searchBar({
    super.key,
    required BuildContext context,
    VoidCallback? onClear,
    Function(String?)? onChangeSearch,
    required TextEditingController searchControllerText,
    Color backgroundColor = ColorName.primary,
    double titleSpacing = 0,
  }) : super(
          backgroundColor: backgroundColor,
          titleSpacing: titleSpacing,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 25,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          title: AppBarSearchWidget(
            hintText: 'Search Location',
            controller: searchControllerText,
            onChanged: onChangeSearch,
            onClearText: () {
              searchControllerText.clear();
              onClear?.call();
            },
          ),
        );
}
