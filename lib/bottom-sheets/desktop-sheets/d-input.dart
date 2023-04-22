// ignore_for_file: file_names
import 'package:flutter/material.dart';

import 'package:p/constant/colorsize.dart';
import 'package:p/constant/responsive.dart';
import 'package:p/desktop/components/album-component/hover-text-box.dart';
import 'package:p/desktop/components/input-component/basic-area.dart';
import 'package:p/desktop/components/input-component/project-area.dart';
import 'package:p/desktop/components/input-component/skill-area.dart';

class DInput extends StatelessWidget {
  const DInput({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(color: darkC, fontWeight: FontWeight.w500, fontSize: mediumT);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 320, right: 320, top: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DefaultTextStyle(
                    style: style.copyWith(
                        fontSize: 22, fontWeight: FontWeight.bold),
                    child: const Text.rich(TextSpan(children: [
                      TextSpan(text: "yor", style: TextStyle(color: purpleC)),
                      TextSpan(text: "Portfolio")
                    ])),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 25,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: darkC.withOpacity(0.1)),
                      child: Center(
                        child: Text(
                          "Back",
                          style: style.copyWith(color: darkC),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 87, left: 320, right: 320),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "BUILD YOUR PORTFOLIO",
                    style: style.copyWith(color: Colors.blue),
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "Enter your Details\n",
                      style: style.copyWith(
                          color: darkC,
                          fontSize: 57,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "inside the ",
                      style: style.copyWith(
                          color: darkC,
                          fontSize: 57,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "<",
                      style: style.copyWith(
                          color: Colors.blue,
                          fontSize: 57,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "field",
                      style: style.copyWith(
                          color: darkC,
                          fontSize: 57,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ">",
                      style: style.copyWith(
                          color: Colors.blue,
                          fontSize: 57,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: " to",
                      style: style.copyWith(
                          color: darkC,
                          fontSize: 57,
                          fontWeight: FontWeight.bold),
                    ),
                  ])),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Get a wonderful portfolio, with a very minimum effort.",
                    style: style.copyWith(color: darkC.withOpacity(0.9)),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 320, vertical: 60),
              child: BasicArea(style: style),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 60),
              child: IProjectArea(style: style),
            ),
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 320, vertical: 40),
              child: SkillLangInput(style: style),
            ),
            const SizedBox(
              height: 50,
            ),
            HoverTextBox(
                text: 'Continue',
                pressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Responsive()));
                },
                style: style),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 400,
              width: 400,
              child: Image.network(
                'https://cdn.discordapp.com/attachments/1037389109313933312/1096481781538103517/result_7.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
