import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_pab2/screens/answer_screen.dart';
import 'package:project_pab2/services/quiz_service.dart';

class QuizScreen extends StatefulWidget {
  final Map<String, dynamic> quiz;
  const QuizScreen({Key? key, required this.quiz}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? role;
  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  void _loadRole() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        role = userDoc['role'];
      });
    }
  }

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
          role == 'A'?
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              QuizService.deleteQuiz(widget.quiz);
            },
          ): SizedBox(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.quiz['image_url'] != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  widget.quiz['image_url'],
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
                widget.quiz['question'],
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
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
                  minimumSize: Size(
                      double.infinity, 50), // Width: Full width, Height: 50
                  backgroundColor: Colors.teal, // Background color
                ),
                onPressed: () {
                  if (widget.quiz['correct_choice'] == '1') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnswerScreen(
                          quiz: widget.quiz,
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  '1. ${widget.quiz['choice1']}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      double.infinity, 50), // Width: Full width, Height: 50
                  backgroundColor: Colors.teal, // Background color
                ),
                onPressed: () {
                  if (widget.quiz['correct_choice'] == '2') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnswerScreen(
                          quiz: widget.quiz,
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  '2. ${widget.quiz['choice2']}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      double.infinity, 50), // Width: Full width, Height: 50
                  backgroundColor: Colors.teal, // Background color
                ),
                onPressed: () {
                  if (widget.quiz['correct_choice'] == '3') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnswerScreen(
                          quiz: widget.quiz,
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  '3. ${widget.quiz['choice3']}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                      double.infinity, 50), // Width: Full width, Height: 50
                  backgroundColor: Colors.teal, // Background color
                ),
                onPressed: () {
                  if (widget.quiz['correct_choice'] == '4') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnswerScreen(
                          quiz: widget.quiz,
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  '4. ${widget.quiz['choice4']}',
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

