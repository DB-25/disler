import 'package:disler/theme.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() => runApp(MaterialApp(
      title: "Qirana",
//    home: OrderConfirm(
//      orderNo: '64586532',
//    )
      theme: theme(),
      home: HomeScreen(),
    ));
