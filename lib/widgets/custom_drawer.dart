import 'package:flutter/material.dart';
import 'package:just_complaint/provider/user_provider.dart';
import 'package:just_complaint/screens/compaint_screen/complaint_screen.dart.dart';
import 'package:just_complaint/screens/student_info/student_info_screen.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userProvider.user!.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 10),
                if (userProvider.user != null)
                  Text(
                    userProvider.user!.email,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
              ],
            ),
          ),
          ListTile(
            title: Text('Complaint Form'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ComplaintScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Student Info'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => StudentDataScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
