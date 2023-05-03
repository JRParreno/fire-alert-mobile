import 'package:flutter/material.dart';

class CommonDialog {
  static Future<void> showMyDialog({
    required BuildContext context,
    required String title,
    required String body,
    bool isError = false,
    String? btnTitle,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  body,
                  style: TextStyle(color: isError ? Colors.red : null),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(btnTitle ?? "Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
