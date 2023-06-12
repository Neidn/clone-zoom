import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

import '/utils/utils.dart';
import '/utils/constants.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User get currentUser => _auth.currentUser!;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: googleScopes,
  );

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool result = false;
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      if (googleSignInAuthentication == null) {
        return result;
      }

      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(googleCredential);

      final User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo?.isNewUser == true) {
          await _firestore.collection(usersPath).doc(user.uid).set({
            'uid': user.uid,
            'name': user.displayName,
            'email': user.email,
            'profile_photo': user.photoURL,
          });
          result = true;
        }
      }
    } on FirebaseAuthException catch (e) {
      result = false;
      showSnackBar(context, e.message!);
    }
    return result;
  }

  void signOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
