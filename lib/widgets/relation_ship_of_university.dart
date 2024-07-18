import 'package:flutter/material.dart';
import 'package:just_complaint/constant/constan.dart';
import 'package:just_complaint/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class FullImageListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> imageList;

  FullImageListScreen({required this.imageList});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Just Relations',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        backgroundColor: isDarkMode ? kNavyBlueColor : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Agreements & Memberships with international institutions',
              style: TextStyle(
                fontSize: 15,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDarkMode ? kNavyBlueColor.withOpacity(0.5) : kJustColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        imageList[index]['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: isDarkMode ? kNavyBlueColor : Colors.white,
    );
  }
}
