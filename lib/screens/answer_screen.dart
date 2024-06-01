import 'package:flutter/material.dart';
import 'package:project_pab2/screens/detail_screen.dart';

class AnswerScreen extends StatelessWidget {
  final Map<String, dynamic> quiz;
  const AnswerScreen({Key? key, required this.quiz}) : super(key: key);

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
            icon: const Icon(Icons.location_on),
            color: Colors.white,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                quiz['question'],
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            if (quiz['image_url'] != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  quiz['image_url'],
                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    return Text(
                      'Error loading image: $error',
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'No image URL provided',
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                quiz['description'],
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Choices:',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: quiz['correct_choice'] == '1' ? Colors.green : Colors.red,
                ),
                onPressed: () {
                  
                },
                child: Text(
                  '1. ${quiz['choice1']}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Width: Full width, Height: 50
                  backgroundColor: quiz['correct_choice'] == '2' ? Colors.green : Colors.red,
                ),
                onPressed: () {
                  
                },
                child: Text(
                  '2. ${quiz['choice2']}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Width: Full width, Height: 50
                  backgroundColor: quiz['correct_choice'] == '3' ? Colors.green : Colors.red,
                ),
                onPressed: () {
                  
                },
                child: Text(
                  '3. ${quiz['choice3']}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Width: Full width, Height: 50
                  backgroundColor: quiz['correct_choice'] == '4' ? Colors.green : Colors.red,
                ),
                onPressed: () {
                  
                },
                child: Text(
                  '4. ${quiz['choice4']}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Width: Full width, Height: 50
                  backgroundColor: Colors.teal,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(quiz: quiz,),
                      ),
                    );
                },
                child: Text(
                  'Details',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
