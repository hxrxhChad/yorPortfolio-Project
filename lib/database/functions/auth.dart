// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/database/functions/add.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(context, String email, String password) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await addAuth(context, user.user!.uid, email, password);
    } catch (e) {
      showSnackBar(context, purpleC, e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
