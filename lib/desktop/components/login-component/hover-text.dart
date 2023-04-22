// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';

class HoverText extends StatefulWidget {
  const HoverText({
    Key? key,
    required this.text,
    required this.pressed,
  }) : super(key: key);

  final String text;
  final void Function() pressed;

  @override
  State<HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(color: darkC, fontWeight: FontWeight.w500, fontSize: mediumT);
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
          child: Text(
            widget.text,
            style: style.copyWith(
                color: _isHover ? darkC : purpleC,
                fontWeight: _isHover ? FontWeight.bold : FontWeight.w500),
          ),
        ));
  }
}
