import 'package:citiguide_adminpanel/Notifications/userselectionscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:citiguide_adminpanel/controllers/notificationcontroller.dart';

class NotificationForm extends StatelessWidget {
  final NotificationFormController controller =
      Get.put(NotificationFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Notification'),
        actions: [
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () {
              Get.to(() => UserSelectionScreen());
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 600;

          return Center(
            child: Container(
              width: isDesktop ? 600 : double.infinity,
              padding: EdgeInsets.all(16.0),
              child: Form(
                child: Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Notification Title'),
                        onChanged: (value) =>
                            controller.notificationTitle.value = value,
                        initialValue: controller.notificationTitle.value,
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Notification Text'),
                        onChanged: (value) =>
                            controller.notificationText.value = value,
                        initialValue: controller.notificationText.value,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Message Title'),
                        onChanged: (value) =>
                            controller.messageTitle.value = value,
                        initialValue: controller.messageTitle.value,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Message Text'),
                        onChanged: (value) =>
                            controller.messageText.value = value,
                        initialValue: controller.messageText.value,
                      ),
                      SizedBox(height: 20),
                      controller.isLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () {
                                if (controller.validateForm()) {
                                  controller.sendNotification();
                                }
                              },
                              child: Text('Send Notification'),
                            ),
                    ],
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
