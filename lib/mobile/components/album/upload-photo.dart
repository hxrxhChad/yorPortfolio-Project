// ignore_for_file: file_names, avoid_web_libraries_in_flutter, use_build_context_synchronously
import 'dart:html';

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/constant/text-style.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/desktop/components/album-component/hover-text-box.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto({super.key});

  @override
  State<UploadPhoto> createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  String? imageUrl;
  bool uploading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                          style: style(context).copyWith(color: purpleC)),
                      TextSpan(
                        text:
                            'Add your photos to the album & share with your Friends.',
                        style: style(context)
                            .copyWith(color: darkC.withOpacity(0.5)),
                      ),
                    ])),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HoverTextBox(
                            text: 'Upload',
                            pressed: () {
                              //
                              setState(() {
                                uploading = true;
                              });
                              try {
                                FileUploadInputElement input =
                                    FileUploadInputElement()
                                      ..accept = 'image/*';
                                FirebaseStorage fs = FirebaseStorage.instance;
                                input.click();
                                input.onChange.listen((event) {
                                  final file = input.files!.first;
                                  final reader = FileReader();
                                  reader.readAsDataUrl(file);
                                  String uniqueFileName = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();

                                  reader.onLoadEnd.listen((event) async {
                                    var snapshot = await fs
                                        .ref()
                                        .child('Image/$uniqueFileName')
                                        .putBlob(file);
                                    String downloadUrl = await snapshot.ref
                                        .getDownloadURL()
                                        .whenComplete(() {
                                      //
                                      showSnackBar(
                                          context, purpleC, 'Upload Complete');
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
                              setState(() {
                                uploading = false;
                              });
                            },
                            style: style(context)),
                        const SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: uploading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: darkC,
                                  ))
                              : Icon(
                                  imageUrl == null
                                      ? null
                                      : AntIcons.checkOutlined,
                                  color: darkC,
                                ),
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
    );
  }
}
