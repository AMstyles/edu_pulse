import 'package:edu_pulse/models/color_palette.dart';
import 'package:edu_pulse/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState () => _LoginScreenState();
  
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.secondary,
        title: const Text("Login screen"),
      ),
      body: const Center(
        child:  Text("replace with actual login stuff🔥"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPalette.primary,
        onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage())),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
