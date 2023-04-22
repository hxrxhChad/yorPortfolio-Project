// ignore_for_file: file_names, avoid_print

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/database/model/skill-model.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

class SkillList extends StatelessWidget {
  SkillList({
    super.key,
    required this.style,
  });

  final TextStyle style;
  final skillRef =
      FirebaseFirestore.instance.collection('user').doc(id).collection('skill');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: skillRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            showSnackBar(context, Colors.redAccent, 'Something went wrong');
          }
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;
            List<Skill> rSkill = documents
                .map((e) => Skill(id: e['id'], skill: e['skill']))
                .toList();
            return Row(
                children: List.generate(
                    rSkill.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  const Icon(
                                    AntIcons.sketchOutlined,
                                    color: darkC,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    rSkill[index].skill,
                                    style: style,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      skillRef.doc(rSkill[index].id).delete();
                                    },
                                    child: const Icon(
                                      AntIcons.deleteFilled,
                                      color: darkC,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )));
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.greenAccent,
              ),
            );
          }
        });
  }
}
