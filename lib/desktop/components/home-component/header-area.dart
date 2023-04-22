// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:p/constant/colorsize.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/database/model/basic-model.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

class Header extends StatelessWidget {
  final String searchId;
  Header({
    Key? key,
    required this.searchId,
    required this.style,
  }) : super(key: key);

  final TextStyle style;
  final basicRef =
      FirebaseFirestore.instance.collection('user').doc(id).collection('basic');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(searchId)
            .collection('basic')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            showSnackBar(context, Colors.redAccent, 'Something went wrong');
          }
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "WELCOME TO THE PORTFOLIO OF",
                    style: style.copyWith(color: purpleC),
                  ),
                  Text(
                    basic[0].name,
                    style: style.copyWith(
                        fontSize: 57,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 130.0),
                    child: Text(
                      basic[0].about,
                      textAlign: TextAlign.center,
                      style: style.copyWith(color: Colors.black45),
                    ),
                  ),
                ],
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: darkC,
              ),
            );
          }
        });
  }
}
