// ignore_for_file: prefer_constructors_over_static_methods

import 'package:flutter/material.dart';

class Vspace extends StatelessWidget {
  final double size;
  const Vspace(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
    );
  }

  static Vspace get xxs => const Vspace(4);
  static Vspace get xs => const Vspace(8);
  static Vspace get sm => const Vspace(16);
  static Vspace get md => const Vspace(24);
  static Vspace get lg => const Vspace(32);
  static Vspace get xl => const Vspace(64);
}
