import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:citiguide_adminpanel/controllers/notificationcontroller.dart';

class UserSelectionScreen extends StatelessWidget {
  final NotificationFormController controller =
      Get.put(NotificationFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Users'),
        actions: [
          IconButton(
            icon: Icon(Icons.select_all),
            onPressed: () {
              controller.toggleSelectAll();
            },
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.usersData.length,
          itemBuilder: (context, index) {
            final user = controller.usersData[index];
            return Obx(() {
              return CheckboxListTile(
                title: Text(user['name'] ?? ''),
                subtitle: Text(user['email'] ?? ''),
                value: controller.selectedUsers.contains(user['email']),
                onChanged: (bool? value) {
                  if (value == true) {
                    controller.selectedUsers.add(user['email']!);
                  } else {
                    controller.selectedUsers.remove(user['email']!);
                  }
                },
              );
            });
          },
        );
      }),
    );
  }
}
