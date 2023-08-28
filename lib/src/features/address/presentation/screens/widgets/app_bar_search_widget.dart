import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class AppBarSearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?)? onChanged;
  final VoidCallback? onTap;
  final bool isReadOnly;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final Color searchIconColor;
  final VoidCallback? onClearText;
  const AppBarSearchWidget({
    super.key,
    required this.controller,
    this.onChanged,
    this.onTap,
    this.isReadOnly = false,
    this.hintText,
    this.hintTextStyle,
    this.searchIconColor = ColorName.placeHolder,
    this.onClearText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
        top: 6,
        bottom: 6,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        autocorrect: false,
        readOnly: isReadOnly,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          isDense: true,
          prefixIcon: Icon(
            Icons.search,
            color: searchIconColor,
            size: 24,
          ),
          hintStyle: hintTextStyle ??
              const TextStyle(
                color: ColorName.placeHolder,
                fontSize: 14,
              ),
          hintText: hintText,
          suffixIcon: Visibility(
            visible: controller.text.isNotEmpty,
            child: IconButton(
              onPressed: onClearText ?? controller.clear,
              icon: const Icon(
                Icons.close,
                size: 20,
                color: ColorName.placeHolder,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
