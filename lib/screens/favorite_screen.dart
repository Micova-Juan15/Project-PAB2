import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_pab2/screens/detail_screen.dart';
import 'package:project_pab2/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 73, 128, 117),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 73, 128, 117),
        title: const Text('Favorite', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
            icon: const Icon(Icons.person),
            color: Colors.white,
          )
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('favorites').doc(_auth.currentUser!.uid).collection('quiz').get(),
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

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: quizList.length,
            itemBuilder: (context, index) {
              final quiz = quizList[index].data() as Map<String, dynamic>?;

              if (quiz == null) {
                return const SizedBox();
              }

              return Column(
                children: [
                  const Padding(padding: EdgeInsets.all(10)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(quiz: quiz)),
                      );
                    },
                    child: quiz['correct_choice'] == '1' ? Text(quiz['choice1'],style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.center,) : 
              quiz['correct_choice'] == '2' ? Text(quiz['choice2'],style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.center,):
              quiz['correct_choice'] == '3' ? Text(quiz['choice3'],style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.center,):
              quiz['correct_choice'] == '4' ? Text(quiz['choice4'],style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.center,):
              const Text('??',style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.center,),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
