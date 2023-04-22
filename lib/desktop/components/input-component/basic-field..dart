// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:p/constant/colorsize.dart';

class BasicField extends StatelessWidget {
  const BasicField({
    Key? key,
    required this.controller,
    required this.style,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final TextEditingController controller;
  final TextStyle style;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 60,
        width: 250,
        child: TextFormField(
          maxLines: 3,
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          style: style.copyWith(color: Colors.blue),
          decoration: InputDecoration(
            prefixIcon: SizedBox(
              width: 30,
              child: Center(
                child: Icon(
                  icon,
                  size: 16,
                  color: darkC.withOpacity(0.5),
                ),
              ),
            ),
            label: Text(label),
            labelStyle: style.copyWith(color: darkC.withOpacity(0.5)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: darkC.withOpacity(0.4))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: darkC.withOpacity(0.4))),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red)),
          ),
        ),
      ),
    );
  }
}
