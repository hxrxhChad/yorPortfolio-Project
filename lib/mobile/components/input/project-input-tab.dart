// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:p/constant/responsive.dart';
import 'package:p/constant/text-style.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/desktop/components/album-component/hover-text-box.dart';
import 'package:p/desktop/components/input-component/add-project.dart';
import 'package:p/mobile/components/home/proj-mob.dart';

class ProjectInputTab extends StatelessWidget {
  const ProjectInputTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          AddProject(style: style(context).copyWith(fontSize: 12)),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ProjMob(
                searchId: id,
              )),
          const SizedBox(
            height: 20,
          ),
          HoverTextBox(
              text: 'Continue',
              pressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Responsive()));
              },
              style: style(context).copyWith(fontSize: 12))
        ]),
      ),
    );
  }
}
