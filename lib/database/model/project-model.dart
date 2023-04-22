// ignore_for_file: file_names

import 'dart:convert';

Project projectFromMap(String str) => Project.fromMap(json.decode(str));

String projectToMap(Project data) => json.encode(data.toMap());

class Project {
  Project({
    this.id,
    required this.name,
    required this.detail,
    required this.imageUrl,
  });

  String? id;
  final String name;
  final String detail;
  final String imageUrl;

  factory Project.fromMap(Map<String, dynamic> json) => Project(
        id: json["id"],
        name: json["name"],
        detail: json["detail"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "detail": detail,
        "imageUrl": imageUrl,
      };
}
