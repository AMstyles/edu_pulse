import 'package:edu_pulse/models/local_user.dart';
import 'package:edu_pulse/screens/auth/login_screen.dart';
import 'package:edu_pulse/screens/home_screen.dart';
import 'package:edu_pulse/screens/mood_screen.dart';
import 'package:edu_pulse/services/local_storage_services.dart';
import 'package:edu_pulse/services/local_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  LocalUser? myUser = await LocalStorage.readUserFromLocalStorage();

  bool shouldLogin = myUser == null;

  print(shouldLogin);

  runApp(MyApp(shouldLogin: shouldLogin,));
}

class MyApp extends StatelessWidget {
   MyApp({super.key, required this.shouldLogin});

  bool shouldLogin;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
        ChangeNotifierProvider(
        create: (context) => UserProvider(),
    ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: shouldLogin?const LoginScreen():const MoodScreen(),
    ),);
  }
}


