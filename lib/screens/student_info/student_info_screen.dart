import 'package:flutter/material.dart';
import 'package:just_complaint/provider/complaint_provider.dart';
import 'package:just_complaint/provider/user_provider.dart';
import 'package:just_complaint/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class StudentDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final complaintProvider = Provider.of<ComplaintProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints in Student'),
      ),
      drawer: CustomDrawer(),
      body: FutureBuilder(
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
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Description')),
                      DataColumn(label: Text('Category')),
                      DataColumn(label: Text('Status')),
                    ],
                    rows: stdData.isNotEmpty
                        ? stdData
                            .map(
                              (complaint) => DataRow(cells: [
                                DataCell(Text(complaint.name)),
                                DataCell(Container(
                                  width: size.width * 0.4, // Use MediaQuery to set width
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: Text('Description'),
                                          content: Text(complaint.description),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: Text('Close'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Text(
                                      complaint.description,
                                      style: TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3, // Limit the number of lines
                                    ),
                                  ),
                                )),
                                DataCell(Container(
                                  width: size.width * 0.2, // Use MediaQuery to set width
                                  child: Text(complaint.category),
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
                              DataCell(Container(width: size.width * 0.4, child: Text('No data'))),
                              DataCell(Container(width: size.width * 0.2, child: Text('No data'))),
                              DataCell(Container(width: size.width * 0.2, child: Text('No data'))),
                              DataCell(Container(width: size.width * 0.2, child: Text('No data'))),
                            ]),
                          ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
