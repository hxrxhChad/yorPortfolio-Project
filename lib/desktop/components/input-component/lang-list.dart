// ignore_for_file: file_names

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/database/model/lang-model.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

class LangList extends StatelessWidget {
  LangList({
    super.key,
    required this.style,
  });

  final TextStyle style;
  final langRef = FirebaseFirestore.instance
      .collection('user')
      .doc(id)
      .collection('language');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: langRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            showSnackBar(context, Colors.redAccent, 'Something went wrong');
          }
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;
            List<Language> rLang = documents
                .map((e) => Language(id: e['id'], language: e['language']))
                .toList();
            return Row(
                children: List.generate(
                    rLang.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.orange,
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
                                    rLang[index].language,
                                    style: style,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      langRef.doc(rLang[index].id).delete();
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
                color: Colors.orange,
              ),
            );
          }
        });
  }
}
