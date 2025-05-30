import 'dart:io';

import 'package:blood_donation/Models/UserData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Userservices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> updateEmail(String email) async {
    try {
      await _auth.currentUser?.updateEmail(email);
      await _firestore
          .collection('Users')
          .doc(_auth.currentUser?.uid)
          .update({'email': email});
      await _auth.currentUser?.reload();
      return _auth.currentUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> updatePassword(String password) async {
    try {
      await _auth.currentUser?.updatePassword(password);
      await _firestore
          .collection('Users')
          .doc(_auth.currentUser?.uid)
          .update({'password': password});
      await _auth.currentUser?.reload();
      return _auth.currentUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> updateBloodType(String bloodType) async {
    try {
      await _firestore
          .collection('Users')
          .doc(_auth.currentUser?.uid)
          .update({'bloodType': bloodType});
    } catch (e) {
      print(e);
    }
  }

  Future<User?> updateDisplayName(String displayName) async {
    try {
      await _auth.currentUser?.updateDisplayName(displayName);
      await _firestore
          .collection('Users')
          .doc(_auth.currentUser?.uid)
          .update({'displayName': displayName});
      await _auth.currentUser?.reload();
      return _auth.currentUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserData> getUserData() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection("Users")
          .doc(_auth.currentUser?.uid)
          .get();
      return UserData.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      Fluttertoast.showToast(msg: "Failed to get user data");
      return UserData.empty;
    }
  }

  Future<User?> updatePhotoURL(File photo) async {
    try {
      await _storage
          .ref(
              "profile_pictures/${_auth.currentUser!.uid + photo.path[photo.path.length - 4]}")
          .putFile(photo);
      var path = await _storage
          .ref(
              "gs://jci-blood-donation.appspot.com/profile_pictures/${_auth.currentUser?.uid}")
          .getDownloadURL();
      await _auth.currentUser?.updatePhotoURL(path);
      await _firestore.collection('Users').doc(_auth.currentUser?.uid).update({
        'photoURL':
            "gs://jci-blood-donation.appspot.com/profile_pictures/${_auth.currentUser?.uid}"
      });
      await _auth.currentUser?.reload();
      return _auth.currentUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> deleteUser() async {
    try {
      // TODO: Delete user profile picture if exists
      // await _storage.ref("profile_pictures/${_auth.currentUser?.uid}").delete();
      await _firestore.collection("Users").doc(_auth.currentUser?.uid).delete();
      await _auth.currentUser?.delete();
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
