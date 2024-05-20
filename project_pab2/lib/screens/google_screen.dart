import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInScreen extends StatefulWidget {
  @override
  _GoogleSignInScreenState createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    try {
      // Minta user untuk memilih akun Google untuk login
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        // Dapatkan credential autentikasi dari akun Google yang dipilih
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        // Dapatkan credential Firebase menggunakan token Google
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // Lakukan autentikasi menggunakan credential yang didapatkan
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        // Kembalikan user yang berhasil login
        return userCredential.user;
      }
    } catch (error) {
      print("Error signing in with Google: $error");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Google'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Panggil metode untuk login menggunakan Google
            User? user = await _signInWithGoogle();
            if (user != null) {
              // Jika login berhasil, lakukan navigasi ke halaman berikutnya
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              // Jika login gagal, tampilkan pesan kesalahan
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to sign in with Google.'),
                ),
              );
            }
          },
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}
