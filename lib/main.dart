import 'package:flutter/material.dart';
import 'package:qirana_app/theme.dart';
import 'screens/home_screen.dart';

void main() => runApp(MaterialApp(
      title: "Qirana",
//    home: OrderConfirm(
//      orderNo: '64586532',
//    )
      theme: theme(),
      home: HomeScreen(),
    ));
