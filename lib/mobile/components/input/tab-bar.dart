// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/constant/text-style.dart';

class TabBarMob extends StatelessWidget {
  const TabBarMob({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TabBar(
          controller: _tabController,
          indicatorPadding: const EdgeInsets.all(5),
          labelStyle: style(context).copyWith(fontSize: 12),
          labelColor: purpleC,
          unselectedLabelColor: darkC,
          indicator: BoxDecoration(
              color: purpleC.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          tabs: const [
            Tab(
              text: 'Basic',
            ),
            Tab(
              text: 'Skill',
            ),
            Tab(
              text: 'Project',
            ),
          ]),
    );
  }
}
