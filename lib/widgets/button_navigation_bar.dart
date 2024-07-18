import 'package:flutter/material.dart';
import 'package:just_complaint/constant/constan.dart';
import 'package:just_complaint/provider/theme_provider.dart';
import 'package:just_complaint/screens/compaint_screen/complaint_screen.dart.dart';
import 'package:just_complaint/screens/home/home.dart';
import 'package:just_complaint/screens/profile/profile.dart';
import 'package:just_complaint/screens/student_info/student_info_screen.dart';
import 'package:provider/provider.dart';

class BottomNvbar extends StatefulWidget {
  final int initialIndex;

  BottomNvbar({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<BottomNvbar> createState() => _BottomNvbarState();
}

class _BottomNvbarState extends State<BottomNvbar> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  final List<Widget> screens = [
    HomeScreen(),
    ComplaintScreen(),
    StudentDataScreen(),
    ProfileScreen(toggleTheme: () {})
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? kNavyBlueColor.withOpacity(0.5) : kJustColor.withOpacity(0.9),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDarkMode ? kNavyBlueColor.withOpacity(0.5) : kJustColor.withOpacity(0.9),
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
        selectedItemColor: isDarkMode ? Colors.green : Colors.green,
        unselectedItemColor: isDarkMode ? Colors.white70 : Colors.black54,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
