// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';

class HoverTextBox extends StatefulWidget {
  const HoverTextBox({
    Key? key,
    required this.text,
    required this.pressed,
    required this.style,
  }) : super(key: key);

  final String text;
  final void Function() pressed;
  final TextStyle style;

  @override
  State<HoverTextBox> createState() => _HoverTextBoxState();
}

class _HoverTextBoxState extends State<HoverTextBox> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onHover: (event) {
          setState(() {
            _isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            _isHover = false;
          });
        },
        child: InkWell(
          onTap: widget.pressed,
          child: Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
                color: _isHover ? purpleC : Colors.transparent,
                border: Border.all(
                  color: _isHover ? Colors.transparent : darkC.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(7)),
            child: Center(
              child: Text(
                widget.text,
                style: widget.style
                    .copyWith(color: _isHover ? Colors.white : darkC),
              ),
            ),
          ),
        ));
  }
}
