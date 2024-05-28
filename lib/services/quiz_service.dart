import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_pab2/models/quiz.dart';

class QuizService{
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _quizsCollection = _database.collection('quiz');
  static final FirebaseStorage _storage = FirebaseStorage.instance;

static Future<void> addQuiz(Quiz quiz) async {
    Map<String, dynamic> newQuiz = {
      'question': quiz.question,
      'description': quiz.description,
      'image_url': quiz.imageUrl,
      'latitude': quiz.latitude,
      'longitude': quiz.longitude,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    };
    await _quizsCollection.add(newQuiz);
  }

  static Future<void> updateNote(Quiz quiz) async {
    Map<String, dynamic> updatedQuiz = {
      'question': quiz.question,
      'description': quiz.description,
      'image_url': quiz.imageUrl,
      'latitude': quiz.latitude,
      'longitude': quiz.longitude,
      'created_at': quiz.createdAt,
      'updated_at': FieldValue.serverTimestamp(),
    };
    await _quizsCollection.doc(quiz.id).update(updatedQuiz);
  }

  static Future<void> deleteQuiz(Quiz quiz) async {
    await _quizsCollection.doc(quiz.id).delete();
  }

  static Future<QuerySnapshot> retrieveQuizs() {
    return _quizsCollection.get();
  }

  static Stream<List<Quiz>> getQuizList() {
    return _quizsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Quiz(
          id: doc.id,
          question: data['question'],
          description: data['description'],
          choice1: data['choice1'],
          choice2: data['choice2'],
          choice3: data['choice3'],
          choice4: data['choice4'],
          correctChoice: data['correctChoice'],
          imageUrl: data['image_url'],
          latitude:
              data['latitude'] != null ? data['latitude'] as double : null,
          longitude:
              data['longitude'] != null ? data['longitude'] as double : null,
          createdAt: data['created_at'] != null
              ? data['created_at'] as Timestamp
              : null,
          updatedAt: data['updated_at'] != null
              ? data['updated_at'] as Timestamp
              : null,
        );
      }).toList();
    });
  }
}