// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:p/constant/colorsize.dart';
import 'package:p/constant/text-style.dart';
import 'package:p/mobile/components/album/album-grid.dart';
import 'package:p/mobile/components/home/dp-mpb.dart';
import 'package:p/mobile/components/home/proj-mob.dart';
import 'package:p/mobile/components/home/skill-mob.dart';
import 'package:p/mobile/components/result/result-tab.dart';

class MResult extends StatefulWidget {
  const MResult({
    Key? key,
    required this.searchId,
  }) : super(key: key);
  final String searchId;
  @override
  State<MResult> createState() => _MResultState();
}

class _MResultState extends State<MResult> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: 65,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: Center(
                  child: Text(
                    'Search Result',
                    style: style(context).copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                  top: 20,
                  left: 20,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          color: purpleC, shape: BoxShape.circle),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          CupertinoIcons.arrow_left,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
          ResultTabBar(tabController: _tabController),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: DpMob(
                        searchId: widget.searchId,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: SkillMob(
                        searchId: widget.searchId,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: ProjMob(
                        searchId: widget.searchId,
                      ),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    AlbumGrid(
                      searchId: widget.searchId,
                    ),
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
