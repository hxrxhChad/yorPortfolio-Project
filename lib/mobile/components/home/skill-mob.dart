// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:p/constant/colorsize.dart';
import 'package:p/constant/text-style.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/database/model/lang-model.dart';
import 'package:p/database/model/skill-model.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

class SkillMob extends StatelessWidget {
  final String searchId;
  SkillMob({
    Key? key,
    required this.searchId,
  }) : super(key: key);

  final skillRef =
      FirebaseFirestore.instance.collection('user').doc(id).collection('skill');
  final langRef = FirebaseFirestore.instance
      .collection('user')
      .doc(id)
      .collection('language');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'EXCLUSIVNESS',
          style: style(context).copyWith(
              color: pink1, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text(
          'Skill & Knowledge',
          style: style(context).copyWith(
              color: darkC, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('user')
                .doc(searchId)
                .collection('skill')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                showSnackBar(context, Colors.redAccent, 'Something went wrong');
              }
              if (!snapshot.hasData) {
                return const SizedBox(
                  height: 50,
                  width: 100,
                );
              }
              if (snapshot.hasData) {
                QuerySnapshot querySnapshot = snapshot.data!;
                List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                List<Skill> skill = documents
                    .map((e) => Skill(id: e['id'], skill: e['skill']))
                    .toList();
                //
                if (skill.isEmpty) {
                  return const Center(
                    child: SizedBox(
                      height: 10,
                      width: 10,
                    ),
                  );
                } else {
                  return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              crossAxisCount: 3,
                              childAspectRatio: 3),
                      itemCount: skill.length,
                      itemBuilder: (context, index) => Container(
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(3)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    skill[index].skill,
                                    style: style(context)
                                        .copyWith(color: Colors.white),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        skillRef.doc(skill[index].id).delete();
                                      },
                                      child: const Icon(
                                        CupertinoIcons.delete,
                                        color: Colors.white,
                                        size: 17,
                                      ))
                                ],
                              ),
                            ),
                          ));
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: darkC,
                  ),
                );
              }
            }),
        const SizedBox(
          height: 30,
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('user')
                .doc(searchId)
                .collection('language')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                showSnackBar(context, Colors.redAccent, 'Something went wrong');
              }
              if (!snapshot.hasData) {
                return const SizedBox(
                  height: 50,
                  width: 100,
                );
              }
              if (snapshot.hasData) {
                QuerySnapshot querySnapshot = snapshot.data!;
                List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                List<Language> lang = documents
                    .map((e) => Language(id: e['id'], language: e['language']))
                    .toList();
                //
                if (lang.isEmpty) {
                  return const Center(
                    child: SizedBox(
                      height: 10,
                      width: 10,
                    ),
                  );
                } else {
                  return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              crossAxisCount: 3,
                              childAspectRatio: 3),
                      itemCount: lang.length,
                      itemBuilder: (context, index) => Container(
                            decoration: BoxDecoration(
                                color: purpleC,
                                borderRadius: BorderRadius.circular(3)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    lang[index].language,
                                    style: style(context)
                                        .copyWith(color: Colors.white),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        langRef.doc(lang[index].id).delete();
                                      },
                                      child: const Icon(
                                        CupertinoIcons.delete,
                                        color: Colors.white,
                                        size: 17,
                                      ))
                                ],
                              ),
                            ),
                          ));
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: darkC,
                  ),
                );
              }
            }),
      ],
    );
  }
}
