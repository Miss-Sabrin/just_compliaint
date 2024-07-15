import 'package:flutter/material.dart';
import 'package:just_complaint/provider/complaint_provider.dart';
import 'package:just_complaint/provider/student_unfo.dart';
import 'package:just_complaint/provider/theme_peovider.dart';
import 'package:just_complaint/provider/user_provider.dart';
import 'package:just_complaint/screens/forms/sing_in.dart';
import 'package:just_complaint/widgets/about_devloper.dart';
import 'package:just_complaint/widgets/custtom_menu.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ComplaintProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => StudentDataProvider()),
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) {
            ThemeNotifier themeNotifier = ThemeNotifier();
            themeNotifier.init(); // Initialize themeNotifier
            return themeNotifier;
          },
        ),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Student Complaints',
            theme: themeNotifier.lightTheme,
            darkTheme: themeNotifier.darkTheme,
            themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return userProvider.user != null ? Custtom() : LoginScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
