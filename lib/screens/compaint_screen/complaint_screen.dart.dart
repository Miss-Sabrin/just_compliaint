import 'package:flutter/material.dart';
import 'package:just_complaint/model/user_model.dart'; 
import 'package:just_complaint/provider/complaint_provider.dart';
import 'package:just_complaint/widgets/custom_drawer.dart';
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => StudentDataScreen(),
        //   ),
        // );
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

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Submit Complaint')),
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Complaint Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        maxLines: null,
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
                              height: size.height * 0.06,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextButton(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 0.045,
                                  ),
                                ),
                                onPressed: _currentUser != null ? _submitComplaint : null,
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  _category!,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}