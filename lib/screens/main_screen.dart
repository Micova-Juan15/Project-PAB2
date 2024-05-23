import 'package:flutter/material.dart';
import 'package:project_pab2/screens/favorite_screen.dart';
import 'package:project_pab2/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> { 
  int _currentIndex = 0;
  final List<Widget> _children = [
    FavoriteScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
        bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.indigo,
        ),
        
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              label: 'Menu', 
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Color.fromARGB(255, 236, 236, 236),
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              label: 'Profile', 
            ),
          ],
          selectedItemColor: Color.fromARGB(255, 255, 255, 255),
          unselectedItemColor: Color.fromARGB(212, 0, 0, 0),
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}