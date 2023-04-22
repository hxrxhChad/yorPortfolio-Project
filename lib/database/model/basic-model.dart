// ignore_for_file: file_names
import 'dart:convert';

Basic basicFromMap(String str) => Basic.fromMap(json.decode(str));

String basicToMap(Basic data) => json.encode(data.toMap());

class Basic {
  Basic({
    this.id,
    required this.name,
    required this.bio,
    required this.slogan,
    required this.about,
    required this.dp,
  });

  String? id;
  final String name;
  final String bio;
  final String slogan;
  final String about;
  final String dp;

  factory Basic.fromMap(Map<String, dynamic> json) => Basic(
        id: json["id"],
        name: json["name"],
        bio: json["bio"],
        slogan: json["slogan"],
        about: json["about"],
        dp: json["dp"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "bio": bio,
        "slogan": slogan,
        "about": about,
        "dp": dp,
      };
}
