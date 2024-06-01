import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'favorite_screen.dart'; // Import FavoriteScreen.dart
import 'landing_screen.dart'; // Import LandingScreen.dart for logout

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final TextEditingController _usernameController = TextEditingController();

  bool isSignedIn = true;
  String userName = '';
  String email = '';
  File? _imageFile;
  String? imageUrl;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
  

  void _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        isSignedIn = true;
        userName = userDoc['username'];
        email = user.email ?? '';
        if (imageUrl == null) {
          imageUrl = '';
        } else {
          imageUrl = userDoc['imageUrl'];
        }
      });
      _usernameController.text = userName;
    }
  }

  Future<void> _updateUsername(String newUsername) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update({'username': newUsername});
      setState(() {
        userName = newUsername;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username updated successfully')));
      _usernameController.text = newUsername;
    } catch (e) {
      print('Error updating username: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error updating username')));
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    try {
      setState(() {
        isLoading = true;
        _imageFile = imageFile; // Update _imageFile variable
      });

      String imageName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      String userId = _auth.currentUser!.uid;
      Reference ref = _storage.ref().child('profile_images/$userId/$imageName');
      TaskSnapshot uploadTask = await ref.putFile(imageFile);
      String downloadUrl = await uploadTask.ref.getDownloadURL();

      await _firestore
          .collection('users')
          .doc(userId)
          .update({'imageUrl': downloadUrl});

      setState(() {
        isLoading = false;
        imageUrl = downloadUrl;
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Profile picture updated successfully')));
    } catch (e) {
      print('Error uploading image: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error uploading image')));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 73, 128, 117),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  tooltip: 'Back',
                ),
                const Text(
                  'User Profile',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!) as ImageProvider<Object>
                          : imageUrl != null && imageUrl!.isNotEmpty
                              ? NetworkImage(imageUrl!) as ImageProvider<Object>
                              : null,
                      child: imageUrl == null && _imageFile == null
                          ? const Icon(Icons.person,
                              size: 50, color: Colors.white)
                          : null,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final pickedFile = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Select Image Source'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(ImageSource.camera);
                                },
                                child: const Text('Camera'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(ImageSource.gallery);
                                },
                                child: const Text('Gallery'),
                              ),
                            ],
                          );
                        },
                      );
                      if (pickedFile != null) {
                        final imagePicker = ImagePicker();
                        final pickedImage = await imagePicker.pickImage(
                          source: pickedFile,
                        );

                        if (pickedImage != null) {
                          File imageFile = File(pickedImage.path);
                          _uploadImage(imageFile);
                        } else {
                          print('No image selected.');
                        }
                      }
                    },
                    icon: const Icon(Icons.add_a_photo, color: Colors.white),
                    iconSize: 20,
                    tooltip: 'Change Profile Picture',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.white),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: const Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        'Email: ',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    email,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: const Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        'Username: ',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    userName,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Change Username'),
                          content: TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                                hintText: 'Enter new username'),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                String newUsername =
                                    _usernameController.text.trim();
                                if (newUsername.isNotEmpty) {
                                  _updateUsername(newUsername);
                                }
                                Navigator.of(context).pop();
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.edit, color: Colors.white),
                  tooltip: 'Edit Username',
                ),
              ],
            ),
            const Divider(color: Colors.white),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: const Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        'Favorite: ',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FavoriteScreen()));
                    },
                    child: const Text(
                      'View favorite list',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
                  _auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LandingScreen()),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Logout',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
