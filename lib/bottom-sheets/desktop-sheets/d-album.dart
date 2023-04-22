// ignore_for_file: file_names, avoid_web_libraries_in_flutter, use_build_context_synchronously

import 'dart:html';

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/database/model/photo-model.dart';
import 'package:p/desktop/components/album-component/hover-text-box.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

class DAlbum extends StatefulWidget {
  const DAlbum({super.key});

  @override
  State<DAlbum> createState() => _DAlbumState();
}

class _DAlbumState extends State<DAlbum> {
  String? imageUrl;
  final photoRef =
      FirebaseFirestore.instance.collection('user').doc(id).collection('photo');

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(color: darkC, fontWeight: FontWeight.w500, fontSize: mediumT);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              'Photos.',
              style: style.copyWith(fontWeight: FontWeight.bold, fontSize: 70),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                  width: 400,
                  child: Image.network(
                      'https://cdn.discordapp.com/attachments/1037389109313933312/1092161311904911380/result_1.png'),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  height: 140,
                  width: 250,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: 'ALBUM\n',
                                  style: style.copyWith(color: purpleC)),
                              TextSpan(
                                text:
                                    'Add your photos to the album & share with your Friends.',
                                style: style.copyWith(
                                    color: darkC.withOpacity(0.5)),
                              ),
                            ])),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                HoverTextBox(
                                    text: 'Upload',
                                    pressed: () {
                                      //
                                      try {
                                        FileUploadInputElement input =
                                            FileUploadInputElement()
                                              ..accept = 'image/*';
                                        FirebaseStorage fs =
                                            FirebaseStorage.instance;
                                        input.click();
                                        input.onChange.listen((event) {
                                          final file = input.files!.first;
                                          final reader = FileReader();
                                          reader.readAsDataUrl(file);
                                          String uniqueFileName = DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString();

                                          reader.onLoadEnd
                                              .listen((event) async {
                                            var snapshot = await fs
                                                .ref()
                                                .child('Image/$uniqueFileName')
                                                .putBlob(file);
                                            String downloadUrl = await snapshot
                                                .ref
                                                .getDownloadURL()
                                                .whenComplete(() {
                                              //
                                              showSnackBar(context, purpleC,
                                                  'Upload Complete');
                                            });
                                            setState(() {
                                              imageUrl = downloadUrl;
                                              debugPrint(imageUrl);
                                            });
                                            addPhoto(context, imageUrl);
                                          });
                                        });
                                      } catch (e) {
                                        debugPrint(e.toString());
                                      }
                                      //
                                    },
                                    style: style),
                                const SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  imageUrl == null
                                      ? null
                                      : AntIcons.checkOutlined,
                                  color: darkC,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Album',
              style: style.copyWith(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: StreamBuilder<QuerySnapshot>(
                  stream: photoRef.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      showSnackBar(
                          context, Colors.redAccent, 'Something went wrong');
                    }
                    if (snapshot.hasData) {
                      QuerySnapshot querySnapshot = snapshot.data!;
                      List<QueryDocumentSnapshot> documents =
                          querySnapshot.docs;
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
                                                              decoration: const BoxDecoration(
                                                                  color:
                                                                      purpleC,
                                                                  shape: BoxShape
                                                                      .circle),
                                                              child:
                                                                  const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
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
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image:
                                              NetworkImage(photo[index].photo),
                                          fit: BoxFit.cover),
                                    ),
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
      ),
    );
  }
}
