import 'package:flutter/material.dart';
import 'package:qirana_app/components/input_field.dart';
import 'package:qirana_app/components/password_field.dart';
import 'package:qirana_app/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

final _formKey = GlobalKey<FormState>();
final scaffoldKey = GlobalKey<ScaffoldState>();
var formData = {'email': '', 'password': '', 'confirmPassword': ''};

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'SIGN UP',
                      style: TextStyle(
                          color: Color(0xFFff5860),
                          fontSize: 35,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: InputField(
                        hintText: 'Enter your Email',
                        validator: emailValidator(),
                        onSaved: (val) => formData['email'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: PasswordField(
                        hintText: "Enter your Password",
                        icon: Icons.lock,
                        validator:
                            passwordValidator("Password must not be empty"),
                        onSaved: (val) => formData['password'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: PasswordField(
                        hintText: "Confirm your Password",
                        icon: Icons.lock,
                        validator:
                            passwordValidator("Password must not be empty"),
                        onSaved: (val) => formData['confirmPassword'] = val,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      color: Color(0xFFff5860),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () async {
                        _formKey.currentState.save();
                        if (!_formKey.currentState.validate()) return;
                        if (formData['password'] !=
                            formData['confirmPassword']) {
                          _showMyDialog(
                            title: 'Check Password',
                            body: 'Please check your password.',
                          );
                          return;
                        }
                        final response = await apiDriver.register(
                            formData['email'],
                            formData['password'],
                            formData['confirmPassword']);
                        if (response != null) {
                          if (response.status) {
                            _showMyDialog(
                              title: 'Registration Successful',
                              body: 'Please Login now',
                            );
                            Navigator.pop(context);
                          } else if (response.message ==
                              'User Already Exists') {
                            _showMyDialog(
                              title: 'User Already Exists.',
                              body: 'Please Login',
                            );
                            Navigator.pop(context);
                          }
                        } else {
                          _showMyDialog(
                            title: 'Failed',
                            body: 'Please try again',
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog({String title, String body}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(body),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
