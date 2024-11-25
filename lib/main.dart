import 'package:flutter/material.dart';
import 'package:latihanresponsi_124220025/pages/LoginPage.dart';
import 'package:latihanresponsi_124220025/pages/RegisterPage.dart';
import 'pages/LoginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spaceflight News',
      home: RegisterPage(),
    );
  }
}