import 'package:flutter/material.dart';
import 'package:just_complaint/constant/constan.dart';
import 'package:just_complaint/provider/complaint_provider.dart';
import 'package:just_complaint/provider/response_provider.dart';
import 'package:just_complaint/provider/student_unfo.dart';
import 'package:just_complaint/provider/theme_provider.dart';
import 'package:just_complaint/provider/user_provider.dart';
import 'package:just_complaint/screens/forms/sing_in.dart';
import 'package:just_complaint/widgets/custtom_menu.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ComplaintProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => StudentDataProvider()),
        ChangeNotifierProvider(create: (_) => ResponseProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Student Complaints',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: kNavyBlueColor,
              appBarTheme: AppBarTheme(
                backgroundColor: kNavyBlueColor,
              ),
            ),
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: FutureBuilder(
              future: Provider.of<UserProvider>(context, listen: false).loadUserFromPrefs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  final userProvider = Provider.of<UserProvider>(context, listen: false);
                  return userProvider.user != null ? Custtom() : LoginScreen();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
