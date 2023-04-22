// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:p/constant/colorsize.dart';
import 'package:p/database/model/photo-model.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

class RPhoto extends StatelessWidget {
  final String searchId;
  const RPhoto({
    Key? key,
    required this.searchId,
    required this.style,
  }) : super(key: key);

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'Photos.',
            style: style.copyWith(fontWeight: FontWeight.bold, fontSize: 70),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('user')
                    .doc(searchId)
                    .collection('photo')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    showSnackBar(
                        context, Colors.redAccent, 'Something went wrong');
                  }
                  if (snapshot.hasData) {
                    QuerySnapshot querySnapshot = snapshot.data!;
                    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                    List<Photo> photo = documents
                        .map((e) => Photo(id: e['id'], photo: e['photo']))
                        .toList();
                    return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: photo.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(5),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Scaffold(
                                                body: Stack(
                                                  children: [
                                                    Container(
                                                      height: double.infinity,
                                                      width: double.infinity,
                                                      decoration:
                                                          const BoxDecoration(
                                                              color: darkC),
                                                      child: Image.network(
                                                        photo[index].photo,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    Positioned(
                                                        top: 20,
                                                        left: 20,
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                                    color:
                                                                        purpleC,
                                                                    shape: BoxShape
                                                                        .circle),
                                                            child:
                                                                const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: Icon(
                                                                CupertinoIcons
                                                                    .arrow_left,
                                                                color: Colors
                                                                    .white,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              )));
                                },
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      image: DecorationImage(
                                          image:
                                              NetworkImage(photo[index].photo),
                                          fit: BoxFit.cover)),
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
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 600,
            width: 600,
            child: Image.network(
              'https://cdn.discordapp.com/attachments/1037389109313933312/1091698338807685241/original-247e797815e0299422db0d7afce3b73b_magic.jpg',
            ),
          )
        ],
      ),
    );
  }
}
