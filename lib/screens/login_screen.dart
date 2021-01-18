import 'package:flutter/material.dart';
import 'package:qirana_app/components/input_field.dart';
import 'package:qirana_app/components/password_field.dart';
import 'package:qirana_app/model/login_model.dart';
import 'package:qirana_app/networking/api_driver.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qirana_app/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page_2.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final _formKey = GlobalKey<FormState>();
final scaffoldKey = GlobalKey<ScaffoldState>();
var formData = {
  'email': '',
  'password': '',
};

ApiDriver apiDriver = ApiDriver();

class _LoginScreenState extends State<LoginScreen> {
  bool enableGoogleLogin = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  Future<void> _handleSignIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await _googleSignIn.signIn();
      await prefs.setBool('autoLogin', true);
      await prefs.setString('emailId', _googleSignIn.currentUser.email);
      await prefs.setString('name', _googleSignIn.currentUser.displayName);
      await _showMyDialog(title: 'Login Successful', body: 'USER LOGIN.');
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
  }

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
                      'LOG IN',
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
                            "Log in",
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
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        _formKey.currentState.save();
                        if (!_formKey.currentState.validate()) return;
                        final loginModel = LoginModel.fromMap(formData);
                        final response = await apiDriver.login(
                            loginModel.email, loginModel.password);
                        if (response != null) {
                          if (response.status) {
                            await prefs.clear();
                            await prefs.setBool('autoLogin', true);
                            await prefs.setString('email', loginModel.email);
                            await prefs.setString('emailId', loginModel.email);
                            await prefs.setString('accessToken', response.data[0]['accessToken']);
                            await prefs.setString(
                                'password', loginModel.password);
                            if (response.data[0]['userType'] == 'ROLE_ADMIN') {
                              prefs.setBool('admin', true);
                              setState(() {
                                admin.value = true;
                                autoLoginBool.value = true;
                                // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                                admin.notifyListeners();
                                // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                                autoLoginBool.notifyListeners();
                              });
                              _showMyDialog(
                                  title: 'Login Successful',
                                  body: 'ADMIN LOGIN.');
                              Navigator.pop(context);
                            } else {
                              setState(() {
                                admin.value = false;
                                autoLoginBool.value = true;
                                // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                                admin.notifyListeners();
                                // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                                autoLoginBool.notifyListeners();
                              });
                              _showMyDialog(
                                  title: 'Login Successful',
                                  body: 'USER LOGIN.');
                              Navigator.pop(context);
                            }
                          }
                        } else {
                          _showMyDialog(
                              title: 'Login Failed',
                              body: 'Please check your email and password.');
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    enableGoogleLogin ? RaisedButton(
                      color: Color(0xFFff5860),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Log in with GOOGLE",
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
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        _handleSignIn();

                        await prefs.setBool('autoLogin', true);
                        setState(() {
                          autoLoginBool.value = true;
                          // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                          autoLoginBool.notifyListeners();
                        });

                        Navigator.pop(context);
                      },
                    ) : Container(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 600,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don\'t have an account',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()));
                          },
                          child: Text(
                            'SignUp',
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
