// ignore_for_file: file_names

import 'dart:convert';

Record recordFromMap(String str) => Record.fromMap(json.decode(str));

String recordToMap(Record data) => json.encode(data.toMap());

class Record {
  Record({
    this.id,
    required this.name,
    required this.bio,
    required this.userId,
    required this.photoUrl,
  });

  String? id;
  final String name;
  final String bio;
  final String userId;
  final String photoUrl;

  factory Record.fromMap(Map<String, dynamic> json) => Record(
        id: json["id"],
        name: json["name"],
        bio: json["bio"],
        userId: json["userId"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "bio": bio,
        "userId": userId,
        "photoUrl": photoUrl,
      };
}
