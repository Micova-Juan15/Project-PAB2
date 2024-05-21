import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_pab2/widgets/profile_info.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;
  String fullName = '';
  String userName = '';
  String email = '';
  bool isSignedIn = false;
  final picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        fullName = userDoc['fullname'];
        userName = userDoc['username'];
        email = user.email!;
        isSignedIn = true;
      });
    }
  }

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    try {
      if (_imageFile != null) {
        String imageName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
        Reference ref = _storage.ref().child('profile_images/$imageName');
        await ref.putFile(_imageFile!);
        String imageUrl = await ref.getDownloadURL();

        // Simpan URL gambar di Firestore
        await _firestore.collection('users').doc(_auth.currentUser!.uid).update({'imageUrl': imageUrl});

        // Perbarui gambar profil di UI
        setState(() {
          _imageFile = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile image updated successfully')));
      }
    } catch (e) {
      print('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error uploading image')));
    }
  }

  void signOut() async {
    await _auth.signOut();
    setState(() {
      isSignedIn = false;
    });
    Navigator.pushReplacementNamed(context, '/landing');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile User',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        actions: [
          if (isSignedIn)
            IconButton(
              onPressed: signOut,
              icon: const Icon(Icons.logout),
            ),
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                await _getImage();
                await _uploadImage();
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: _imageFile != null
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(_imageFile!),
                          )
                        : const CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage('images/default_avatar.png'),
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.indigo,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white),
            const SizedBox(height: 10),
            ProfileInfoItem(
              label: 'Username',
              value: userName,
            ),
            const Divider(color: Colors.white),
            const SizedBox(height: 10),
            ProfileInfoItem(
              label: 'Email',
              value: email,
            ),
            const Divider(color: Colors.white),
          ],
        ),
      ),
    );
  }
}