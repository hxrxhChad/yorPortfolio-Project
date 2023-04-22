// ignore_for_file: file_names

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:p/constant/text-style.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/drawers/message-tab.dart';
import 'package:p/drawers/notification-tab.dart';
import 'package:p/mobile/components/home/dp-mpb.dart';
import 'package:p/mobile/components/home/proj-mob.dart';
import 'package:p/mobile/components/home/skill-mob.dart';

class MHome extends StatelessWidget {
  MHome({super.key});

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(7)),
          child: const NotificationTab(),
        ),
      ),
      endDrawer: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(7)),
          child: const Messagetab(),
        ),
      ),
      key: _key,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 65,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'Home',
                    style: style(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            _key.currentState!.openDrawer();
                          },
                          icon: const Icon(
                            AntIcons.bellOutlined,
                            size: 18,
                          )),
                      IconButton(
                          onPressed: () {
                            _key.currentState!.openEndDrawer();
                          },
                          icon: const Icon(
                            AntIcons.messageOutlined,
                            size: 18,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: DpMob(
                    searchId: id,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SkillMob(
                    searchId: id,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ProjMob(
                    searchId: id,
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
