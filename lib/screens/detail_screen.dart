import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_pab2/screens/addCommentScreen.dart';
import 'package:project_pab2/screens/comment_screen.dart';

class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> quiz;

  const DetailScreen({Key? key, required this.quiz}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isFavourite = false;
  

  final CollectionReference favorites =
      FirebaseFirestore.instance.collection('favorites');

  @override
  void initState() {
    super.initState();
    _loadIsFavourite(widget.quiz['id']);
  }

  Future<void> toggleFavorite(String itemId) async {
    User? user = _auth.currentUser;
    DocumentReference favoriteDoc =
        favorites.doc(user?.uid).collection('quiz').doc(itemId);
    DocumentSnapshot docSnapshot = await favoriteDoc.get();

    if (docSnapshot.exists) {
      favoriteDoc.delete();
      setState(() {
        isFavourite = false;
      });
    } else {
      favoriteDoc.set({
        'id': widget.quiz['id'],
        'question': widget.quiz['question'],
        'description': widget.quiz['description'],
        'choice1': widget.quiz['choice1'],
        'choice2': widget.quiz['choice2'],
        'choice3': widget.quiz['choice3'],
        'choice4': widget.quiz['choice4'],
        'correct_choice': widget.quiz['correct_choice'],
        'image_url': widget.quiz['image_url'],
        'latitude': widget.quiz['latitude'],
        'longitude': widget.quiz['longitude'],
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });
      setState(() {
        isFavourite = true;
      });
    }
  }

  Future<void> _loadIsFavourite(String itemId) async {
    User? user = _auth.currentUser;
    DocumentReference favoriteDoc =
        favorites.doc(user?.uid).collection('quiz').doc(itemId);
    DocumentSnapshot docSnapshot = await favoriteDoc.get();
    setState(() {
      isFavourite = docSnapshot.exists;
    });
  }

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
        actions: [
          IconButton(
            onPressed: () {
              toggleFavorite(widget.quiz['id']);
            },
            icon: Icon(
              Icons.favorite,
              color: isFavourite ? Colors.red : Colors.grey,
            ),
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
                widget.quiz['correct_choice'] == '1'? widget.quiz['choice1']
                : widget.quiz['correct_choice'] == '2'? widget.quiz['choice2']
                : widget.quiz['correct_choice'] == '3'? widget.quiz['choice3']
                : widget.quiz['correct_choice'] == '4'? widget.quiz['choice4']
                : '??',
                style: const TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            if (widget.quiz['image_url'] != null)
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
                widget.quiz['description'], 
                style: const TextStyle(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Latitude : ${widget.quiz['latitude']}', 
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Longitude : ${widget.quiz['longitude']}', 
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
                          CommentScreen(quiz: widget.quiz,)),
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
                    builder: (context) => AddCommentScreen(quiz: widget.quiz)
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