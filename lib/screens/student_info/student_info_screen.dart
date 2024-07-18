import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:just_complaint/constant/constan.dart';
import 'package:just_complaint/provider/complaint_provider.dart';
import 'package:just_complaint/provider/theme_provider.dart';
import 'package:just_complaint/provider/user_provider.dart';
import 'package:provider/provider.dart';

class StudentDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final complaintProvider = Provider.of<ComplaintProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
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
                      //color: Colors.indigo,
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
              FutureBuilder(
                future: complaintProvider.fetchComplaintsByStudentId(userProvider.user!.id),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print('Snapshot error: ${snapshot.error}');
                    return Center(child: Text('An error occurred!'));
                  } else {
                    return Consumer<ComplaintProvider>(
                      builder: (ctx, complaintProvider, child) {
                        final stdData = complaintProvider.complaints;
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
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
                              DataColumn(
                                label: Text(
                                  'Status',
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
                                          complaint.name,
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
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child: Text(
                                                        'Close',
                                                        style: TextStyle(color: isDarkMode ? Colors.tealAccent : Colors.blue),
                                                      ),
                                                    ),
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
                                        DataCell(Container(
                                          width: size.width * 0.2, // Use MediaQuery to set width
                                          child: Text(
                                            complaint.category,
                                            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                                          ),
                                        )),
                                        DataCell(Container(
                                          width: size.width * 0.2, // Use MediaQuery to set width
                                          child: Text(
                                            complaint.status,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: complaint.status == 'Pending'
                                                  ? Colors.red
                                                  : Colors.green,
                                            ),
                                          ),
                                        )),
                                      ]),
                                    )
                                    .toList()
                                : [
                                    DataRow(cells: [
                                      DataCell(Container(width: size.width * 0.4, child: Text('No data', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)))),
                                      DataCell(Container(width: size.width * 0.2, child: Text('No data', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)))),
                                      DataCell(Container(width: size.width * 0.2, child: Text('No data', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)))),
                                      DataCell(Container(width: size.width * 0.2, child: Text('No data', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)))),
                                    ]),
                                  ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
