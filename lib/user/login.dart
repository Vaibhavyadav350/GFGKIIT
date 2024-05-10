import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        print('Nahi ho payega Tera');
        return;
      }
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      // if (!googleUser.email.endsWith('@kiit.ac.in')) {
      //   print('galat email hai you are not lovable KIITIAN');
      //   return;
      // }
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user == null) {
        print('Firebase nama kardiya');
        return;
      }
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (!userDoc.exists) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'kiitemail': user.email,
        });
      }

      final emailDoc =
      await _firestore.collection('StudentInfo').doc(user.uid).get();
      if (!emailDoc.exists) {
        await _firestore.collection('StudentInfo').doc(user.uid).set({
          'kiitemail': user.email,
        });
      }

      print('Apka swagat hai ${user.displayName}');
    } catch (e) {
      print('Chal nikal $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromRGBO(4, 69, 46, 1),
              Color.fromRGBO(0, 42, 58, 1),
            ],
            center: Alignment.center,
            radius: 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            Center(
              child: Image.asset(
                'assets/logo/logowithoutbg.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 80),
            Flexible(
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      minimumSize: Size(300, 60),
                    ),
                    onPressed: () {
                      _handleSignIn();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/Group 13.png",
                          fit: BoxFit.cover,
                        ),
                        Text(
                          '   Login',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
