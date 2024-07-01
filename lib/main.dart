import 'package:flutter/material.dart';
import 'package:just_complaint/provider/complaint_provider.dart';
import 'package:just_complaint/provider/student_unfo.dart';
import 'package:just_complaint/provider/user_provider.dart';
import 'package:just_complaint/screens/compaint_screen/complaint_screen.dart.dart';
import 'package:just_complaint/screens/forms/sing_in.dart';
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

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false    ,
        title: 'Student Complaints',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<UserProvider>(builder: (context,userProvider , child) {
          return userProvider.user!=null ? ComplaintScreen() :LoginScreen();
        },),
      ),
    );
  }
}
