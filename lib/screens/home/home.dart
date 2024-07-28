import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:just_complaint/constant/constan.dart';
import 'package:just_complaint/model/homr_model.dart';
import 'package:just_complaint/provider/theme_provider.dart';
import 'package:just_complaint/provider/user_provider.dart';
import 'package:just_complaint/widgets/faculties.dart';
import 'package:just_complaint/widgets/imageslider.dart';
import 'package:just_complaint/widgets/relation_ship_of_university.dart';
import 'package:provider/provider.dart';

const kNaBlueColor = Color.fromARGB(255, 4, 32, 46);

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AfterLayoutMixin<HomeScreen> {
  bool isListView = false;
  bool isDrawerOpen = false;

  void toggleView() {
    setState(() {
      isListView = !isListView;
    });
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.loadUserFromPrefs();
    if (userProvider.user == null) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // Load additional data or perform other actions if the user is logged in
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDarkMode
                    ? [kNavyBlueColor, kNavyBlueColor.withOpacity(0.8)]
                    : [Colors.white, Colors.grey[200]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: constraints.maxWidth > 600 ? 400 : 250,
                        child: Imageslider(),
                      ),
                      Positioned(
                        top: 30,
                        left: 10,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isDarkMode ? kNavyBlueColor : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            onPressed: () {
                              ZoomDrawer.of(context)!.toggle();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 2,
                          color: Colors.green,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Faculties',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            isListView ? Icons.list : Icons.grid_view,
                            size: 25,
                            color: Colors.green[600],
                          ),
                          onPressed: toggleView,
                        ),
                      ],
                    ),
                  ),
                  Faculties(isListView: isListView),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 2,
                          color: Colors.green,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Local and International Relations',
                          style: TextStyle(
                            fontSize: 15,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullImageListScreen(imageList: imageList),
                              ),
                            );
                            print('View all pressed');
                          },
                          child: Text(
                            'View all',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: imageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 20, top: 10),
                          child: Container(
                            height: 250,
                            width: 200,
                            decoration: BoxDecoration(
                              color: kJustColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                imageList[index]['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 2,
                          color: Colors.green,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Center',
                          style: TextStyle(
                            fontSize: 15,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            print('View all pressed');
                          },
                          child: Text(
                            'View all',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TypeCenter(isDarkMode: isDarkMode),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'FACTS & FIGURES',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth > 600 ? 4 : 3,
                      childAspectRatio: 1,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 1,
                    ),
                    itemCount: factsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 70,
                        width: 80,
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: isDarkMode ? kNaBlueColor.withOpacity(0.5) : kJustColor.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              factsList[index]['icon'],
                              size: 20,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              factsList[index]['name'],
                              style: TextStyle(
                                fontSize: 12,
                                color: isDarkMode ? Colors.white : Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              factsList[index]['rate'],
                              style: TextStyle(
                                fontSize: 12,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TypeCenter extends StatelessWidget {
  const TypeCenter({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageCenter.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 40, left: 10),
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                color: isDarkMode ? kNaBlueColor.withOpacity(0.5) : kJustColor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: Image.asset(
                          imageCenter[index]['image'],
                          width: 200,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          imageCenter[index]['des'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 90,
                    right: 10,
                    child: Container(
                      height: 25,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 54, 201, 201),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          'Active',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
