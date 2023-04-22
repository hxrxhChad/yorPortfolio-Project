// ignore_for_file: file_names, avoid_web_libraries_in_flutter, use_build_context_synchronously

import 'dart:html';

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/desktop/components/album-component/hover-text-box.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';
import 'package:p/desktop/components/input-component/basic-field..dart';

class BasicInput extends StatefulWidget {
  const BasicInput({
    super.key,
    required this.style,
  });
  final TextStyle style;

  @override
  State<BasicInput> createState() => _BasicInputState();
}

class _BasicInputState extends State<BasicInput> {
  final name = TextEditingController();

  final bio = TextEditingController();

  final about = TextEditingController();

  final slogan = TextEditingController();

  String? imageUrl;

  bool submitted = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HoverTextBox(
                  text: 'Upload DP',
                  pressed: () {
                    try {
                      FileUploadInputElement input = FileUploadInputElement()
                        ..accept = 'image/*';
                      FirebaseStorage fs = FirebaseStorage.instance;
                      input.click();
                      input.onChange.listen((event) {
                        final file = input.files!.first;
                        final reader = FileReader();
                        reader.readAsDataUrl(file);
                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        reader.onLoadEnd.listen((event) async {
                          var snapshot = await fs
                              .ref()
                              .child('Image/$uniqueFileName')
                              .putBlob(file);
                          String downloadUrl = await snapshot.ref
                              .getDownloadURL()
                              .whenComplete(() {
                            //
                            showSnackBar(context, purpleC, 'Upload Complete');
                          });
                          setState(() {
                            imageUrl = downloadUrl;
                            debugPrint(imageUrl);
                          });
                        });
                      });
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  style: widget.style),
              const SizedBox(
                width: 20,
              ),
              Icon(
                imageUrl == null ? null : AntIcons.checkOutlined,
                color: Colors.greenAccent,
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          BasicField(
            controller: name,
            style: widget.style,
            label: 'Name',
            icon: AntIcons.userOutlined,
          ),
          BasicField(
            controller: bio,
            style: widget.style,
            label: 'Bio',
            icon: AntIcons.bookFilled,
          ),
          BasicField(
            controller: slogan,
            style: widget.style,
            label: 'slogan',
            icon: AntIcons.dingtalkOutlined,
          ),
          BasicField(
            controller: about,
            style: widget.style,
            label: 'about',
            icon: AntIcons.carOutlined,
          ),
          const SizedBox(
            height: 40,
          ),
          HoverTextBox(
              text: submitted ? 'Submitted' : 'Submit All',
              pressed: () async {
                try {
                  await addbasic(context, name.text, about.text, bio.text,
                      imageUrl, slogan.text);
                  await addRecord(context, name.text, bio.text, imageUrl, id);
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              style: widget.style),
        ],
      ),
    );
  }
}
