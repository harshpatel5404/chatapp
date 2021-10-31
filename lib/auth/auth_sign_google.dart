import 'package:chatapp/constants/shared_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/home_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

FirebaseFirestore _firestore = FirebaseFirestore.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final Future<FirebaseApp> _initialization = Firebase.initializeApp();

late String name;
late String email;
late String imageUrl;
late String uid;
// late int sId;

void signOutGoogle() async {
  await googleSignIn.signOut();
  print("User Signed Out");
}

// Future<void> getAccountObject() async {
//   name = (await getName())!;
//   email = (await getEmail())!;
//   imageUrl = (await getImageURL())!;
//   uid = (await getUid())!;
// }
Future<String?> signInWithGoogle() async {
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);

  final User? user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    final User? currentUser = _auth.currentUser;
    assert(user.uid == currentUser!.uid);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    // Store the retrieved data
    name = user.displayName!;
    email = user.email!;
    imageUrl = user.photoURL!;
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        "name": name,
        "email": email,
        "imageUrl": imageUrl,
        "uid": _auth.currentUser!.uid
      });
    } catch (e) {
      print("error on store login data : $e");
    }

    setAccountObject(
      uid: user.uid,
      email: user.email,
      imageURL: user.photoURL,
      name: user.displayName,
    );
    setLoggedIn();
    return "$user";
  }

  return null;
}
