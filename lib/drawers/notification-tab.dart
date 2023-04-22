// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';

class NotificationTab extends StatelessWidget {
  const NotificationTab({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(color: darkC, fontWeight: FontWeight.w500, fontSize: mediumT);
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notification',
            style: style.copyWith(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.network(
                          'https://cdn.discordapp.com/attachments/1037389109313933312/1092182589776871554/result_2.png'))),
              Text(
                'Please wait for another update.',
                style: style,
              )
            ],
          ))
        ],
      ),
    );
  }
}
