import 'package:flutter/material.dart';
import 'package:just_complaint/provider/theme_provider.dart';
import 'package:just_complaint/widgets/about_devloper.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const ProfileScreen({super.key, required this.toggleTheme});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitchValue = false;

  @override
  void initState() {
    super.initState();
    isSwitchValue = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/justs.jpg'),
                        radius: screenWidth * 0.1, // Responsive radius
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jamhuriya University',
                            style: TextStyle(
                              fontSize: screenWidth * 0.05, // Responsive font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Home of quality education',
                            style: TextStyle(
                              fontSize: screenWidth * 0.035, // Responsive font size
                              color: Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: _getDividerColor(context),
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
                        fontSize: screenWidth * 0.05, // Responsive font size
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Divider(
                  color: _getDividerColor(context),
                  thickness: 1.0,
                  indent: 16.0,
                  endIndent: 16.0,
                ),
                _buildListTile(
                  context,
                  'Language',
                  Icons.language_outlined,
                  () {
                    _showLanguageBottomSheet(context);
                  },
                  screenWidth,
                ),
                _buildListTile(
                  context,
                  'About Developer',
                  Icons.code,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeamPage()),
                    );
                  },
                  screenWidth,
                  trailingIcon: Icons.arrow_forward_ios_outlined,
                ),
                _buildListTile(
                  context,
                  'Get Help',
                  Icons.call,
                  () {
                    // Handle Get Help tap
                  },
                  screenWidth,
                  trailingIcon: Icons.arrow_forward_ios_outlined,
                ),
                _buildListTile(
                  context,
                  'Dark Mode',
                  Icons.dark_mode_outlined,
                  null,
                  screenWidth,
                  trailing: Switch(
                    value: isSwitchValue,
                    activeColor: Colors.green[800], // Set the active color to green
                    onChanged: (newValue) {
                      setState(() {
                        isSwitchValue = newValue;
                        Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context,
    String title,
    IconData leadingIcon,
    VoidCallback? onTap,
    double screenWidth, {
    Widget? trailing,
    IconData? trailingIcon,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
          child: Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: onTap,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                title: Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035, // Responsive font size
                  ),
                ),
                leading: Icon(leadingIcon),
                trailing: trailing ??
                    (trailingIcon != null ? Icon(trailingIcon) : null),
              ),
            ),
          ),
        ),
        Divider(
          color: _getDividerColor(context),
          thickness: 1.0,
          indent: 16.0,
          endIndent: 16.0,
        ),
      ],
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

  Color _getDividerColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey[900]! : Colors.grey[300]!;
  }
}
