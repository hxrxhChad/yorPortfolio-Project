// ignore_for_file: file_names

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p/bottom-sheets/bottom-function.dart';
import 'package:p/bottom-sheets/desktop-sheets/d-album.dart';
import 'package:p/bottom-sheets/desktop-sheets/d-input.dart';
import 'package:p/bottom-sheets/desktop-sheets/d-search.dart';
import 'package:p/bottom-sheets/tablet-sheets/t-input.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/database/model/basic-model.dart';
import 'package:p/desktop/components/album-component/hover-text-box.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';
import 'package:p/desktop/components/home-component/hover-icon.dart';
import 'package:p/desktop/page/d-log-in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuBarArea extends StatelessWidget {
  MenuBarArea({
    super.key,
    required this.style,
    required this.scaffoldKey,
  });

  final TextStyle style;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final basicRef =
      FirebaseFirestore.instance.collection('user').doc(id).collection('basic');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DefaultTextStyle(
          style: style.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
          child: const Text.rich(TextSpan(children: [
            TextSpan(text: "yor", style: TextStyle(color: purpleC)),
            TextSpan(text: "Portfolio")
          ])),
        ),
        Row(
          children: [
            HoverTextBox(
              pressed: () {
                goBottomSheet(
                    context, const Column(), const DSearch(), const DSearch());
              },
              style: style,
              text: 'Search',
            ),
            const SizedBox(
              width: 20,
            ),
            HoverIcon(
                icon: AntIcons.bellOutlined,
                hicon: AntIcons.bellFilled,
                pressed: () {
                  scaffoldKey.currentState!.openEndDrawer();
                }),
            const SizedBox(
              width: 20,
            ),
            PopupMenuButton(
              color: Colors.white,
              position: PopupMenuPosition.under,
              elevation: 15,
              shadowColor: darkC.withOpacity(0.3),
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              icon: StreamBuilder<QuerySnapshot>(
                  stream: basicRef.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      showSnackBar(
                          context, Colors.redAccent, 'Something went wrong');
                    }
                    if (snapshot.hasData) {
                      QuerySnapshot querySnapshot = snapshot.data!;
                      List<QueryDocumentSnapshot> documents =
                          querySnapshot.docs;
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
                        return Container(
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            CupertinoIcons.ellipsis_vertical,
                            size: 18,
                            color: darkC,
                          ),
                        );
                      } else {
                        return Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(basic[0].dp),
                                  fit: BoxFit.cover)),
                        );
                      }
                    } else {
                      return Container(
                        height: 25,
                        width: 25,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          CupertinoIcons.ellipsis_vertical,
                          size: 18,
                          color: darkC,
                        ),
                      );
                    }
                  }),
              onSelected: (value) async {
                if (value == 0) {
                  goBottomSheet(
                      context, const Column(), const DAlbum(), const DAlbum());
                } else if (value == 1) {
                  goBottomSheet(
                      context, const Column(), const TInput(), const DInput());
                } else if (value == 2) {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.remove("email");
                  FirebaseAuth.instance.signOut().whenComplete(() =>
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DLogin())));
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  enabled: false,
                  padding: const EdgeInsets.only(left: 20),
                  height: 50,
                  child: Text(
                    'Select an Option',
                    style: style.copyWith(
                        color: purpleC, fontWeight: FontWeight.bold),
                  ),
                ),
                PopupMenuItem(
                  padding: const EdgeInsets.only(left: 20),
                  height: 30,
                  value: 0,
                  child: Text(
                    'My Album',
                    style: style,
                  ),
                ),
                PopupMenuItem(
                  padding: const EdgeInsets.only(left: 20),
                  height: 30,
                  value: 1,
                  child: Text(
                    'Edit Profile',
                    style: style,
                  ),
                ),
                PopupMenuItem(
                  padding: const EdgeInsets.only(left: 20),
                  height: 30,
                  value: 2,
                  child: Text(
                    'Log out',
                    style: style,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
