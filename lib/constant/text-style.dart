// ignore_for_file: file_names

import 'package:flutter/material.dart';

TextStyle style(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .headlineSmall!
      .copyWith(fontSize: 14, fontWeight: FontWeight.w400);
}
