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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              quiz['question'],
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          if (quiz['imageUrl'] != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(quiz['imageUrl']),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              quiz['description'],
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Choices:',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '1. ${quiz['choice1']}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '2. ${quiz['choice2']}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '3. ${quiz['choice3']}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '4. ${quiz['choice4']}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Correct Choice: ${quiz['correct_choice']}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Latitude: ${quiz['latitude']}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Longitude: ${quiz['longitude']}',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
