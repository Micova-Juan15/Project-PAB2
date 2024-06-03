import 'package:flutter/material.dart';
import 'package:project_pab2/screens/addCommentScreen.dart';
import 'package:project_pab2/screens/comment_screen.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> quiz;

  const DetailScreen({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 73, 128, 117),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 73, 128, 117),
        title: const Text('Detail', style: TextStyle(color: Colors.white)),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                quiz['correct_choice'] == '1'
                    ? quiz['choice1']
                    : quiz['correct_choice'] == '2'
                        ? quiz['choice2']
                        : quiz['correct_choice'] == '3'
                            ? quiz['choice3']
                            : quiz['correct_choice'] == '4'
                                ? quiz['choice4']
                                : '??',
                style: const TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
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
              padding: EdgeInsets.all(8.0),
              child: Text(
                quiz['description'],
                style: const TextStyle(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Latitude : ${quiz['latitude']}',
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Longitude : ${quiz['longitude']}',
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CommentScreen(quiz: quiz,)),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF76ABAE)),
              ),
              child: const Text(
                'View Comments',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCommentScreen(quiz: quiz)
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF76ABAE)),
              ),
              child: const Text(
                'Add Comment',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
