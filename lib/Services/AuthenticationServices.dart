import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticationServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to authenticate");
    }
  }

  // Sign out
  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to sign out");
    }
  }

  // Register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      signInWithEmailAndPassword(email, password);
      return userCredential;
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to register");
    }
  }
}
