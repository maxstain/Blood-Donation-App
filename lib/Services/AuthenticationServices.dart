import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blood_donation/Models/UserData.dart';

class AuthenticationServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<UserData> getUserData() async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection("Users")
          .doc(_firebaseAuth.currentUser?.uid)
          .get();
      return UserData.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to get user data");
      return UserData.empty;
    }
  }

  // Register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firestore.collection("Users").doc(userCredential.user?.uid).set(
        {
          "uid": userCredential.user?.uid,
          "email": email,
          "password": password,
          "phone": "",
          "displayName": "",
          "photoURL": "",
          "bio": "",
          "city": "",
          "Country": "",
          "donated": 0,
          "received": 0,
          "createdAt": FieldValue.serverTimestamp(),
        },
      );
      signInWithEmailAndPassword(email, password);
      return userCredential;
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to register");
    }
  }
}
