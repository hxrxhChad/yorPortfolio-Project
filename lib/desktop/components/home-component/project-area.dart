// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:p/constant/colorsize.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/database/model/project-model.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

class ProjectArea extends StatelessWidget {
  final String searchId;
  ProjectArea({
    Key? key,
    required this.searchId,
    required this.style,
  }) : super(key: key);

  final TextStyle style;
  final projectRef = FirebaseFirestore.instance
      .collection('user')
      .doc(id)
      .collection('project');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("PROJECT SECTION ---",
                  style: style.copyWith(
                    color: Colors.black54,
                  )),
              Text("Check out my Projects",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Colors.black54,
                      fontSize: 40,
                      fontWeight: FontWeight.bold)),
              Text("--- 03",
                  style: style.copyWith(color: Colors.black54, fontSize: 30)),
            ]),
        const SizedBox(height: 40),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('user')
                .doc(searchId)
                .collection('project')
                .snapshots(),
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
                if (rProj.isEmpty) {
                  return const SizedBox(
                    height: 1,
                  );
                } else {
                  return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              childAspectRatio: 9 / 10),
                      itemCount: rProj.length,
                      itemBuilder: (context, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: darkC,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              rProj[index].imageUrl),
                                          fit: BoxFit.cover)),
                                ),
                                const SizedBox(height: 40 / 3),
                                Text(rProj[index].name,
                                    style: style.copyWith(color: Colors.black)),
                                const SizedBox(height: 40 / 4),
                                Text(rProj[index].detail,
                                    maxLines: 5,
                                    style:
                                        style.copyWith(color: Colors.black54)),
                              ]));
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: darkC,
                  ),
                );
              }
            }),
        const SizedBox(height: 40),
      ],
    );
  }
}
