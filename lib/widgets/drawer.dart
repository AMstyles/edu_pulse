import 'package:edu_pulse/screens/auth/login_screen.dart';
import 'package:edu_pulse/screens/survey_screen.dart';
import 'package:edu_pulse/screens/user_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/color_palette.dart';
import '../screens/settings_page.dart';
import '../services/local_storage_services.dart';
import '../services/local_user_provider.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorPalette.secondaryAccent,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: ColorPalette.secondary,
            ),
            child: Center(
              child: Text(
                "Edu Pulse",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('home'),
            onTap: () {
              // Update the state of the app.
              // ...
              // Then close the drawer.
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.star_rate),
            title: const Text('surveys'),
            onTap: () {
              // Update the state of the app.
              // ...
              // Then close the drawer.
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SurveyPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('settings'),
            onTap: () {
              // Update the state of the app.
              // ...
              // Then close the drawer.
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettingsPage()));
            },
          ),
          ListTile(
            leading:const Icon(Icons.person_2_rounded),
            title: const Text('Profile'),
            onTap: () {

              Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserPage(user: Provider.of<UserProvider>(context).user!,)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('about'),
            onTap: () {
              // Update the state of the app.
              // ...
              // Then close the drawer.
              Navigator.pop(context);
              showAboutDialog(context: context, applicationName: 'Edu Pulse', applicationVersion: '1.0.0', applicationLegalese: '© 2023 Wits Overflow',   applicationIcon: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:Image.asset('lib/images/logo.png', height: 50,), ), children: [
                const Text('This is a project for the Wits University Software Engineering course. It is a platform for students speak up', style: TextStyle(fontSize: 14),)],);
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red,),
            title: const Text('log out', style: TextStyle(color: Colors.red),),
            onTap: () async{
              Navigator.pop(context);
              await Provider.of<UserProvider>(context, listen: false).signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}