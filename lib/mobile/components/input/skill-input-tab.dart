// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/constant/text-style.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/desktop/components/input-component/lang-input.dart';
import 'package:p/desktop/components/input-component/skill-input.dart';
import 'package:p/mobile/components/home/skill-mob.dart';

class SkillInputTab extends StatelessWidget {
  const SkillInputTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7), color: darkC),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SkillInput(
                      style: style(context).copyWith(fontSize: 12),
                      label: 'Skill'),
                  LangInput(
                      style: style(context).copyWith(fontSize: 12),
                      label: 'Language'),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 25.0,
              right: 25.0,
            ),
            child: SkillMob(
              searchId: id,
            ),
          ),
        ]),
      ),
    );
  }
}
