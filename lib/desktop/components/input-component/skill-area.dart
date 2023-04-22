// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/desktop/components/input-component/lang-input.dart';
import 'package:p/desktop/components/input-component/lang-list.dart';
import 'package:p/desktop/components/input-component/skill-input.dart';
import 'package:p/desktop/components/input-component/skill-list.dart';

class SkillLangInput extends StatelessWidget {
  const SkillLangInput({
    super.key,
    required this.style,
  });

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: darkC,
        borderRadius: BorderRadius.circular(30),
        elevation: 7,
        shadowColor: darkC,
        child: Container(
          height: 500,
          width: 900,
          decoration: BoxDecoration(
              color: darkC, borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "SUBMIT YOUR SKILLS",
                    style: style.copyWith(color: Colors.greenAccent),
                  ),
                  Text(
                    "Skills & Languages",
                    style: style.copyWith(
                        color: Colors.white,
                        fontSize: 57,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Whether you're a professional or a graduate, in your job hunt, your skills matter. They tell potential employers what you can do, how you can do it, and even who you are.",
                    maxLines: 3,
                    style: style.copyWith(color: Colors.white54),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SkillInput(
                            style: style,
                            label: 'Skill',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: SkillList(style: style),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          LangInput(
                            style: style,
                            label: 'Language',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: LangList(style: style),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    "I would recommend making sure you are prepared to use these tools.",
                    maxLines: 3,
                    style: style.copyWith(color: Colors.white54),
                  )
                ]),
          ),
        ));
  }
}
