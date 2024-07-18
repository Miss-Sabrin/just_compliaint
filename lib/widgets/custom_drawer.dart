import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_complaint/constant/constan.dart';
import 'package:just_complaint/model/menu_items.dart';
import 'package:just_complaint/provider/theme_provider.dart';
import 'package:just_complaint/provider/user_provider.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  const CustomDrawer({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    final userProvider = Provider.of<UserProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define max font size
    double maxTitleFontSize = 20.0;
    double maxSubtitleFontSize = 15.0;
    double maxMenuFontSize = 18.0;

    return Scaffold(
      backgroundColor: isDarkMode ?kNavyBlueColor : Colors.indigo,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 30, bottom: 70, left: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'JUST COMPLAINT',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.white,
                          fontSize: min(screenWidth * 0.05, maxTitleFontSize), // Responsive with max size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        'Jamhuriya Complaints',
                        style: TextStyle(
                          fontSize: min(screenWidth * 0.03, maxSubtitleFontSize), // Responsive with max size
                          color: isDarkMode ? Colors.white70 : Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              ...MenuItems.all.map((item) => buildMenuItem(context, item, screenWidth, isDarkMode)).toList(),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(BuildContext context, MenuItem item, double screenWidth, bool isDarkMode) {
    double maxMenuFontSize = 18.0;
    return ListTileTheme(
      selectedColor: isDarkMode ? Colors.tealAccent : Colors.white,
      child: ListTile(
        selectedTileColor: isDarkMode ? Colors.white24 : Colors.black26,
        selected: currentItem == item,
        minLeadingWidth: 20,
        leading: Icon(item.icon, color: isDarkMode ? Colors.white : Colors.white),
        title: Text(
          item.title,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.white,
            fontSize: min(screenWidth * 0.04, maxMenuFontSize), // Responsive with max size
          ),
        ),
        onTap: () {
          onSelectedItem(item);
        },
      ),
    );
  }
}
