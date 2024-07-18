import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_complaint/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamPage extends StatelessWidget {
  final String phoneNumber = '+252 61 5480786'; // Replace with the actual phone number
  final String whatsappNumber = '+252 61 5480786'; // Replace with the actual WhatsApp number

  void _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  void _openWhatsApp(String phoneNumber) async {
    final Uri whatsappUri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: phoneNumber.replaceAll('+252', '615480786'),
    );
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      throw 'Could not launch $whatsappUri';
    }
  }

  void _showCallDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Text('Call Us', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge!.color)),
          content: Text('Would you like to call $phoneNumber?', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Call', style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
                _makePhoneCall(phoneNumber);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'About Developer',
            style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54, fontSize: 18),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Jamhuriya Complaints of University',
                style: TextStyle(
                  fontSize: screenHeight * 0.025,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  height: 1.8,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'At Jamhuriya, we take every complaint seriously and address each concern promptly. Our process involves a thorough review, direct communication with all involved parties, and swift resolution. We maintain transparency and keep every complainant informed. Our goal is a fair and satisfactory resolution for everyone, reinforcing our commitment to quality and trust. We handle complaints in categories including equipment, finance, and academics. Our team collaborates to provide comprehensive solutions and uphold the highest standards of quality.',
                style: TextStyle(
                  fontSize: screenHeight * 0.02,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  height: 1.5,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'We encourage you to visit our campuses and learn more about the opportunities at Jamhuriya. Our team is ready to assist with any concerns and provide the best solutions to ensure your experience at Jamhuriya is exceptional.',
                style: TextStyle(
                  fontSize: screenHeight * 0.02,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  height: 1.5,
                ),
              ),
              SizedBox(height: screenHeight * 0.04), // Adding space before the call button
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: screenHeight * 0.06,
                      width: screenHeight * 0.06,
                      margin: EdgeInsets.only(right: screenWidth * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.call, color: Colors.white),
                        onPressed: () {
                          //_showCallDialog(context);
                          FlutterPhoneDirectCaller.callNumber('+252615480786');
                        },
                      ),
                    ),
                    Container(
                      height: screenHeight * 0.06,
                      width: screenHeight * 0.06,
                      margin: EdgeInsets.only(left: screenWidth * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        icon: Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
                        onPressed: () {
                          _openWhatsApp(whatsappNumber);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
