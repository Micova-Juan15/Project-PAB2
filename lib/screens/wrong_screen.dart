import 'package:flutter/material.dart';

class WrongScreen extends StatelessWidget {
  final Map<String, dynamic> quiz;
  const WrongScreen({Key? key, required this.quiz}) : super(key: key);

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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (quiz['image_url'] != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  quiz['image_url'],
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
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
                quiz['question'],
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      double.infinity, 50),
                  backgroundColor: Colors.teal,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Try Again',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Choices:',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.red,
                ),
                onPressed: () {},
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
                  minimumSize: Size(
                      double.infinity, 50),
                  backgroundColor: Colors.red,
                ),
                onPressed: () {},
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
                  minimumSize: Size(
                      double.infinity, 50),
                  backgroundColor: Colors.red,
                ),
                onPressed: () {},
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
                  minimumSize: Size(
                      double.infinity, 50),
                  backgroundColor: Colors.red,
                ),
                onPressed: () {},
                child: Text(
                  '4. ${quiz['choice4']}',
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
