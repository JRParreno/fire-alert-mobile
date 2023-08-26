import 'package:flutter/material.dart';

class SafetyReminderCard extends StatelessWidget {
  const SafetyReminderCard({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });

  final String title;
  final ImageProvider image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink.image(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.90,
        image: image,
        fit: BoxFit.fill,
        child: InkWell(
          onTap: onTap,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
