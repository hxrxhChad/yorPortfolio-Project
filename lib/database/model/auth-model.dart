// ignore_for_file: file_names

import 'dart:convert';

Auth authFromMap(String str) => Auth.fromMap(json.decode(str));

String authToMap(Auth data) => json.encode(data.toMap());

class Auth {
  Auth({
    this.id,
    required this.uid,
    required this.email,
    required this.password,
  });

  String? id;
  final String uid;
  final String email;
  final String password;

  factory Auth.fromMap(Map<String, dynamic> json) => Auth(
        id: json["id"],
        uid: json["uid"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "uid": uid,
        "email": email,
        "password": password,
      };
}
