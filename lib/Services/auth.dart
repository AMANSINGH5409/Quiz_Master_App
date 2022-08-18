import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizmasterapp/models/user.dart';

import '../Pages/signinPage.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  user? _userFromFirebase(User? fuser) {
    return fuser != null ? user(uid: fuser.uid) : null;
  }

  bool isSignedIn() {
    try {
      return _auth.currentUser!.uid != null ? true : false;
    } catch (e) {
      return false;
    }
  }

  Future signInEmailAndPassword(String userEmail, String userPassword) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
      User? user = cred.user;
      return _userFromFirebase(user);
    } catch (error) {
      print(error.toString());
    }
  }

  Future signUpEmailAndPassword(String userEmail, String userPassword) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
      User? user = cred.user;
      return _userFromFirebase(user);
    } catch (error) {
      print(error.toString());
    }
  }

  Future signOut({context}) async {
    try {
      await _auth.signOut().then((value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignInPage()));
      });
    } catch (error) {
      print(error.toString());
      return false;
    }
  }
}
