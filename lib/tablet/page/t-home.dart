// ignore_for_file: file_names
import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/desktop/components/home-component/dp-area.dart';
import 'package:p/desktop/components/home-component/header-area.dart';
import 'package:p/desktop/components/home-component/menubar-area.dart';
import 'package:p/desktop/components/home-component/project-area.dart';
import 'package:p/desktop/components/home-component/skill-area.dart';
import 'package:p/drawers/message-tab.dart';
import 'package:p/drawers/notification-tab.dart';

class THome extends StatelessWidget {
  THome({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(color: darkC, fontWeight: FontWeight.w500, fontSize: mediumT);
    return Scaffold(
        key: scaffoldKey,
        drawer: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: double.infinity,
            width: 400,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: const Messagetab(),
          ),
        ),
        endDrawer: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: double.infinity,
            width: 400,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: const NotificationTab(),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(30),
          child: InkWell(
            onTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
            child: Material(
              color: purpleC,
              shape: const CircleBorder(),
              shadowColor: purpleC.withOpacity(0.1),
              elevation: 10,
              child: Container(
                height: 50,
                width: 50,
                decoration:
                    const BoxDecoration(color: purpleC, shape: BoxShape.circle),
                child: const Center(
                  child: Icon(
                    AntIcons.messageFilled,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
                child: MenuBarArea(style: style, scaffoldKey: scaffoldKey),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 87),
                child: Header(
                  style: style,
                  searchId: id,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 87),
                  child: DpArea(
                    style: style,
                    searchId: id,
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 77),
                  child: SkillArea(
                    style: style,
                    searchId: id,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 87),
                child: ProjectArea(
                  style: style,
                  searchId: id,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 80, bottom: 80),
                  child: SizedBox(
                      height: 400,
                      width: 600,
                      child: Image.network(
                          "https://cdn.discordapp.com/attachments/1037389109313933312/1091698338807685241/original-247e797815e0299422db0d7afce3b73b_magic.jpg",
                          fit: BoxFit.cover))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Text("THANKS FOR VISITING!",
                      style:
                          style.copyWith(color: Colors.black54, fontSize: 20))),
            ],
          ),
        ));
  }
}
