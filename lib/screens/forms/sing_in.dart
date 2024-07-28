import 'package:flutter/material.dart';
import 'package:just_complaint/constant/constan.dart';
import 'package:just_complaint/provider/theme_provider.dart';
import 'package:just_complaint/provider/user_provider.dart';
import 'package:just_complaint/widgets/custtom_menu.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
  }

  void _checkLoggedIn() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.loadUserFromPrefs();
    if (userProvider.user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Custtom()),
      );
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<UserProvider>(context, listen: false)
          .loginUser(_emailController.text, _passwordController.text)
          .then((_) {
        setState(() {
          _isLoading = false;
        });

        final userProvider = Provider.of<UserProvider>(context, listen: false);
        if (userProvider.error.isEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Custtom()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(userProvider.error)),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
       // title: Center(child: Text('Sign in')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: size.width * 0.15,
                backgroundImage: AssetImage('images/just.png'),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'Welcome to Jamhuriya Complaints,',
                style: TextStyle(
                  fontSize: size.width * 0.05,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                'please Login to continue,',
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                        obscureText: _obscureText,
                        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
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
                                color: isDarkMode ? Colors.green : kNavyBlueColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextButton(
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 0.045,
                                  ),
                                ),
                                onPressed: _login,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}