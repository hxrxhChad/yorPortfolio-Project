// ignore_for_file: file_names, avoid_print, avoid_web_libraries_in_flutter

import 'dart:html';

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/desktop/components/album-component/hover-text-box.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

class AddProject extends StatefulWidget {
  final TextStyle style;
  const AddProject({
    Key? key,
    required this.style,
  }) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final detail = TextEditingController();

  final name = TextEditingController();

  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      constraints: const BoxConstraints(minWidth: 400, maxWidth: 400),
      color: Colors.white,
      position: PopupMenuPosition.under,
      elevation: 15,
      shadowColor: darkC.withOpacity(0.3),
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: Container(
        height: 30,
        width: 100,
        decoration: BoxDecoration(
            color: purpleC, borderRadius: BorderRadius.circular(7)),
        child: Center(
          child: Text(
            'Add Project',
            style: widget.style.copyWith(color: Colors.white),
          ),
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
            enabled: false,
            padding: const EdgeInsets.only(left: 20),
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Project',
                    style: widget.style
                        .copyWith(fontWeight: FontWeight.bold, color: purpleC),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
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
                    child: Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                          color: purpleC,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          imageUrl == null ? 'Upload Image' : 'Image Uploaded',
                          style: widget.style.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 45,
                    width: 200,
                    child: TextFormField(
                      controller: name,
                      cursorColor: darkC,
                      textAlignVertical: TextAlignVertical.center,
                      style: widget.style.copyWith(color: darkC),
                      decoration: InputDecoration(
                        prefixIcon: const SizedBox(
                          width: 30,
                          child: Center(
                            child: Icon(
                              AntIcons.projectOutlined,
                              size: 16,
                              color: darkC,
                            ),
                          ),
                        ),
                        label: const Text('Name'),
                        labelStyle: widget.style.copyWith(color: darkC),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(color: darkC)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(color: darkC)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(color: Colors.red)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 70,
                    width: 200,
                    child: TextFormField(
                      maxLines: 3,
                      controller: detail,
                      cursorColor: darkC,
                      textAlignVertical: TextAlignVertical.center,
                      style: widget.style.copyWith(color: darkC),
                      decoration: InputDecoration(
                        prefixIcon: const SizedBox(
                          width: 30,
                          child: Center(
                            child: Icon(
                              AntIcons.cloudFilled,
                              size: 16,
                              color: darkC,
                            ),
                          ),
                        ),
                        label: const Text('Detail'),
                        labelStyle: widget.style.copyWith(color: darkC),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(color: darkC)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(color: darkC)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(color: Colors.red)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  HoverTextBox(
                      text: 'Add',
                      pressed: () async {
                        try {
                          await addProject(
                              context, name.text, detail.text, imageUrl);
                        } catch (e) {
                          showSnackBar(context, purpleC, e.toString());
                        }
                      },
                      style: widget.style)
                ],
              ),
            )),
      ],
    );
  }
}
