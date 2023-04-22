// ignore_for_file: file_names, unnecessary_cast

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:p/bottom-sheets/bottom-function.dart';
import 'package:p/bottom-sheets/desktop-sheets/d-result.dart';
import 'package:p/bottom-sheets/tablet-sheets/t-result.dart';
import 'package:p/constant/colorsize.dart';

class DSearch extends StatefulWidget {
  const DSearch({super.key});

  @override
  State<DSearch> createState() => _DSearchState();
}

class _DSearchState extends State<DSearch> {
  String name = '';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Text("WELCOME TO",
                  style: style.copyWith(color: Colors.deepOrangeAccent)),
            ),
            Text("Search Page",
                style: style.copyWith(
                    color: darkC, fontWeight: FontWeight.bold, fontSize: 50)),
            Text("Search the particular portfolio using his yorPortfolio Name.",
                style: style.copyWith(color: darkC.withOpacity(0.6))),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              cursorColor: darkC,
              style: style,
              decoration: InputDecoration(
                constraints: const BoxConstraints(maxHeight: 40, maxWidth: 300),
                prefixIcon: SizedBox(
                  width: 30,
                  child: Center(
                    child: Icon(
                      AntIcons.userOutlined,
                      size: 17,
                      color: darkC.withOpacity(0.7),
                    ),
                  ),
                ),
                labelText: 'Name',
                labelStyle: style,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: darkC.withOpacity(0.4),
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: darkC.withOpacity(0.4),
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.red.withOpacity(0.4),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              height: 300,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('record')
                      .snapshots(),
                  builder: (context, snapshots) {
                    return (snapshots.connectionState ==
                            ConnectionState.waiting)
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: snapshots.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshots.data!.docs[index].data()
                                  as Map<String, dynamic>;
                              if (name.isEmpty) {
                                return const SizedBox(
                                  height: 3,
                                );
                              }
                              if (data['name']
                                  .toString()
                                  .toLowerCase()
                                  .startsWith(name.toLowerCase())) {
                                return InkWell(
                                  onTap: () {
                                    debugPrint(data['userId']);
                                    Navigator.pop(context);
                                    goBottomSheet(
                                        context,
                                        const Column(),
                                        TResult(searchId: data['userId']),
                                        DResult(
                                          searchId: data['userId'],
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 42,
                                          width: 42,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      data['photoUrl']),
                                                  fit: BoxFit.cover)),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['name'],
                                              style: style.copyWith(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              data['bio'],
                                              style: style.copyWith(
                                                  fontSize: 13,
                                                  color:
                                                      darkC.withOpacity(0.5)),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            });
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("Enter the name to get...",
                style: style.copyWith(color: darkC.withOpacity(0.6))),
            const SizedBox(height: 20),
            SizedBox(
              height: 500,
              width: 700,
              child: Image.network(
                'https://cdn.discordapp.com/attachments/1037389109313933312/1091667198604497037/result.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
