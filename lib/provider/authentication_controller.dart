import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsivedashboard/screens/authentication/auth_screen.dart';
import 'package:responsivedashboard/services/connect_firebase.dart';

class AuthenticationController extends ChangeNotifier {
  final emailCtr = TextEditingController();
  final passCtrl = TextEditingController();
  int? currentAdminRule;

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailCtr.text, password: passCtrl.text);
      var data = await ConnectFirebase.realtimeRead(path: "users");
      for (var value in data.values) {
        if ((value["rule"] == 1 || value["rule"] == 2) &&
            value["email"] == emailCtr.text) {
          currentAdminRule = value["rule"];
          return null;
        }
      }
      return "Not allowed,You are not an admin!";
    } on FirebaseAuthException catch (e) {
      String? wrongMessage;
      switch (e.code) {
        case 'user-not-found':
          wrongMessage = "User not found";
          break;
        case 'user-disabled':
          wrongMessage = "User disabled";
          break;
        case 'wrong-password':
          wrongMessage = "Wrong password";
          break;
        case 'too-many-requests':
          wrongMessage = "Too many requests, try again later";
          break;
      }
      return wrongMessage;
    }
  }

  static logOut(context) async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const AuthenticationScreen()),
        ModalRoute.withName("/"));
    await FirebaseAuth.instance.signOut();
  }
}
