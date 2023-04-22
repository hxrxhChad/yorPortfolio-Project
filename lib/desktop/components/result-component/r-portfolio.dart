// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:p/desktop/components/home-component/dp-area.dart';
import 'package:p/desktop/components/home-component/header-area.dart';
import 'package:p/desktop/components/home-component/project-area.dart';
import 'package:p/desktop/components/home-component/skill-area.dart';

class Portfolio extends StatelessWidget {
  final String searchId;
  const Portfolio({
    Key? key,
    required this.searchId,
    required this.style,
  }) : super(key: key);

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 320, right: 320, top: 87),
            child: Header(
              style: style,
              searchId: searchId,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 300, right: 300, top: 87),
              child: DpArea(
                style: style,
                searchId: searchId,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 77),
            child: SkillArea(
              style: style,
              searchId: searchId,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 300, right: 300, top: 87),
            child: ProjectArea(
              style: style,
              searchId: searchId,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 40 * 2, bottom: 40 * 2),
              child: SizedBox(
                  height: 400,
                  width: 600,
                  child: Image.network(
                      "https://cdn.discordapp.com/attachments/1037389109313933312/1091698338807685241/original-247e797815e0299422db0d7afce3b73b_magic.jpg",
                      fit: BoxFit.cover))),
          Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Text("THANKS FOR VISITING!",
                  style: style.copyWith(color: Colors.black54, fontSize: 20))),
        ],
      ),
    );
  }
}
