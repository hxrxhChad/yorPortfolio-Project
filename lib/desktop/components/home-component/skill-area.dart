// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:p/constant/colorsize.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/database/model/basic-model.dart';
import 'package:p/database/model/lang-model.dart';
import 'package:p/database/model/skill-model.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

class SkillArea extends StatelessWidget {
  final String searchId;
  SkillArea({
    Key? key,
    required this.searchId,
    required this.style,
  }) : super(key: key);

  final TextStyle style;
  final basicRef =
      FirebaseFirestore.instance.collection('user').doc(id).collection('basic');
  final skillRef =
      FirebaseFirestore.instance.collection('user').doc(id).collection('skill');
  final langRef = FirebaseFirestore.instance
      .collection('user')
      .doc(id)
      .collection('language');

  @override
  Widget build(BuildContext context) {
    Size pad = MediaQuery.of(context).size;
    return Material(
      elevation: 20,
      shadowColor: darkC,
      child: Container(
          height: 800,
          width: double.infinity,
          decoration: const BoxDecoration(color: darkC),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: pad.width < 1300 ? 20 : 200, vertical: 80),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "MY SKILLS",
                        style: style.copyWith(color: Colors.white),
                      ),
                      Text(
                        "Know my skills & Knowledge.",
                        style: style.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Skill is the knowledge and ability that enables you to do something well.The cut of a diamond depends on the skill of its craftsman. ",
                        style: style.copyWith(color: Colors.white38),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Container(
                          height: 300,
                          width: 450,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  bottomLeft: Radius.circular(40)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://cdn.discordapp.com/attachments/1037389109313933312/1091698339118059531/original-e15929059bbc6411c5114773426cdccf.jpg'),
                                  fit: BoxFit.cover)))
                    ],
                  ),
                ),
                const VerticalDivider(color: Colors.white24),
                Expanded(
                  flex: 1,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("ABOUT ME",
                                            style: style.copyWith(
                                                color: Colors.white70)),
                                        Text("99%",
                                            style: style.copyWith(
                                                fontSize: 70,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('user')
                                                  .doc(searchId)
                                                  .collection('basic')
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasError) {
                                                  showSnackBar(
                                                      context,
                                                      Colors.redAccent,
                                                      'Something went wrong');
                                                }
                                                if (snapshot.hasData) {
                                                  QuerySnapshot querySnapshot =
                                                      snapshot.data!;
                                                  List<QueryDocumentSnapshot>
                                                      documents =
                                                      querySnapshot.docs;
                                                  List<Basic> basic = documents
                                                      .map((e) => Basic(
                                                          id: e['id'],
                                                          name: e['name'],
                                                          bio: e['bio'],
                                                          slogan: e['slogan'],
                                                          about: e['about'],
                                                          dp: e['dp']))
                                                      .toList();
                                                  if (basic.isEmpty) {
                                                    return const SizedBox(
                                                      height: 1,
                                                    );
                                                  } else {
                                                    return Text(basic[0].bio,
                                                        maxLines: 9,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: style.copyWith(
                                                            color: Colors
                                                                .white38));
                                                  }
                                                } else {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.white,
                                                    ),
                                                  );
                                                }
                                              }),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                            const SizedBox(height: 40 / 2),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 103, 65, 216)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 40 / 2, horizontal: 40),
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(searchId)
                                            .collection('skill')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            showSnackBar(
                                                context,
                                                Colors.redAccent,
                                                'Something went wrong');
                                          }

                                          if (snapshot.hasData) {
                                            QuerySnapshot querySnapshot =
                                                snapshot.data!;
                                            List<QueryDocumentSnapshot>
                                                documents = querySnapshot.docs;
                                            List<Skill> skill = documents
                                                .map((e) => Skill(
                                                    id: e['id'],
                                                    skill: e['skill']))
                                                .toList();
                                            if (skill.isEmpty) {
                                              return const SizedBox(
                                                height: 1,
                                              );
                                            } else {
                                              return GridView.builder(
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          mainAxisSpacing: 20,
                                                          childAspectRatio: 3),
                                                  itemCount: skill.length,
                                                  itemBuilder: (context,
                                                          index) =>
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                "SKILL NO. ${index + 1}",
                                                                style: style.copyWith(
                                                                    color: Colors
                                                                        .white70,
                                                                    fontSize:
                                                                        10)),
                                                            Text(
                                                                skill[index]
                                                                    .skill,
                                                                style: style.copyWith(
                                                                    fontSize:
                                                                        27,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white)),
                                                          ]));
                                            }
                                          } else {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            );
                                          }
                                        }),
                                  ),
                                )),
                            const SizedBox(height: 40 / 2),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.white60)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 40 / 2, horizontal: 40),
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(searchId)
                                            .collection('language')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            showSnackBar(
                                                context,
                                                Colors.redAccent,
                                                'Something went wrong');
                                          }

                                          if (snapshot.hasData) {
                                            QuerySnapshot querySnapshot =
                                                snapshot.data!;
                                            List<QueryDocumentSnapshot>
                                                documents = querySnapshot.docs;
                                            List<Language> lang = documents
                                                .map((e) => Language(
                                                    id: e['id'],
                                                    language: e['language']))
                                                .toList();
                                            if (lang.isEmpty) {
                                              return const SizedBox(
                                                height: 1,
                                              );
                                            } else {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "KNOWLEDGE",
                                                    style: style.copyWith(
                                                        color: Colors.white70,
                                                        fontSize: 10),
                                                  ),
                                                  Text(lang[0].language,
                                                      style: style.copyWith(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white)),
                                                  Text(
                                                    "I know technologies like, ${lang[1].language}, ${lang[2].language}, ${lang[3].language} &",
                                                    style: style.copyWith(
                                                        color: Colors.white54,
                                                        fontSize: 14),
                                                  ),
                                                  Text(
                                                    lang[4].language,
                                                    style: style.copyWith(
                                                        color: Colors.white54,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              );
                                            }
                                          } else {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            );
                                          }
                                        }),
                                  ),
                                )),
                          ])),
                ),
              ],
            ),
          )),
    );
  }
}
