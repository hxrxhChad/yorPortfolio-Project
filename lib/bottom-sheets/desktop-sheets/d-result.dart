// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:p/constant/colorsize.dart';
import 'package:p/desktop/components/result-component/r-menubar.dart';
import 'package:p/desktop/components/result-component/r-photo.dart';
import 'package:p/desktop/components/result-component/r-portfolio.dart';

class DResult extends StatefulWidget {
  const DResult({
    Key? key,
    required this.searchId,
  }) : super(key: key);
  final String searchId;
  @override
  State<DResult> createState() => _DResultState();
}

class _DResultState extends State<DResult> with SingleTickerProviderStateMixin {
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
    final style = Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(color: darkC, fontWeight: FontWeight.w500, fontSize: mediumT);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 320, right: 320, top: 5),
            child: RMenuBar(
              style: style,
              tabController: _tabController,
              searchId: widget.searchId,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: [
              Portfolio(
                style: style,
                searchId: widget.searchId,
              ),
              RPhoto(
                style: style,
                searchId: widget.searchId,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
