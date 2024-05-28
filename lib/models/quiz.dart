import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  String? id;
  final String question;
  final String description;
  final String choice1;
  final String choice2;
  final String choice3;
  final String choice4;
  final String correctChoice;
  final String latitude;
  final String longitude;
  String? imageUrl;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  Quiz(
      {this.id,
      required this.question,
      required this.description,
      required this.choice1,
      required this.choice2,
      required this.choice3,
      required this.choice4,
      required this.correctChoice,
      required this.latitude,
      required this.longitude,
      this.imageUrl,
      this.createdAt,
      this.updatedAt});
  
  factory Quiz.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Quiz(
      id: doc.id,
      question: data['question'],
      description: data['description'],
      choice1: data['choice1'],
      choice2: data['choice2'],
      choice3: data['choice3'],
      choice4: data['choice4'],
      correctChoice: data['description'],
      imageUrl: data['image_url'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      createdAt: data['created_at'] as Timestamp,
      updatedAt: data['updated_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'question': question,
      'description': description,
      'choice1' : choice1,
      'choice2' : choice2,
      'choice3' : choice3,
      'choice4' : choice4,
      'correct_choice' : correctChoice,
      'image_url': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
