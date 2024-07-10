import 'package:flutter/material.dart';
import 'package:just_complaint/constant/constan.dart';

class Faculties extends StatelessWidget {
  final bool isListView;

  Faculties({required this.isListView});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> faculties = [
      {'name': 'Equipments', 'image': 'images/equiment.png', 'description': 'Details about Equipments' },
      {'name': 'Academic', 'image': 'images/acdamic.png', 'description': 'Details about Academic'},
      {'name': 'Finance', 'image': 'images/finance.png', 'description': 'Details about Finance'},
    ];

    return isListView
        ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: faculties.length,
            itemBuilder: (context, index) {
              final faculty = faculties[index];
              return Container(
                margin: const EdgeInsets.all(8.0),
                color: kJustColor.withOpacity(0.90),
                
                child: ListTile(
                  leading: Image.asset(faculty['image']),
                  title: Text(
                    faculty['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    faculty['description'],
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ),
              );
            },
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 0.79,
            ),
            itemCount: faculties.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), // Prevents GridView from scrolling
            itemBuilder: (BuildContext context, int index) {
              final faculty = faculties[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: kJustColor.withOpacity(0.90),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(faculty['image']),
                      SizedBox(height: 10),
                      Text(
                        faculty['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
