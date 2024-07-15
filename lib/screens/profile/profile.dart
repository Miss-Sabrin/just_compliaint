import 'package:flutter/material.dart';
import 'package:just_complaint/provider/theme_peovider.dart';
import 'package:just_complaint/widgets/about_devloper.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  const ProfileScreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_important_outlined),
            onPressed: () {
              print('Notification icon pressed');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/justs.jpg'),
                  radius: 40,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jamhuriya University',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Home of quality education',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1.0,
            indent: 16.0,
            endIndent: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Setting',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Divider(
            color: Colors.grey[300],
            thickness: 1.0,
            indent: 16.0,
            endIndent: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  _showLanguageBottomSheet(context);
                },
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                  title: Text(
                    'Language',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  leading: Icon(Icons.language_outlined),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1.0,
            indent: 16.0,
            endIndent: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                title: Text(
                  'About Developer',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                leading: Icon(Icons.code),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TeamPage()),
                  );
                },
              ),
            ),
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1.0,
            indent: 16.0,
            endIndent: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                title: Text(
                  'Get Help',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                leading: Icon(Icons.call),
                onTap: () {
                  // Handle Get Help tap
                },
              ),
            ),
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1.0,
            indent: 16.0,
            endIndent: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                title: Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    toggleTheme();
                  },
                ),
                leading: Icon(Icons.dark_mode_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose Language',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: ListTile(
                  leading: Icon(Icons.flag),
                  title: Text('Somali'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 8),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: ListTile(
                  leading: Icon(Icons.flag),
                  title: Text('English'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
