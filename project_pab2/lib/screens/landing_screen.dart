import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LandingScreen extends StatefulWidget {
  LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      // Handle sign-in success, navigate to next screen or perform necessary actions
    } catch (error) {
      // Handle sign-in failure
      print('Google Sign-In Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1BDDBA),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'images/otak.png',
                      width: 300,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text(
                    'Kessoku Quiz',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 0, 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(80,0,80,0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        icon: Image.asset(
                          'images/add.png',
                          width: 24,
                          height: 24,
                        ),
                        label: Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: const Text(
                            'Sign Up for Free',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(38,15,35,60),
                      child: ElevatedButton.icon(
                        onPressed: _handleSignIn,
                        icon: Image.asset(
                          'images/google.png',
                          width: 24,
                          height: 24,
                        ),
                          label: const Text(
                          'Sign Up with Google',
                          style: TextStyle(
                          color: Colors.black,
                        fontSize: 18
                       ), ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5, 
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 3, 0, 5),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            textScaleFactor: MediaQuery.of(context).textScaleFactor,
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Already have an account?  ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15),
                                ),
                                TextSpan(
                                  text: 'Sign In',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    fontSize: 15,
                                  ),
                                  mouseCursor: SystemMouseCursors.click,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, '/signin');
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
