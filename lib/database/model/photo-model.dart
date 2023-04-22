// ignore_for_file: file_names
import 'dart:convert';

Photo photoFromMap(String str) => Photo.fromMap(json.decode(str));

String photoToMap(Photo data) => json.encode(data.toMap());

class Photo {
  Photo({
    this.id,
    required this.photo,
  });

  String? id;
  final String photo;

  factory Photo.fromMap(Map<String, dynamic> json) => Photo(
        id: json["id"],
        photo: json["photo"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "photo": photo,
      };
}
