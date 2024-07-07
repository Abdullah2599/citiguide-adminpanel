import 'package:citiguide_adminpanel/CRUD/add_city.dart';
import 'package:citiguide_adminpanel/crud/welcome.dart';
import 'package:citiguide_adminpanel/titlescrud/tilelistscree.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => Get.to(() => WelcomeScreen()),
          ),
          ListTile(
            leading: Icon(Icons.location_city),
            title: Text('Cities'),
            onTap: () => Get.to(() => CitiesScreen()),
          ),
          ListTile(
            leading: Icon(Icons.place),
            title: Text('Places'),
            onTap: () => Get.to(() => TileListScreen()),
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('others/Users'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
