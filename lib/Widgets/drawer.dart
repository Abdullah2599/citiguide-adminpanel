import 'package:citiguide_adminpanel/Auth/loginpage.dart';
import 'package:citiguide_adminpanel/Notifications/addnotification.dart';
import 'package:citiguide_adminpanel/controllers/logincontroller.dart';
import 'package:citiguide_adminpanel/crud/citlylisttile.dart';
import 'package:citiguide_adminpanel/crud/welcome.dart';
import 'package:citiguide_adminpanel/titlescrud/tilelistscree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
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
            leading: Icon(Icons.notification_add),
            title: Text('Notifications'),
            onTap: () => Get.to(() => NotificationForm()),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Get.defaultDialog(
                onConfirm: () async {
                  await Get.find<LoginController>()
                      .signOut(); // Call the signOut method
                  Get.snackbar("Logout", "Logout successfully",
                      backgroundColor: const Color.fromARGB(167, 0, 0, 0),
                      barBlur: 10.0,
                      colorText: Colors.white);
                },
                onCancel: () => {Get.back()},
                title: "Logout",
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.question_mark,
                      size: 40,
                    ),
                    SizedBox(),
                    Text("Are you sure you want to logout?"),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
