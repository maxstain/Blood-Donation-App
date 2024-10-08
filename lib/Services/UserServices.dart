import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Userservices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

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

  Future<User?> updatePhotoURL(File photo) async {
    try {
      await _storage
          .ref("profile_pictures/${_auth.currentUser?.uid}")
          .putFile(photo);
      var path = await _storage
          .ref(
              "gs://jci-blood-donation.appspot.com/profile_pictures/${_auth.currentUser?.uid}")
          .getDownloadURL();
      await _auth.currentUser?.updatePhotoURL(path);
      return _auth.currentUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> deleteUser() async {
    try {
      await _auth.currentUser?.delete();
    } catch (e) {
      print(e);
    }
  }
}
