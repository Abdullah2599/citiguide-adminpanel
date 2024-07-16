import 'package:citiguide_adminpanel/Auth/loginpage.dart';
import 'package:citiguide_adminpanel/controllers/logincontroller.dart';
import 'package:citiguide_adminpanel/controllers/logincontroller.dart';
import 'package:citiguide_adminpanel/crud/citlylisttile.dart';
import 'package:citiguide_adminpanel/crud/addcityform.dart';
import 'package:citiguide_adminpanel/crud/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDSse_6ZmZa98GHA_4xta27viR8U_Tmojw",
    appId: "1:94145546051:web:fa6c601a61f5b395c5d1f6",
    messagingSenderId: "94145546051",
    projectId: "citiguide-32c72",
    databaseURL: "https://citiguide-32c72-default-rtdb.firebaseio.com",
  ));

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;

  runApp(MyApp(
    user: user,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    Widget home;
    if (user == null) {
      home = LoginPage();
    } else {
      home = WelcomeScreen();
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CitiGuide Admin Panel',
      home: home,
      // initialRoute: '/',
      // getPages: [
      //   GetPage(name: '/', page: () => LoginPage()),
      //   GetPage(
      //       name: '/adminHomePage',
      //       page: () => WelcomeScreen()), // Add your admin home page here
      // ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
