// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:p/constant/text-style.dart';
import 'package:p/desktop/page/d-log-in.dart';
import 'package:p/mobile/page/m-input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MSetting extends StatelessWidget {
  const MSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 65,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Center(
              child: Text(
                'Setting',
                style: style(context).copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MInput()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Edit Profile',
                        style: style(context).copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.remove("email");
                  FirebaseAuth.instance.signOut().whenComplete(() =>
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DLogin())));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Log Out',
                        style: style(context).copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
