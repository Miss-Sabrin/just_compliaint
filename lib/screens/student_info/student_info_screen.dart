import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:just_complaint/constant/constan.dart';
import 'package:just_complaint/provider/complaint_provider.dart';
import 'package:just_complaint/provider/theme_provider.dart';
import 'package:just_complaint/provider/user_provider.dart';
import 'package:provider/provider.dart';

class StudentDataScreen extends StatefulWidget {
  @override
  _StudentDataScreenState createState() => _StudentDataScreenState();
}

class _StudentDataScreenState extends State<StudentDataScreen> with AfterLayoutMixin<StudentDataScreen> {
  @override
  void afterFirstLayout(BuildContext context) {
    _fetchData();
  }

  void _fetchData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final complaintProvider = Provider.of<ComplaintProvider>(context, listen: false);

    if (userProvider.user != null && userProvider.user!.id != null) {
      await complaintProvider.fetchComplaintsByStudentId(userProvider.user!.id!);
    } else {
      // Handle the case where user is null or user id is null
      print('User ID is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    final complaintProvider = Provider.of<ComplaintProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [kNavyBlueColor.withOpacity(0.8), kNavyBlueColor]
                : [Colors.white, Colors.white],
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
                    height: 100,
                    child: Container(
                      child: Center(
                        child: Text(
                          'Complaints in Student',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 10,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        ZoomDrawer.of(context)!.toggle();
                      },
                    ),
                  ),
                ],
              ),
              Consumer<ComplaintProvider>(
                builder: (ctx, complaintProvider, child) {
                  final stdData = complaintProvider.complaints;
                  if (complaintProvider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (complaintProvider.error.isNotEmpty) {
                    return Center(child: Text('An error occurred! ${complaintProvider.error}'));
                  }
                  return Padding(
                    padding: const EdgeInsets.only(left: 2,right: 30),
                    
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Text(
                            'Name',
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Description',
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Category',
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ],
                      rows: stdData.isNotEmpty
                          ? stdData
                              .map(
                                (complaint) => DataRow(cells: [
                                  DataCell(Text(
                                    '${userProvider.user?.name ??""}',
                                    style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                                  )),
                                  DataCell(Container(
                                    width: size.width * 0.4, // Use MediaQuery to set width
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            backgroundColor: isDarkMode ? kNavyBlueColor : Colors.white,
                                            title: Text(
                                              'Description',
                                              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                                            ),
                                            content: Text(
                                              complaint.description,
                                              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                                            ),
                                            actions: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Text(
                                                      'Close',
                                                      style: TextStyle(color: isDarkMode ? Colors.grey : Colors.blue),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      child: Text(
                                        complaint.description,
                                        style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white : Colors.black),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3, // Limit the number of lines
                                      ),
                                    ),
                                  )),
                                  DataCell(
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                                      child: Text(
                                        complaint.category,
                                        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                                      ),
                                    ),
                                  ),
                                ]),
                              )
                              .toList()
                          : [
                              DataRow(cells: [
                                DataCell(Container(width: size.width * 0.4, child: Text('No data', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)))),
                                DataCell(Container(width: size.width * 0.2, child: Text('No data', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)))),
                                DataCell(Container(width: size.width * 0.2, child: Text('No data', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)))),
                              ]),
                            ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
