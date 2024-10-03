import 'package:firebase_auth/firebase_auth.dart';

class Userservices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> updateEmail(String email) async {
    try {
      await _auth.currentUser?.updateEmail(email);
      return _auth.currentUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> updatePassword(String password) async {
    try {
      await _auth.currentUser?.updatePassword(password);
      return _auth.currentUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> updateDisplayName(String displayName) async {
    try {
      await _auth.currentUser?.updateDisplayName(displayName);
      return _auth.currentUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> updatePhotoURL(String photoURL) async {
    try {
      await _auth.currentUser?.updatePhotoURL(photoURL);
      return _auth.currentUser;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
