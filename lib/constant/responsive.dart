import 'package:flutter/material.dart';
import 'package:p/desktop/desktop-main.dart';
import 'package:p/mobile/mobile-main.dart';
import 'package:p/tablet/tablet-main.dart';

class Responsive extends StatelessWidget {
  const Responsive({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => constraints.maxWidth < 700
            ? const Mobile()
            : constraints.maxWidth < 1300
                ? const Tablet()
                : const Desktop());
  }
}
