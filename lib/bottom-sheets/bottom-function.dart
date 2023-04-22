// ignore_for_file: file_names

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';

void goBottomSheet(
  BuildContext context,
  Widget mobile,
  Widget tablet,
  Widget desktop,
) {
  Size pad = MediaQuery.of(context).size;
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (builder) => SizedBox(
            height: pad.height * 0.99,
            width: pad.width,
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 5,
                        width: 70,
                        decoration: BoxDecoration(
                            color: darkC.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: LayoutBuilder(
                              builder: (context, constraints) =>
                                  constraints.maxWidth < 700
                                      ? mobile
                                      : constraints.maxWidth < 1100
                                          ? tablet
                                          : desktop))
                    ],
                  ),
                ),
                Positioned(
                    right: 30,
                    top: 30,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                            color: purpleC, shape: BoxShape.circle),
                        child: const Center(
                          child: Icon(
                            AntIcons.closeOutlined,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ));
}
