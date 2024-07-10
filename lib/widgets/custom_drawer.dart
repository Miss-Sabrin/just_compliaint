import 'package:flutter/material.dart';
import 'package:just_complaint/model/menu_items.dart';
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
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.indigo,
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
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Text(
                        'JUST COMPLAINT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                      Text(
                        'Welcome to Jamhuriya Complaints',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              ...MenuItems.all.map((item) => buildMenuItem(context, item)).toList(),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(BuildContext context, MenuItem item) {
    return ListTileTheme(
      selectedColor: Colors.white,
      child: ListTile(
        selectedTileColor: Colors.black26,
        selected: currentItem == item,
        minLeadingWidth: 20,
        leading: Icon(item.icon, color: Colors.white), // Set the icon color to white
        title: Text(item.title, style: TextStyle(color: Colors.white)), // Set the title color to white
        onTap: () {
          onSelectedItem(item);
        },
      ),
    );
  }
}
