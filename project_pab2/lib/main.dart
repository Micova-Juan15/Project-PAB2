import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_pab2/firebase_options.dart';
import 'package:project_pab2/screens/landing_screen.dart';
import 'package:project_pab2/screens/google_screen.dart';
import 'package:project_pab2/screens/sign_in_screen.dart';
import 'package:project_pab2/screens/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  LandingScreen(),
      initialRoute: '/',
      routes: {
        '/landing': (context) =>  LandingScreen(),
        '/google' : (context) =>  GoogleSignInScreen(),
        '/signup': (context) =>  SignUpScreen(),
        '/signin': (context) =>  SignInScreen(),
      },
    );
  }
}