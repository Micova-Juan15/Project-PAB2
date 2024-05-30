import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_pab2/models/quiz.dart';
import 'package:project_pab2/services/quiz_service.dart';

class InsertScreen extends StatefulWidget {
  @override
  _InsertScreenState createState() => _InsertScreenState();
}

class _InsertScreenState extends State<InsertScreen> {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController choice1Controller = TextEditingController();
  final TextEditingController choice2Controller = TextEditingController();
  final TextEditingController choice3Controller = TextEditingController();
  final TextEditingController choice4Controller = TextEditingController();
  final TextEditingController correctChoiceController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longtitudeController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  void _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  void _insertQuestion() async {
    try {
      if (_imageFile == null) {
        print('No image selected.');
        return;
      }
      String imageUrl = '';

      Quiz quiz = Quiz(
        question: questionController.text,
        description: descriptionController.text,
        choice1: choice1Controller.text,
        choice2: choice2Controller.text,
        choice3: choice3Controller.text,
        choice4: choice4Controller.text,
        correctChoice: correctChoiceController.text,
        latitude: latitudeController.text,
        longitude: longtitudeController.text,
        imageUrl: imageUrl,
      );
      await QuizService.addQuiz(quiz);

      Navigator.pop(context);
    } catch (e) {
      print('Error inserting question: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 73, 128, 117),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 73, 128, 117),
        title: Text('Insert Question', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              child: const Text(
                'Pick Image',
                style: TextStyle(color: Colors.white),
              ),
            ),
            if (_imageFile != null) ...[
              Image.file(_imageFile!),
              const SizedBox(height: 20),
            ],
            const SizedBox(height: 10),
            const Text(
              "Question",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            TextFormField(
              controller: questionController,
              cursorColor: const Color(0xFF777777),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Question',
                hintStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 5.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Description",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            TextFormField(
              controller: descriptionController,
              cursorColor: const Color(0xFF777777),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Description',
                hintStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 5.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Choice 1",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            TextFormField(
              controller: choice1Controller,
              cursorColor: const Color(0xFF777777),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Choice 1',
                hintStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 5.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Choice 2",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            TextFormField(
              controller: choice2Controller,
              cursorColor: const Color(0xFF777777),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Choice 2',
                hintStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 5.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Choice 3",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            TextFormField(
              controller: choice3Controller,
              cursorColor: const Color(0xFF777777),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Choice 3',
                hintStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 5.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Choice 4",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            TextFormField(
              controller: choice4Controller,
              cursorColor: const Color(0xFF777777),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Choice 4',
                hintStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 5.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Correct Choice",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            TextFormField(
              controller: correctChoiceController,
              cursorColor: const Color(0xFF777777),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Correct Choice',
                hintStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 5.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Latitude",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            TextFormField(
              controller: latitudeController,
              cursorColor: const Color(0xFF777777),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Latitude',
                hintStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 5.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Longtitude",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            TextFormField(
              controller: longtitudeController,
              cursorColor: const Color(0xFF777777),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Longtitude',
                hintStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 5.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _insertQuestion,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              child: const Text(
                'Insert Question',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
