// ignore_for_file: file_names

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/database/model/project-model.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

class ProjectList extends StatelessWidget {
  ProjectList({
    super.key,
    required this.style,
  });

  final TextStyle style;
  final projectRef = FirebaseFirestore.instance
      .collection('user')
      .doc(id)
      .collection('project');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: projectRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            showSnackBar(context, Colors.redAccent, 'Something went wrong');
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
            return GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    crossAxisCount: 3,
                    childAspectRatio: 5),
                itemCount: rProj.length,
                itemBuilder: (context, index) => Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          color: darkC, borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              rProj[index].name,
                              style: style.copyWith(color: Colors.white),
                            ),
                            InkWell(
                              onTap: () {
                                projectRef.doc(rProj[index].id).delete();
                              },
                              child: const Icon(
                                AntIcons.deleteFilled,
                                color: Colors.white,
                                size: 17,
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
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
