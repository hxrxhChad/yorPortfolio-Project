// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/constant/text-style.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/mobile/components/album/album-grid.dart';
import 'package:p/mobile/components/album/upload-photo.dart';

class MAlbum extends StatelessWidget {
  const MAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 65,
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
              child: Center(
                child: Text(
                  'Album',
                  style: style(context).copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const UploadPhoto(),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: Divider(
                color: darkC.withOpacity(0.2),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AlbumGrid(
              searchId: id,
            ),
          ],
        ),
      ),
    );
  }
}
