import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/database/model/basic-model.dart';
import 'package:p/database/model/auth-model.dart';
import 'package:p/database/model/lang-model.dart';
import 'package:p/database/model/photo-model.dart';
import 'package:p/database/model/project-model.dart';
import 'package:p/database/model/record-model.dart';
import 'package:p/database/model/skill-model.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

// global variable for user-id
final String id = FirebaseAuth.instance.currentUser!.uid;

// global variable for search user-id

addRecord(context, name, bio, photoUrl, userId) {
  Record record =
      Record(name: name, bio: bio, userId: userId, photoUrl: photoUrl);
  final recordRef = FirebaseFirestore.instance.collection('record').doc(id);

  record.id = recordRef.id;
  final data = record.toMap();

  try {
    recordRef
        .set(data)
        .whenComplete(() => showSnackBar(context, purpleC, 'Record Uploaded'));
  } catch (e) {
    showSnackBar(context, purpleC, e.toString());
  }
}

addAuth(context, uid, email, password) {
  Auth auth = Auth(uid: uid, email: email, password: password);

  final authRef = FirebaseFirestore.instance
      .collection('user')
      .doc(id)
      .collection('auth')
      .doc(id); // when about -> doc('about')

  auth.id = authRef.id;
  final data = auth.toMap();
  try {
    authRef
        .set(data)
        .whenComplete(() => showSnackBar(context, purpleC, 'Auth Uploaded'));
  } catch (e) {
    showSnackBar(context, purpleC, e.toString());
  }
}

// project
addProject(context, name, detail, imageUrl) {
  Project project = Project(detail: detail, imageUrl: imageUrl, name: name);

  final projectRef = FirebaseFirestore.instance
      .collection('user')
      .doc(id)
      .collection('project')
      .doc(); // when about -> doc('about')

  project.id = projectRef.id;
  final data = project.toMap();

  try {
    projectRef
        .set(data)
        .whenComplete(() => showSnackBar(context, purpleC, 'Project Uploaded'));
  } catch (e) {
    showSnackBar(context, purpleC, e.toString());
  }
}

// skill
addSkill(context, skillN) {
  Skill skill = Skill(skill: skillN);

  final skillRef = FirebaseFirestore.instance
      .collection('user')
      .doc(id)
      .collection('skill')
      .doc(); // when about -> doc('about')

  skill.id = skillRef.id;
  final data = skill.toMap();

  try {
    skillRef
        .set(data)
        .whenComplete(() => showSnackBar(context, purpleC, 'Skill Uploaded'));
  } catch (e) {
    showSnackBar(context, purpleC, e.toString());
  }
}

// Language
addLang(context, language) {
  Language lang = Language(language: language);

  final langRef = FirebaseFirestore.instance
      .collection('user')
      .doc(id)
      .collection('language')
      .doc(); // when about -> doc('about')

  lang.id = langRef.id;
  final data = lang.toMap();

  try {
    langRef.set(data).whenComplete(
        () => showSnackBar(context, purpleC, 'Language Uploaded'));
  } catch (e) {
    showSnackBar(context, purpleC, e.toString());
  }
}

// basic
addbasic(context, name, about, bio, dp, slogan) {
  Basic basic =
      Basic(name: name, about: about, bio: bio, dp: dp, slogan: slogan);

  final basicRef = FirebaseFirestore.instance
      .collection('user')
      .doc(id)
      .collection('basic')
      .doc(id); // when about -> doc('about')

  basic.id = basicRef.id;
  final data = basic.toMap();
  try {
    basicRef
        .set(data)
        .whenComplete(() => showSnackBar(context, purpleC, 'Basic Uploaded'));
  } catch (e) {
    showSnackBar(context, purpleC, e.toString());
  }
}

// Photo
addPhoto(context, photoUrl) {
  Photo photo = Photo(photo: photoUrl);

  final photoRef = FirebaseFirestore.instance
      .collection('user')
      .doc(id)
      .collection('photo')
      .doc(); // when about -> doc('about')

  photo.id = photoRef.id;
  final data = photo.toMap();
  try {
    photoRef
        .set(data)
        .whenComplete(() => showSnackBar(context, purpleC, 'Photo Uploaded'));
  } catch (e) {
    showSnackBar(context, purpleC, e.toString());
  }
}
