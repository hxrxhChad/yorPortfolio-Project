// ignore_for_file: file_names

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/database/model/basic-model.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';
import 'package:p/desktop/components/login-component/hover-account.dart';

class RMenuBar extends StatelessWidget {
  final String searchId;
  const RMenuBar({
    super.key,
    required this.style,
    required TabController tabController,
    required this.searchId,
  }) : _tabController = tabController;

  final TextStyle style;
  final TabController _tabController;

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
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('user')
                .doc(searchId)
                .collection('basic')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                showSnackBar(context, Colors.redAccent, 'Something went wrong');
              }
              if (snapshot.hasData) {
                QuerySnapshot querySnapshot = snapshot.data!;
                List<QueryDocumentSnapshot> documents = querySnapshot.docs;
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
                  return const SizedBox(
                    height: 1,
                  );
                } else {
                  return Row(
                    children: [
                      PopupMenuButton(
                        constraints: const BoxConstraints(
                            minWidth: 1000, maxWidth: 1000),
                        color: Colors.white,
                        position: PopupMenuPosition.under,
                        elevation: 15,
                        shadowColor: darkC.withOpacity(0.3),
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        icon: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(basic[0].dp),
                                  fit: BoxFit.cover)),
                        ),
                        onSelected: (value) {
                          if (value == 0) {
                          } else if (value == 1) {
                          } else if (value == 2) {}
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              enabled: false,
                              padding: const EdgeInsets.only(left: 20),
                              height: 400,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'SEARCH RESULT',
                                            style: style.copyWith(
                                                color: Colors.orangeAccent),
                                          ),
                                          Text(
                                            'Likes the profile?',
                                            style: style.copyWith(
                                                fontSize: 50,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              HoverAccount(
                                                  icon: AntIcons.likeFilled,
                                                  pressed: () {}),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              HoverAccount(
                                                  icon: AntIcons.mehFilled,
                                                  pressed: () {}),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: 300,
                                            child: TabBar(
                                                controller: _tabController,
                                                indicatorPadding:
                                                    const EdgeInsets.all(5),
                                                labelStyle: style,
                                                labelColor: purpleC,
                                                unselectedLabelColor: darkC,
                                                indicator: BoxDecoration(
                                                    color: purpleC
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                tabs: const [
                                                  Tab(
                                                    text: 'Portfolio',
                                                  ),
                                                  Tab(
                                                    text: 'Album',
                                                  ),
                                                ]),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        height: 300,
                                        width: 400,
                                        child: Image.network(
                                            'https://cdn.discordapp.com/attachments/1037389109313933312/1092182589776871554/result_2.png'),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              )),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            basic[0].name,
                            style: style.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            basic[0].bio,
                            style:
                                style.copyWith(color: darkC.withOpacity(0.5)),
                          )
                        ],
                      )
                    ],
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
    );
  }
}
