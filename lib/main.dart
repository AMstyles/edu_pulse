import 'package:demo/pages/Login_page.dart';
import 'package:demo/pages/sign_up.dart';
import 'package:flutter/material.dart';
//import 'pages/Login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
