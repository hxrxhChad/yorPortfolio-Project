// ignore_for_file: file_names
import 'dart:convert';

Skill skillFromMap(String str) => Skill.fromMap(json.decode(str));

String skillToMap(Skill data) => json.encode(data.toMap());

class Skill {
  Skill({
    this.id,
    required this.skill,
  });

  String? id;
  final String skill;

  factory Skill.fromMap(Map<String, dynamic> json) => Skill(
        id: json["id"],
        skill: json["skill"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "skill": skill,
      };
}
