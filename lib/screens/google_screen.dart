import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_screen.dart'; // Import ProfileScreen.dart

class GoogleLoginScreen extends StatefulWidget {
  @override
  _GoogleLoginScreenState createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    try {
      // Step 1: Melakukan proses sign in dengan Google
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        // Step 2: Mendapatkan token autentikasi dari Google
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // Step 3: Sign in dengan Firebase menggunakan credential Google
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (error) {
      print('Google sign-in error: $error');
    }
    return null;
  }

  Future<void> _removeAccount() async {
    await googleSignIn.disconnect();
    await _auth.signOut();
    print('Google account removed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Sign in with Google
                User? user = await _signInWithGoogle();
                if (user != null) {
                  // If login successful, navigate to profile screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                }
              },
              child: Text('Sign in with Google'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Remove Google account and sign out
                await _removeAccount();
              },
              child: Text('Remove Account'),
            ),
          ],
        ),
      ),
    );
  }
}
