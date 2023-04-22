// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:p/constant/colorsize.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/database/model/basic-model.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

class DpArea extends StatelessWidget {
  final String searchId;
  DpArea({
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
              return Center(
                child: SizedBox(
                  height: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: Image.network(
                          'https://cdn.discordapp.com/attachments/1037389109313933312/1096477804641648660/result_6.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Looks like a new User',
                            style: style.copyWith(color: blue1, fontSize: 12),
                          ),
                          Text(
                            'Add your Data in Edit Profile Section.',
                            style: style.copyWith(
                                color: darkC,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              basic[0].slogan,
                              style: style.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            SizedBox(
                              height: 400,
                              width: 700,
                              child: Image.network(
                                'https://cdn.discordapp.com/attachments/1037389109313933312/1095781081384484904/result_4.png',
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
                      )),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 450,
                      width: 700,
                      child: Stack(
                        children: [
                          const SizedBox(
                            height: 450,
                            width: 700,
                          ),
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: Container(
                              height: 350,
                              width: 230,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: purpleC,
                                  image: DecorationImage(
                                      image: NetworkImage(basic[0].dp),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              height: 350,
                              width: 230,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://cdn.dribbble.com/userupload/5427227/file/original-bcd3fb28935ea4b65fade7d0fb848226.jpg?compress=1&resize=1600x1200'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ],
                      ),
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
