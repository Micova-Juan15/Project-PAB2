import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> quiz;

  const DetailScreen({Key? key, required this.quiz}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkIsFavorite();
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> checkIsFavorite() async {
    try {
      final favoriteRef = FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('favorite_quizzes')
          .doc(widget.quiz['id']);

      final docSnapshot = await favoriteRef.get();
      setState(() {
        isFavorite = docSnapshot.exists;
      });
    } catch (e) {
      print('Error checking favorite status: $e');
    }
  }

  Future<void> toggleFavoriteStatus() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final favoriteRef = FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('favorite_quizzes')
          .doc(widget.quiz['id']);

      if (isFavorite) {
        // Remove from favorites if already marked as favorite
        await favoriteRef.delete();
      } else {
        // Add to favorites if not marked as favorite
        await favoriteRef.set(widget.quiz);
      }

      setState(() {
        isFavorite = !isFavorite;
      });
    } catch (e) {
      print('Error toggling favorite status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 73, 128, 117),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 73, 128, 117),
        title: Text('Quiz Details', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: toggleFavoriteStatus,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.quiz['correct_choice'] == '1' ? Text(widget.quiz['choice1'],style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center,) : 
              widget.quiz['correct_choice'] == '2' ? Text(widget.quiz['choice2'],style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center,):
              widget.quiz['correct_choice'] == '3' ? Text(widget.quiz['choice3'],style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center,):
              widget.quiz['correct_choice'] == '4' ? Text(widget.quiz['choice4'],style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center,):
              const Text('??',style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                widget.quiz['image_url'],
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Text(
                    'Error loading image: $error',
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.quiz['description'], 
                style: const TextStyle(color: Colors.white, fontSize: 15), 
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
