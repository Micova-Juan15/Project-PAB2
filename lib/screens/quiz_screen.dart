import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('quiz').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No quiz available'));
          }

          final List<QueryDocumentSnapshot> quizList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: quizList.length,
            itemBuilder: (context, index) {
              final questionData = quizList[index].data() as Map<String, dynamic>?;

              if (questionData == null) {
                return SizedBox(); 
              }
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(questionData['question'] as String? ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Choice 1: ${questionData['choice1']}'),
                      Text('Choice 2: ${questionData['choice2']}'),
                      Text('Choice 3: ${questionData['choice3']}'),
                      Text('Choice 4: ${questionData['choice4']}'),
                      Text('Correct Choice: ${questionData['correct_choice']}'),
                      Text('Map Coordinates: ${questionData['map_coordinates']}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
