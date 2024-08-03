import 'dart:math';

import 'package:badges/badges.dart' as badges;
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double maxTitleFontSize = 20.0;
    double maxSubtitleFontSize = 15.0;
    double maxMenuFontSize = 18.0;

    return Scaffold(
      backgroundColor: isDarkMode ? kNavyBlueColor : Colors.indigo,
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
                          fontSize: min(screenWidth * 0.05, maxTitleFontSize),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      // Text(
                      //   'Jamhuriya Complaints',
                      //   style: TextStyle(
                      //     fontSize: min(screenWidth * 0.03, maxSubtitleFontSize),
                      //     color: isDarkMode ? Colors.white70 : Colors.white70,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              ...MenuItems.all.map((item) {
                return Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                    if (item == MenuItems.responseScreen) {
                      return buildMenuItemWithBadge(context, item, screenWidth, isDarkMode, userProvider.newResponsesCount);
                    } else {
                      return buildMenuItem(context, item, screenWidth, isDarkMode);
                    }
                  },
                );
              }).toList(),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItemWithBadge(BuildContext context, MenuItem item, double screenWidth, bool isDarkMode, int badgeCount) {
    double maxMenuFontSize = 18.0;
    return ListTileTheme(
      selectedColor: isDarkMode ? Colors.tealAccent : Colors.white,
      child: ListTile(
        selectedTileColor: isDarkMode ? Colors.white24 : Colors.black26,
        selected: currentItem == item,
        minLeadingWidth: 20,
        leading: badges.Badge(
          position: badges.BadgePosition.topEnd(top: -1, end: 1),
          badgeContent: Text(
            badgeCount.toString(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
          ),
          badgeAnimation: const badges.BadgeAnimation.fade(),
          showBadge: badgeCount > 0,
          child: Icon(item.icon, color: isDarkMode ? Colors.white : Colors.white),
        ),
        title: Text(
          item.title,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.white,
            fontSize: min(screenWidth * 0.04, maxMenuFontSize),
          ),
        ),
        onTap: () {
          if (item == MenuItems.responseScreen) {
            Provider.of<UserProvider>(context, listen: false).resetNewResponsesCount();
          }
          onSelectedItem(item);
        },
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
            fontSize: min(screenWidth * 0.04, maxMenuFontSize),
          ),
        ),
        onTap: () {
          onSelectedItem(item);
        },
      ),
    );
  }
}
