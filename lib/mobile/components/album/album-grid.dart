// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:p/constant/colorsize.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/database/model/photo-model.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

class AlbumGrid extends StatelessWidget {
  final String searchId;
  AlbumGrid({
    Key? key,
    required this.searchId,
  }) : super(key: key);
  final photoRef =
      FirebaseFirestore.instance.collection('user').doc(id).collection('photo');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(searchId)
            .collection('photo')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            showSnackBar(context, Colors.redAccent, 'Something went wrong');
          }
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;
            List<Photo> photo = documents
                .map((e) => Photo(id: e['id'], photo: e['photo']))
                .toList();
            return Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: MasonryGridView.builder(
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemCount: photo.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(right: 25, bottom: 25),
                        child: GestureDetector(
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
                                                decoration: const BoxDecoration(
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
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              color: purpleC,
                                                              shape: BoxShape
                                                                  .circle),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: Icon(
                                                          CupertinoIcons
                                                              .arrow_left,
                                                          color: Colors.white,
                                                          size: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        )));
                          },
                          child: Image.network(
                            photo[index].photo,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
            );
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
