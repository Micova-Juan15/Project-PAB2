import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_pab2/screens/landing_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String defaultImageUrl = 'assets/default_avatar.png';
  TextEditingController _usernameController = TextEditingController();

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
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        isSignedIn = true;
        userName = userDoc['username'];
        email = user.email ?? '';
        imageUrl = userDoc['imageUrl'];
      });
      _usernameController.text = userName;
    }
  }

  Future<void> _updateUsername(String newUsername) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({'username': newUsername});
      setState(() {
        userName = newUsername;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Username updated successfully')));
      _usernameController.text = newUsername;
    } catch (e) {
      print('Error updating username: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating username')));
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    try {
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });

        String imageName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
        String userId = _auth.currentUser!.uid;
        Reference ref = _storage.ref().child('profile_images/$userId/$imageName');
        TaskSnapshot uploadTask = await ref.putFile(imageFile);
        String downloadUrl = await uploadTask.ref.getDownloadURL();

        await _firestore.collection('users').doc(userId).update({'imageUrl': downloadUrl});

        setState(() {
          isLoading = false;
          imageUrl = downloadUrl; 
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile image updated successfully')));
      }
    } catch (e) {
      print('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error uploading image')));
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LandingScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 73, 128, 117),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 20),
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
                  'Profile User',
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
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : imageUrl != null
                                  ? NetworkImage(imageUrl!)
                                  : AssetImage(defaultImageUrl) as ImageProvider,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () async {
                      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        File imageFile = File(pickedFile.path);
                        _uploadImage(imageFile);
                      } else {
                        print('No image selected.');
                      }
                    },
                    icon: const Icon(Icons.add_a_photo),
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
                        'Email',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    email,
                    style: const TextStyle(fontSize: 25, color: Colors.white),
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
                        'Username',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                        fontSize: 25, 
                        color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.white,
                      ),
                    ],
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
                            decoration: const InputDecoration(hintText: 'Enter new username'),
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
                                String newUsername = _usernameController.text.trim();
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
                  icon: const Icon(Icons.edit),
                  tooltip: 'Edit Username',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
