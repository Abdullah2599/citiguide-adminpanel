import 'package:citiguide_adminpanel/crud/newtest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:citiguide_adminpanel/crud/add_city.dart';
// import 'package:citiguide_adminpanel/crud/add_place.dart';
// import 'package:citiguide_adminpanel/pages/users.dart';

var defaultBackgroundColor = Colors.grey[300];
var appBarColor = Colors.grey[900];

myAppBar() {
  return AppBar(
    backgroundColor: appBarColor,
    title: Text('Admin Panel'),
    centerTitle: false,
  );
}

var drawerTextColor = TextStyle(
  color: Colors.grey[600],
);

var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);

var myDrawer = Drawer(
  backgroundColor: Colors.grey[300],
  elevation: 0,
  child: Column(
    children: [
      DrawerHeader(
        child: Icon(
          Icons.favorite,
          size: 64,
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          onTap: () => Get.to(() => const MyWidget()),
          leading: Icon(Icons.home),
          title: Text(
            'Add City',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          onTap: () => Get.toNamed('/addPlace'),
          leading: Icon(Icons.settings),
          title: Text(
            'Add Places',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          onTap: () => Get.toNamed('/users'),
          leading: Icon(Icons.info),
          title: Text(
            'Users',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.logout),
          title: Text(
            'L O G O U T',
            style: drawerTextColor,
          ),
        ),
      ),
    ],
  ),
);
