// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/desktop/components/input-component/add-project.dart';
import 'package:p/desktop/components/input-component/proj-list.dart';

class IProjectArea extends StatelessWidget {
  const IProjectArea({
    super.key,
    required this.style,
  });

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "PROJECT SECTION",
          style: style.copyWith(color: Colors.deepOrange),
        ),
        Text(
          "Enter your project details",
          style: style.copyWith(
              color: darkC, fontSize: 57, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProjectList(style: style),
                    const SizedBox(
                      height: 30,
                    ),
                    AddProject(
                      style: style,
                    ),
                  ],
                )),
            const SizedBox(
              width: 50,
            ),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Image.network(
                    'https://cdn.discordapp.com/attachments/1037389109313933312/1096477148019167353/result_5.png',
                    fit: BoxFit.cover,
                  ),
                ))
          ],
        )
      ],
    );
  }
}
