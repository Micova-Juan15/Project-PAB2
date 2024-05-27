import 'package:flutter/material.dart';
import 'package:project_pab2/screens/insert_screen';

import 'package:project_pab2/screens/profile_screen.dart';
import 'package:project_pab2/screens/quiz_screen.dart'; // Import QuizScreen

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 73, 128, 117),
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InsertScreen()),
              );
            },
            child: Icon(Icons.add),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: Icon(Icons.person),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            // Tambahkan tombol untuk navigasi ke QuizScreen di sini
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        QuizScreen()), // Tentukan tujuan navigasi ke QuizScreen
              );
            },
            child: Icon(Icons.quiz_outlined),
          ),
        ],
      ),
      body: Center(
        child: Text('Ini adalah layar utama'),
      ),
    );
  }
}
