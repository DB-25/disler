import 'package:disler/screens/home_screen.dart';
import 'package:disler/screens/login_screen.dart';
import 'package:disler/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _autoLogIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  loggedIn = prefs.containsKey('accessToken');
}

bool loggedIn = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _autoLogIn();
  return runApp(MaterialApp(
    title: "Disler",
//    home: OrderConfirm(
//      orderNo: '64586532',
//    )
    theme: theme(),
    // home: HomeScreen(),
    home: loggedIn ? HomeScreen() : LoginScreen(),
  ));
}
