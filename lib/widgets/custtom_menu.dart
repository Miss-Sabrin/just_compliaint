import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:just_complaint/model/menu_items.dart';
import 'package:just_complaint/screens/compaint_screen/complaint_screen.dart.dart';
import 'package:just_complaint/screens/forms/sing_in.dart';
import 'package:just_complaint/screens/student_info/student_info_screen.dart';
import 'package:just_complaint/widgets/button_navigation_bar.dart';
import 'package:just_complaint/widgets/custom_drawer.dart';

class Custtom extends StatefulWidget {
  const Custtom({super.key});

  @override
  State<Custtom> createState() => _CusttomState();
}

class _CusttomState extends State<Custtom> {
  MenuItem currentItem = MenuItems.home;
  final ZoomDrawerController _drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _drawerController,
      mainScreen: getScreen(), // Dynamically set the main screen
      menuScreen: Builder(
        builder: (context) {
          return CustomDrawer(
            currentItem: currentItem,
            onSelectedItem: (item) {
              setState(() {
                currentItem = item;
              });
              _drawerController.toggle?.call();
            },
          );
        },
      ),
      borderRadius: 30,
      showShadow: true,
      angle: 0.0,
      menuBackgroundColor: Colors.indigo,
    );
  }

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.complaintForm:
        return ComplaintScreen();
      case MenuItems.studentInfo:
        return StudentDataScreen();
      case MenuItems.logout:
        return LoginScreen(); // Add your logout screen here
      case MenuItems.home:
      default:
        return BottomNvbar(); // Use BottomNvbar as the default screen
    }
  }
}
