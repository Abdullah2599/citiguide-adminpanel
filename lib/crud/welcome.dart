import 'package:citiguide_adminpanel/Widgets/drawer.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cities'),
        ),
        drawer: CustomDrawer(),
        body: Center(
          child: Text('Welcome...'),
        ));
  }
}
