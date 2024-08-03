import 'package:flutter/material.dart';

class MenuItem {
  final IconData icon;
  final String title;

  const MenuItem(this.icon, this.title);
}

class MenuItems {
  static const home = MenuItem(Icons.home_outlined, 'Home');
  static const complaintForm = MenuItem(Icons.feedback_outlined, 'Complaint Form');
  static const studentInfo = MenuItem(Icons.school_outlined, 'Student Info');
  static const responseScreen = MenuItem( Icons.message_outlined,'Inbox'); // Add this line
  static const logout = MenuItem(Icons.logout, 'Logout');

  static const all = <MenuItem>[
    home,
    complaintForm,
    studentInfo,
    responseScreen,
    logout,
    
  ];
}
