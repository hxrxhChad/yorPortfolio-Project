// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/constant/text-style.dart';
import 'package:p/desktop/components/input-component/basic-input.dart';
import 'package:p/mobile/components/input/project-input-tab.dart';
import 'package:p/mobile/components/input/skill-input-tab.dart';
import 'package:p/mobile/components/input/tab-bar.dart';

class MInput extends StatefulWidget {
  const MInput({super.key});

  @override
  State<MInput> createState() => _MInputState();
}

class _MInputState extends State<MInput> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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
                    'Input',
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
          TabBarMob(tabController: _tabController),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: [
              BasicInput(
                style: style(context),
              ),
              const SkillInputTab(),
              const ProjectInputTab(),
            ],
          ))
        ],
      ),
    );
  }
}
