// ignore_for_file: file_names
import 'dart:convert';

Language languageFromMap(String str) => Language.fromMap(json.decode(str));

String languageToMap(Language data) => json.encode(data.toMap());

class Language {
  Language({
    this.id,
    required this.language,
  });

  String? id;
  final String language;

  factory Language.fromMap(Map<String, dynamic> json) => Language(
        id: json["id"],
        language: json["language"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "language": language,
      };
}
