import 'package:disler/components/input_field.dart';
import 'package:disler/components/password_field.dart';
import 'package:disler/screens/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

final _formKey = GlobalKey<FormState>();
final scaffoldKey = GlobalKey<ScaffoldState>();
var formData = {
  'email': '',
  'password': '',
  'confirmPassword': '',
  'name': '',
  'shopName': '',
  'contactNumber': '',
  'city': '',
  'sReferral': '',
  'address': '',
  'area': '',
  'pincode': '',
};

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
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
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
                      height: 10,
                    ),
                    Text(
                      'Create an Account',
                      style: TextStyle(
                          color: Color(0xFFff5860),
                          fontSize: 35,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: InputField(
                        hintText: 'Name',
                        validator: emptyValidator('Enter a Name'),
                        onSaved: (val) => formData['name'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: InputField(
                        hintText: 'Shop Name',
                        validator: emptyValidator('Enter a Shop Name'),
                        onSaved: (val) => formData['shopName'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: InputField(
                        hintText: 'Enter your Email',
                        // validator: emailValidator(),
                        onSaved: (val) => formData['email'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: InputField(
                        hintText: 'Contact Number',
                        validator: emptyValidator('Enter a Contact Number'),
                        onSaved: (val) => formData['contactNumber'] = val,
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: InputField(
                        hintText: 'Referred By',
                        onSaved: (val) => formData['sReferral'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: InputField(
                        hintText: 'Address',
                        validator: emptyValidator('Enter an Address'),
                        onSaved: (val) => formData['address'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: InputField(
                        hintText: 'Area',
                        validator: emptyValidator('Enter an Area'),
                        onSaved: (val) => formData['area'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: InputField(
                        hintText: 'City',
                        validator: emptyValidator('Enter a City'),
                        onSaved: (val) => formData['city'] = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: InputField(
                        hintText: 'Pincode',
                        validator: emptyValidator('Enter a Pincode'),
                        onSaved: (val) => formData['pincode'] = val,
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
                            "Signup",
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
                            formData['confirmPassword'],
                            formData['name'],
                            formData['shopName'],
                            formData['sReferral'],
                            formData['contactNumber'],
                            formData['city'],
                            formData['address'],
                            formData['area'],
                            formData['pincode']);
                        if (response != null) {
                          if (response.status) {
                            _showMyDialog(
                              title: 'Registration Successful',
                              body: 'Please Login now',
                            );
                            // Navigator.pop(context);
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Existing User?',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Log In',
                            style: TextStyle(
                                color: Color(0xFFff5860),
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        )
                      ],
                    )
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
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
