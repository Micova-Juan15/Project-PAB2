import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_pab2/firebase_options.dart';
import 'package:project_pab2/screens/google_map_screen.dart';
import 'package:project_pab2/screens/landing_screen.dart';
import 'package:project_pab2/screens/home_screen.dart';
import 'package:project_pab2/screens/profile_screen.dart';
import 'package:project_pab2/screens/sign_in_screen.dart';
import 'package:project_pab2/screens/sign_up_screen.dart';
import 'package:flutter_config/flutter_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    await FlutterConfig.loadEnvVariables();
  }
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
      home: LandingScreen(),
      initialRoute: '/',
      routes: {
        '/landing': (context) => const LandingScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/signin': (context) => const SignInScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/home': (context) => HomeScreen(),
        '/map': (context) => GoogleMapScreen(),
      },
    );
  }
}
