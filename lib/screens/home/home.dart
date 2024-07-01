// import 'package:after_layout/after_layout.dart';
// import 'package:flutter/material.dart';
// import 'package:just_complaint/provider/user_provider.dart';
// import 'package:just_complaint/screens/compaint_screen/complaint_screen.dart.dart';
// import 'package:just_complaint/screens/forms/sing_in.dart';
// import 'package:provider/provider.dart';


// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with AfterLayoutMixin<HomeScreen> {
//   @override
//   void afterFirstLayout(BuildContext context) {
//     _checkUserLoginStatus();
//   }

//   Future<void> _checkUserLoginStatus() async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     await userProvider.getUser();

//     if (userProvider.user != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => ComplaintScreen()),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }
