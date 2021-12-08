import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradely_app/model/user_account.dart';
import 'package:gradely_app/model/user_register.dart';
import 'package:gradely_app/model/user_uid.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserUID? _userUID(User? user) {
    return user != null ? UserUID(user.uid) : null;
  }

  Stream<UserUID?> get user {
    return _firebaseAuth.authStateChanges().map((User? user) => _userUID(user));
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      String uid = _firebaseAuth.currentUser!.uid;
      return "Signed in:$uid";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signUp(
      {required String email, required String password, required UserRegister userRegister}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      await DatabaseService(user!.uid).updateUserAccountData(userRegister);

      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
