// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:p/constant/colorsize.dart';
import 'package:p/constant/text-style.dart';
import 'package:p/database/model/basic-model.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

class DpMob extends StatelessWidget {
  final String searchId;
  const DpMob({
    Key? key,
    required this.searchId,
  }) : super(key: key);

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
          if (!snapshot.hasData) {
            return const SizedBox(
              height: 50,
              width: 100,
            );
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
              return SizedBox(
                height: 600,
                width: 350,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.network(
                          'https://cdn.discordapp.com/attachments/1037389109313933312/1096477804641648660/result_6.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Looks like a new User',
                            style: style(context)
                                .copyWith(color: blue1, fontSize: 12),
                          ),
                          Text(
                            'Add your Data in Edit Profile Section.',
                            textAlign: TextAlign.center,
                            style: style(context).copyWith(
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
              return Column(
                children: [
                  Container(
                    height: 350,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        image: DecorationImage(
                            image: NetworkImage(basic[0].dp),
                            fit: BoxFit.cover)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: pink1,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: Text(
                                basic[0].name,
                                style: style(context).copyWith(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: blue1,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: Text(
                                basic[0].bio,
                                style: style(context).copyWith(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'About',
                    style: style(context)
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    basic[0].about,
                    textAlign: TextAlign.center,
                    style: style(context)
                        .copyWith(color: darkC.withOpacity(0.5), fontSize: 12),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    '"${basic[0].slogan}"',
                    textAlign: TextAlign.center,
                    style: style(context)
                        .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }
            //
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
