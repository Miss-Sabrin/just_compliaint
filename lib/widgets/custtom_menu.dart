import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:just_complaint/constant/constan.dart';
import 'package:just_complaint/model/menu_items.dart';
import 'package:just_complaint/provider/theme_provider.dart';
import 'package:just_complaint/provider/user_provider.dart';
import 'package:just_complaint/screens/compaint_screen/complaint_screen.dart.dart';
import 'package:just_complaint/screens/forms/sing_in.dart';
import 'package:just_complaint/screens/inbox/inbox.dart';
import 'package:just_complaint/screens/student_info/student_info_screen.dart';
import 'package:just_complaint/widgets/button_navigation_bar.dart';
import 'package:just_complaint/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class Custtom extends StatefulWidget {
  const Custtom({super.key});

  @override
  State<Custtom> createState() => _CusttomState();
}

class _CusttomState extends State<Custtom> {
  MenuItem currentItem = MenuItems.home;
  final ZoomDrawerController _drawerController = ZoomDrawerController();

  @override
  void initState() {
    super.initState();
  
  }

 

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return ZoomDrawer(
      controller: _drawerController,
      mainScreen: getScreen(),
      menuScreen: Builder(
        builder: (context) {
          return CustomDrawer(
            currentItem: currentItem,
            onSelectedItem: (item) async {
              if (item == MenuItems.logout) {
                // Call the logout method
                await Provider.of<UserProvider>(context, listen: false).logoutUser();
                // Navigate to the LoginScreen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              } else {
                setState(() {
                  currentItem = item;
                });
               
              }
              _drawerController.toggle?.call();
            },
          );
        },
      ),
      borderRadius: 30,
      showShadow: true,
      angle: 0.0,
      menuBackgroundColor: isDarkMode ? kNavyBlueColor : Colors.indigo,
    );
  }

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.complaintForm:
        return ComplaintScreen();
      case MenuItems.studentInfo:
        return StudentDataScreen();
      case MenuItems.responseScreen:
        return ResponseScreen();
      case MenuItems.home:
      default:
        return BottomNvbar();
    }
  }
}
