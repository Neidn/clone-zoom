import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/constants.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false;

  GoogleSignInAccount? get currentUser => _currentUser;

  bool get isAuthorized => _isAuthorized;

  void init() async {
    _googleSignIn.onCurrentUserChanged.listen(
      (GoogleSignInAccount? account) async {
        bool isAuthorized = account != null;

        if (account != null) {
          isAuthorized = await _googleSignIn.canAccessScopes(googleScopes);
        }

        _currentUser = account;
        _isAuthorized = isAuthorized;
      },
    );

    await _googleSignIn.signInSilently();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: googleScopes,
  );

  void signInWithGoogle() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      print('Error: $e');
    }
  }
}
