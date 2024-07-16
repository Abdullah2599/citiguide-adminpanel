import 'dart:convert';
import 'package:citiguide_adminpanel/Notifications/addnotification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:googleapis_auth/auth_io.dart';

class NotificationFormController extends GetxController {
  var notificationTitle = ''.obs;
  var notificationText = ''.obs;
  var messageTitle = ''.obs;
  var messageText = ''.obs;
  var selectedUsers = <String>[].obs;
  var usersData = <Map<String, String>>[].obs;
  var isLoading = false.obs;

  final String serviceAccountJsonPath =
      'assets/citiguide-32c72-firebase-adminsdk-5gcg2-966b38b03e.json';

  @override
  void onInit() {
    super.onInit();
    fetchUsersData();
    resetForm();
  }

  Future<void> fetchUsersData() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    final data = snapshot.docs
        .map((doc) {
          final userData = doc.data();
          if (userData.containsKey('token')) {
            return {
              'email': doc.id,
              'name': userData['name'] as String,
              'image': userData['image'] as String,
              'token': userData['token'] as String,
            };
          }
          return null;
        })
        .where((user) => user != null)
        .toList();

    usersData.assignAll(data.cast<Map<String, String>>());
  }

  bool validateForm() {
    return notificationTitle.isNotEmpty &&
        notificationText.isNotEmpty &&
        messageTitle.isNotEmpty &&
        messageText.isNotEmpty;
  }

  Future<void> sendNotification() async {
    if (!validateForm()) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    if (selectedUsers.isEmpty) {
      Get.snackbar('Error', 'Please select at least one user');
      return;
    }

    isLoading.value = true;

    try {
      await sendFCMMessage(
        title: notificationTitle.value,
        body: notificationText.value,
        messageTitle: messageTitle.value,
        messageText: messageText.value,
        deviceTokens: selectedUsers.map((email) {
          return usersData
              .firstWhere((user) => user['email'] == email)['token'];
        }).toList(),
      );

      // Save notification to Firestore for each selected user
      for (String email in selectedUsers) {
        await saveNotificationToFirestore(email, {
          'title': messageTitle.value,
          'message': messageText.value,
          'timestamp': FieldValue.serverTimestamp(),
          'isRead': false,
        });
      }

      Get.snackbar('Success', 'Notification sent successfully');
      resetForm();
      Get.off(() => NotificationForm());
    } catch (e) {
      Get.snackbar('Error', 'Failed to send notification: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveNotificationToFirestore(
      String email, Map<String, dynamic> notification) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection('notifications')
        .add(notification);
  }

  void resetForm() {
    notificationTitle.value = '';
    notificationText.value = '';
    messageTitle.value = '';
    messageText.value = '';
    selectedUsers.clear();
  }

  Future<void> sendFCMMessage({
    required String title,
    required String body,
    required String messageTitle,
    required String messageText,
    required List<String?> deviceTokens,
  }) async {
    final serviceAccount = await loadServiceAccount();
    final accessToken = await getAccessToken(serviceAccount);

    for (var token in deviceTokens) {
      if (token != null) {
        final message = {
          'message': {
            'token': token,
            'notification': {
              'title': title,
              'body': body,
            },
            'data': {
              'title': messageTitle,
              'message': messageText,
            },
          },
        };

        final response = await http.post(
          Uri.parse(
              'https://fcm.googleapis.com/v1/projects/citiguide-32c72/messages:send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: jsonEncode(message),
        );

        if (response.statusCode != 200) {
          throw Exception('Failed to send FCM message: ${response.body}');
        }
      }
    }
  }

  Future<ServiceAccountCredentials> loadServiceAccount() async {
    final serviceAccountJson =
        await rootBundle.loadString(serviceAccountJsonPath);
    return ServiceAccountCredentials.fromJson(json.decode(serviceAccountJson));
  }

  Future<String> getAccessToken(
      ServiceAccountCredentials serviceAccount) async {
    final authClient = await clientViaServiceAccount(
        serviceAccount, ['https://www.googleapis.com/auth/firebase.messaging']);
    return authClient.credentials.accessToken.data;
  }

  void toggleSelectAll() {
    if (selectedUsers.length == usersData.length) {
      selectedUsers.clear();
    } else {
      selectedUsers.assignAll(usersData.map((user) => user['email']!));
    }
  }
}
