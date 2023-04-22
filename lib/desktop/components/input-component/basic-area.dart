// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/desktop/components/input-component/basic-input.dart';

class BasicArea extends StatelessWidget {
  const BasicArea({
    super.key,
    required this.style,
  });

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 500,
          width: 1000,
          decoration: const BoxDecoration(color: Colors.white),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: Material(
              color: Colors.blue,
              elevation: 7,
              shadowColor: darkC,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 480,
                width: 880,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            )),
        Positioned(
            top: 0,
            left: 0,
            child: Material(
              color: Colors.white,
              elevation: 7,
              shadowColor: darkC,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 480,
                width: 880,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "YOUR PERSONAL DETAILS",
                              style: style.copyWith(color: Colors.blue),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Enter your personal details, \nthat will be displayed as a \nheading to your portfolio.",
                              style: style.copyWith(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 200,
                              width: 300,
                              child: Image.network(
                                'https://cdn.discordapp.com/attachments/1037389109313933312/1096477804641648660/result_6.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        color: darkC.withOpacity(0.3),
                      ),
                      Expanded(
                        flex: 6,
                        child: BasicInput(style: style),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
