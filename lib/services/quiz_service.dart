import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_pab2/models/quiz.dart';

class QuizService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _quizsCollection =
      _database.collection('quiz');
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<void> addQuiz(Quiz quiz) async {
    Map<String, dynamic> newQuiz = {
      'id': quiz.id,
      'question': quiz.question,
      'description': quiz.description,
      'choice1': quiz.choice1,
      'choice2': quiz.choice2,
      'choice3': quiz.choice3,
      'choice4': quiz.choice4,
      'correct_choice': quiz.correctChoice,
      'image_url': quiz.imageUrl,
      'latitude': quiz.latitude,
      'longitude': quiz.longitude,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    };
    await _quizsCollection.add(newQuiz);
  }

  static Future<void> updateQuiz(Quiz quiz) async {
    Map<String, dynamic> updatedQuiz = {
      'question': quiz.question,
      'description': quiz.description,
      'choice1': quiz.choice1,
      'choice2': quiz.choice2,
      'choice3': quiz.choice3,
      'choice4': quiz.choice4,
      'correct_choice': quiz.correctChoice,
      'image_url': quiz.imageUrl,
      'latitude': quiz.latitude,
      'longitude': quiz.longitude,
      'created_at': quiz.createdAt,
      'updated_at': FieldValue.serverTimestamp(),
    };
    await _quizsCollection.doc(quiz.id).update(updatedQuiz);
  }

  static Future<void> deleteQuiz(Map<String, dynamic> quiz) async {
    await _quizsCollection.doc(quiz['id']).delete();
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
          correctChoice: data['correct_choice'],
          imageUrl: data['imageUrl'],
          latitude: data['latitude'],
          longitude: data['longitude'],
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
