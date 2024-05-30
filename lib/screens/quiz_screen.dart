import 'package:flutter/material.dart';
import 'package:project_pab2/models/quiz.dart';

class QuizScreen extends StatelessWidget {
  final Map<String, dynamic> quiz;
  const QuizScreen({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 73, 128, 117),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 73, 128, 117),
        title: const Text('Quiz', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite),
            color: Colors.grey,
          )
        ],
      ),
      body: Column(
        children: [Text(quiz['question'],
        Image.network(quiz['imageUrl']),
        )],
        
      ),
    );
  }
}
