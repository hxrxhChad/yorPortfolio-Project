// ignore_for_file: file_names

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

class LangInput extends StatelessWidget {
  LangInput({
    Key? key,
    required this.style,
    required this.label,
  }) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final TextStyle style;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20.0),
      child: SizedBox(
        height: 35,
        width: 170,
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.white,
          textAlignVertical: TextAlignVertical.center,
          style: style.copyWith(color: Colors.white),
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: () async {
                try {
                  await addLang(context, controller.text);
                } catch (e) {
                  showSnackBar(context, purpleC, e.toString());
                }
              },
              child: const SizedBox(
                width: 30,
                child: Center(
                  child: Icon(
                    AntIcons.checkOutlined,
                    size: 16,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
            prefixIcon: const SizedBox(
              width: 30,
              child: Center(
                child: Icon(
                  AntIcons.sketchOutlined,
                  size: 16,
                  color: Colors.orange,
                ),
              ),
            ),
            label: Text(label),
            labelStyle: style.copyWith(color: Colors.orange),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.orange)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.orange)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red)),
          ),
        ),
      ),
    );
  }
}
