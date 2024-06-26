import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddCommentScreen extends StatefulWidget {
  final Map<String, dynamic> quiz;

  const AddCommentScreen({Key? key, required this.quiz}) : super(key: key);

  @override
  _AddCommentScreenState createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _commentController = TextEditingController();
  String? _userName;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        _userName = snapshot['username'];
        _userId = user.uid;
      });
    }
  }

  Future<void> _submitComment() async {
    if (_commentController.text.isEmpty) return;

    User? user = _auth.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection('comments').add({
      'comment': _commentController.text,
      'user_id': _userId,
      'username': _userName,
      'quiz_id': widget.quiz['id'],
      'timestamp': FieldValue.serverTimestamp(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 73, 128, 117),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 73, 128, 117),
        title: const Text('Add Comment', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                hintText: 'Enter your comment',
                filled: true,
                fillColor: Colors.white,
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitComment,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF76ABAE)),
              ),
              child: const Text(
                'Submit Comment',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
