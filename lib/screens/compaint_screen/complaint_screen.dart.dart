import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:just_complaint/constant/constan.dart';
import 'package:just_complaint/model/user_model.dart';
import 'package:just_complaint/provider/complaint_provider.dart';
import 'package:just_complaint/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ComplaintScreen extends StatefulWidget {
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;
  String? _category;
  User? _currentUser;

  void _submitComplaint() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _category = null;
      });

      final complaintProvider = Provider.of<ComplaintProvider>(context, listen: false);
      await complaintProvider.submitComplaint(
        _descriptionController.text,
        _currentUser!.id, // Replace with actual student ID
        _currentUser!.name, // Replace with actual student name
      );

      setState(() {
        _isLoading = false;
        _category = complaintProvider.category;
      });

      if (_category != null) {
        // Optionally navigate to another screen or show a success message
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  void _loadCurrentUser() async {
    final complaintProvider = Provider.of<ComplaintProvider>(context, listen: false);
    final user = await complaintProvider.getCurrentUser();
    setState(() {
      _currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? kNavyBlueColor : Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: size.height * 0.15,
                  child: Center(
                    child: Text(
                      'Submit Complaint',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : kNavyBlueColor,
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.05,
                  left: size.width * 0.03,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: isDarkMode ? Colors.white : kNavyBlueColor,
                    ),
                    onPressed: () {
                      ZoomDrawer.of(context)!.toggle();
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Complaint Description',
                        labelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      maxLines: null,
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.05),
                    _isLoading
                        ? CircularProgressIndicator()
                        : Container(
                            constraints: BoxConstraints(
                              minWidth: size.width * 0.5, // Set a minimum width for the button
                            ),
                            height: size.height * 0.06,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isDarkMode ? Colors.green : Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: TextButton(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: isDarkMode ? Colors.black : Colors.white,
                                    fontSize: size.width * 0.045,
                                  ),
                                ),
                                onPressed: _currentUser != null ? _submitComplaint : null,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            if (_category != null) ...[
              SizedBox(height: size.height * 0.05),
              Text(
                'Complaint Category',
                style: TextStyle(fontSize: size.width * 0.06, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                _category!,
                style: TextStyle(fontSize: size.width * 0.05, color: isDarkMode ? Colors.white70 : Colors.black87),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
