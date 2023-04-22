// ignore_for_file: file_names

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/constant/text-style.dart';
import 'package:p/mobile/page/m-album.dart';
import 'package:p/mobile/page/m-home.dart';
import 'package:p/mobile/page/m-search.dart';
import 'package:p/mobile/page/m-setting.dart';

class Mobile extends StatefulWidget {
  const Mobile({super.key});

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // transparent status bar
        systemNavigationBarColor: Colors.white, // navigation bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness:
            Brightness.dark, //navigation bar icons' color
      ),
      child: Scaffold(
          bottomNavigationBar: Container(
            height: 75,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      page = 0;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                            color: page == 0
                                ? purpleC.withOpacity(0.1)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(40)),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.home,
                            color: page == 0 ? purpleC : darkC,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Home',
                        style: style(context).copyWith(
                            color: page == 0 ? purpleC : darkC,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      page = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                            color: page == 1
                                ? purpleC.withOpacity(0.1)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(40)),
                        child: Center(
                          child: Icon(
                            AntIcons.searchOutlined,
                            color: page == 1 ? purpleC : darkC,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Search',
                        style: style(context).copyWith(
                            color: page == 1 ? purpleC : darkC,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      page = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                            color: page == 2
                                ? purpleC.withOpacity(0.1)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(40)),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.photo,
                            color: page == 2 ? purpleC : darkC,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        'My Album',
                        style: style(context).copyWith(
                            color: page == 2 ? purpleC : darkC,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      page = 3;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                            color: page == 3
                                ? purpleC.withOpacity(0.1)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(40)),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.settings,
                            color: page == 3 ? purpleC : darkC,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Setting',
                        style: style(context).copyWith(
                            color: page == 3 ? purpleC : darkC,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: page == 0
                ? MHome()
                : page == 1
                    ? const MSearch()
                    : page == 2
                        ? const MAlbum()
                        : const MSetting(),
          )),
    );
  }
}
