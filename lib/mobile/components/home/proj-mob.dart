// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:p/constant/colorsize.dart';
import 'package:p/constant/text-style.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/database/model/project-model.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

class ProjMob extends StatelessWidget {
  final String searchId;
  ProjMob({
    Key? key,
    required this.searchId,
  }) : super(key: key);
  final projectRef = FirebaseFirestore.instance
      .collection('user')
      .doc(id)
      .collection('project');
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PROJECT',
            style: style(context).copyWith(
                color: blue1, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          Text(
            'Unleash the Talent.',
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
                  .collection('project')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  showSnackBar(
                      context, Colors.redAccent, 'Something went wrong');
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
                  List<Project> rProj = documents
                      .map((e) => Project(
                          id: e['id'],
                          name: e['name'],
                          detail: e['detail'],
                          imageUrl: e['imageUrl']))
                      .toList();

                  if (rProj.isEmpty) {
                    return const Center(
                      child: SizedBox(
                        height: 10,
                        width: 10,
                      ),
                    );
                  } else {
                    return Column(
                      children: List.generate(
                          rProj.length,
                          (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 200,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      rProj[index].imageUrl),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Positioned(
                                            top: 10,
                                            right: 10,
                                            child: InkWell(
                                              onTap: () {
                                                projectRef
                                                    .doc(rProj[index].id)
                                                    .delete();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    color: purpleC),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Icon(
                                                    CupertinoIcons.delete,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      rProj[index].name,
                                      style: style(context).copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      rProj[index].detail,
                                      style: style(context).copyWith(
                                          fontSize: 12,
                                          color: darkC.withOpacity(0.5)),
                                    ),
                                  ],
                                ),
                              )),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: darkC,
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
