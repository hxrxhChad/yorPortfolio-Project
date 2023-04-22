// ignore_for_file: file_names
import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/constant/text-style.dart';
import 'package:p/mobile/page/m-result.dart';

class MSearch extends StatefulWidget {
  const MSearch({super.key});

  @override
  State<MSearch> createState() => _MSearchState();
}

class _MSearchState extends State<MSearch> {
  String name = "";
  String searchUid = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 65,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Center(
              child: Text(
                'Search',
                style: style(context).copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text("Search Page",
                        style: style(context).copyWith(
                            color: darkC,
                            fontWeight: FontWeight.bold,
                            fontSize: 30)),
                    Text(
                        "Search the particular portfolio using his yorPortfolio name.",
                        textAlign: TextAlign.center,
                        style: style(context).copyWith(
                            color: darkC.withOpacity(0.6), fontSize: 12)),
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
                      style: style(context),
                      decoration: InputDecoration(
                        constraints:
                            const BoxConstraints(maxHeight: 40, maxWidth: 300),
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
                        labelStyle: style(context),
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
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 200,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('record')
                              .snapshots(),
                          builder: (context, snapshots) {
                            return (snapshots.connectionState ==
                                    ConnectionState.waiting)
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : ListView.builder(
                                    itemCount: snapshots.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      var data = snapshots.data!.docs[index]
                                          .data() as Map<String, dynamic>;
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
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MResult(
                                                            searchId: data[
                                                                'userId'])));
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
                                                      style: style(context)
                                                          .copyWith(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    Text(
                                                      data['bio'],
                                                      style: style(context)
                                                          .copyWith(
                                                              fontSize: 13,
                                                              color: darkC
                                                                  .withOpacity(
                                                                      0.5)),
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
                    SizedBox(
                      height: 200,
                      width: 300,
                      child: Image.network(
                        'https://cdn.discordapp.com/attachments/1037389109313933312/1091667198604497037/result.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
