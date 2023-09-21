import 'package:edu_pulse/models/color_palette.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.secondary,
          title: const Text("Edu pulse"),
        ),
        body:Center(
          child: ListView.builder(
              itemCount: 101,
              itemBuilder: (context,index)=>ListTile(
            title: Text('Survey $index'),
            subtitle: const Text("some desc"),
          )
          ),
        ),
      drawer: Drawer(
        backgroundColor: ColorPalette.secondaryAccent,
        child: ListView(
          children: const [
            DrawerHeader(child: Center(child:Text("Edu Pulse", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),)))
          ],
        ),
      ),
    );
  }
}