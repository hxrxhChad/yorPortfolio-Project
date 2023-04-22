// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String name = '';
  List<Map<String, dynamic>> data = [
    {'name': 'John', 'email': 'john@example.com'},
    {'name': 'harsh', 'email': 'harsh@example.com'},
    {'name': 'deedee', 'email': 'deedee@example.com'},
    {'name': 'joey', 'email': 'joey@example.com'},
    {'name': 'spike', 'email': 'spike@example.com'},
    {'name': 'tom', 'email': 'tom@example.com'},
    {'name': 'jerry', 'email': 'jerry@example.com'},
    {'name': 'pluto', 'email': 'pluto@example.com'},
    {'name': 'scoopy', 'email': 'scoopy@example.com'},
  ];

  addData() async {
    for (var element in data) {
      FirebaseFirestore.instance.collection('users').add(element);
    }
    debugPrint('Added Data -------->');
  }

  @override
  void initState() {
    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Card(
            child: TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(AntIcons.searchOutlined),
                  hintText: 'Search'),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshots) {
              return (snapshots.connectionState == ConnectionState.waiting)
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshots.data!.docs[index].data()
                            as Map<String, dynamic>;
                        if (name.isEmpty) {
                          return ListTile(
                            onTap: () {
                              debugPrint(data['email']);
                            },
                            title: Text(
                              data['name'],
                            ),
                            subtitle: Text(data['email']),
                          );
                        }
                        if (data['name']
                            .toString()
                            .toLowerCase()
                            .startsWith(name.toLowerCase())) {
                          return ListTile(
                            onTap: () {
                              debugPrint(data['email']);
                            },
                            title: Text(
                              data['name'],
                            ),
                            subtitle: Text(data['email']),
                          );
                        }
                        return Container();
                      });
            }));
  }
}

class ResultTest extends StatelessWidget {
  const ResultTest({
    Key? key,
    required this.yo,
  }) : super(key: key);

  final String yo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(yo)
              .collection('collectionPath')
              .snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: ListTile(
                      title: Text(
                        snapshots.data!.docs[0]['name'],
                      ),
                      subtitle: Text(snapshots.data!.docs[0]['email']),
                    ),
                  );
          }),
    );
  }
}
