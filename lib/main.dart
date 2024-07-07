import 'package:citiguide_adminpanel/crud/add_city.dart';
import 'package:citiguide_adminpanel/crud/addcityform.dart';
import 'package:citiguide_adminpanel/crud/welcome.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('Initializing Firebase...');
  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDSse_6ZmZa98GHA_4xta27viR8U_Tmojw",
      appId: "1:94145546051:web:fa6c601a61f5b395c5d1f6",
      messagingSenderId: "94145546051",
      projectId: "citiguide-32c72",
      databaseURL: "https://citiguide-32c72-default-rtdb.firebaseio.com",
    ));
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Responsive Table Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
      // getPages: [
      //   GetPage(name: '/', page: () => CitiesScreen()),
      //   GetPage(name: '/addcityform', page: () => AddCityForm()),
      // ],
    );
  }
}
