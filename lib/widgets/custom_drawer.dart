import 'dart:math';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

        double maxTitleFontSize = 20.0;
        double maxSubtitleFontSize = 15.0;
        double maxMenuFontSize = 18.0;

        return Scaffold(
          backgroundColor: isDarkMode ? kNavyBlueColor : Colors.indigo,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.03, bottom: screenHeight * 0.07, left: screenWidth * 0.05),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: screenHeight * 0.01),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'JUST ',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white, // Change to your desired color
                                    fontSize: min(screenWidth * 0.09, maxTitleFontSize),
                                    fontWeight: FontWeight.w900, // Set numeric bold value
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1.5, 1.5),
                                        blurRadius: 2.0,
                                        color: Colors.black,
                                      ),
                                      Shadow(
                                        offset: Offset(-1.5, -1.5),
                                        blurRadius: 2.0,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                ),
                                TextSpan(
                                  text: 'COMPLAINT',
                                  style: GoogleFonts.roboto(
                                    color: Colors.green, // Change to your desired color
                                    fontSize: min(screenWidth * 0.09, maxTitleFontSize),
                                    fontWeight: FontWeight.w900, // Set numeric bold value
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1.5, 10.5),
                                        blurRadius: 2.0,
                                        color: Colors.black54,
                                      ),
                                      Shadow(
                                        offset: Offset(-1.5, -1.5),
                                        blurRadius: 2.0,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
      },
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
            fontSize: min(screenWidth * 0.06, maxMenuFontSize),
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
            fontSize: min(screenWidth * 0.06, maxMenuFontSize),
          ),
        ),
        onTap: () {
          onSelectedItem(item);
        },
      ),
    );
  }
}
