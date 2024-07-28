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
    ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController = ScrollController();

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

    return DefaultTabController(
      length: screens.length,
      initialIndex: currentIndex,
      child: Scaffold(
        body: TabBarView(
          children: screens,
        ),
        bottomNavigationBar: Container(
          //padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Container(
              width: double.infinity,
              color: isDarkMode
                  ? const Color.fromARGB(255, 13, 43, 56).withOpacity(0.2)
                  : kJustColor.withOpacity(0.2),
              child: TabBar(
                tabs: const [
                  Tab(icon: Icon(Icons.home), text: 'Home'),
                  Tab(icon: Icon(Icons.description_outlined), text: 'Complaint Form'),
                  Tab(icon: Icon(Icons.school_outlined), text: 'Student Info'),
                  Tab(icon: Icon(Icons.person_outline), text: 'Profile'),
                ],
                labelColor: isDarkMode ? Colors.green : Colors.green,
                unselectedLabelColor: isDarkMode ? Colors.white70 : Colors.black54,
                indicator: BoxDecoration(), // Remove the bottom underline
                labelStyle: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
