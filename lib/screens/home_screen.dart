import 'package:flutter/material.dart';
import 'package:project_pab2/screens/insert_screen.dart';
import 'package:project_pab2/screens/profile_screen.dart';
import 'package:project_pab2/screens/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 73, 128, 117),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 73, 128, 117),
        title: Text('Home', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            icon: Icon(Icons.person),
            color: Colors.white,
          )
        ],
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
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizScreen()),
              );
            },
            child: const Icon(Icons.quiz_outlined),
          ),
        ],
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
              final questionData =
                  quizList[index].data() as Map<String, dynamic>?;

              if (questionData == null) {
                return SizedBox();
              }

              //-------------//
              return ElevatedButton(
                onPressed: () {
                  // Navigasi ke layar kuis di sini
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            QuizScreen()), // Ganti QuizScreen() dengan nama kelas layar kuis Anda
                  );
                },
                child: Text('Quiz ${index + 1}'),
              );
            },
          );
        },
      ),
    );
  }
}
