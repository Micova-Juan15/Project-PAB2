import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 73, 128, 117),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
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
                      padding: const EdgeInsets.fromLTRB(65, 10, 60, 0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signin');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        label: Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 3, 0, 5),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Don't have an account?  ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                TextSpan(
                                  text: 'Sign Up',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    fontSize: 15,
                                  ),
                                  mouseCursor: SystemMouseCursors.click,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, '/signup');
                                    },
                                ),
                              ],
                            ),
                            textScaler: TextScaler.linear(
                                MediaQuery.of(context).textScaleFactor),
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
