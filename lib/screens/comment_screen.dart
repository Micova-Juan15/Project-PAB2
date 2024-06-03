import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  final Map<String, dynamic> quiz;
  const CommentScreen({Key? key, required this.quiz}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final CollectionReference comments =
      FirebaseFirestore.instance.collection('comments');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 73, 128, 117),
        title:
            const Text('User Comments', style: TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: comments.orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No comments found'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var comment = snapshot.data!.docs[index];
              if(widget.quiz['id'] == comment.get('quiz_id'))
              return CommentCard(comment: comment);
            },
          );
        },
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final QueryDocumentSnapshot comment;

  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment['comment'],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8.0),
            Text(
              'User: ${comment['username']}',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Timestamp: ${comment['timestamp'] != null ? (comment['timestamp'] as Timestamp).toDate().toString() : 'N/A'}',
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
