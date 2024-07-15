import 'package:flutter/material.dart';
import 'package:just_complaint/screens/compaint_screen/complaint_screen.dart.dart';
import 'package:just_complaint/screens/home/home.dart';
import 'package:just_complaint/screens/profile/profile.dart';
import 'package:just_complaint/screens/student_info/student_info_screen.dart';

class BottomNvbar extends StatefulWidget {
  final int initialIndex; // Add an initialIndex parameter

  BottomNvbar({Key? key, this.initialIndex = 0}) : super(key: key); // Default to 0

  @override
  State<BottomNvbar> createState() => _BottomNvbarState();
}

class _BottomNvbarState extends State<BottomNvbar> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex; // Initialize with the passed index
  }

  final List<Widget> screens = [
    HomeScreen(),
    ComplaintScreen(),
    StudentDataScreen(),
    ProfileScreen(toggleTheme: (){}) // Placeholder for a profile or other screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF00BCD4),
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            label: 'Complaint Form',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            label: 'Student Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black54,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
