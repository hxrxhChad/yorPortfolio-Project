// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';

class HoverAccount extends StatefulWidget {
  const HoverAccount({
    Key? key,
    required this.icon,
    required this.pressed,
  }) : super(key: key);

  final IconData icon;
  final void Function() pressed;

  @override
  State<HoverAccount> createState() => _HoverAccountState();
}

class _HoverAccountState extends State<HoverAccount> {
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
        child: Material(
          color: _isHover ? purpleC : Colors.white,
          elevation: 15,
          shadowColor:
              _isHover ? darkC.withOpacity(0.1) : purpleC.withOpacity(0.1),
          shape: const CircleBorder(),
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: _isHover
                          ? purpleC.withOpacity(0.0)
                          : darkC.withOpacity(0.3)),
                  color: _isHover ? purpleC : Colors.white,
                  shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  widget.icon,
                  color: _isHover ? Colors.white : darkC,
                  size: 17,
                ),
              )),
        ),
      ),
    );
  }
}
