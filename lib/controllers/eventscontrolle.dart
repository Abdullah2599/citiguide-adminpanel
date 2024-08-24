import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class EventsController extends GetxController {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController imgController = TextEditingController();
  late TextEditingController descController = TextEditingController();
  late TextEditingController contactController = TextEditingController();
  late TextEditingController cityController = TextEditingController();
  final eventFormKey = GlobalKey<FormState>();
  late RxList<Map<dynamic, dynamic>> eventsRecords = <Map<dynamic, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("events");

    // Get the data once
    DatabaseEvent event = await ref.once();

    // Clear the list before populating it
    eventsRecords.clear();

    // Iterate through children and add values to the list
    event.snapshot.children.forEach((element) {
      Map<dynamic, dynamic> data = element.value as Map<dynamic, dynamic>;
      data['key'] = element.key;
      eventsRecords.add(data);
    });
  }

  Future<void> deleteEvent(String key) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("events/$key");

    // Delete the event
    await ref.remove().then((_) => fetchEvents());
    Get.snackbar("Success", "Event Deleted");
  }

  Future<void> addEvent() async {
    final DatabaseReference database = FirebaseDatabase.instance.ref("events");

    database.push().set({
      "title": titleController.text,
      "imageurl": imgController.text,
      "description": descController.text,
      "contact": contactController.text,
      "city": cityController.text,
    });
    clearControllers();
    fetchEvents();
    Get.snackbar("Success", "Event Added");
  }

  Future<void> updateEvent(String key) async {
    final DatabaseReference database = FirebaseDatabase.instance.ref("events/$key");

    database.update({
      "title": titleController.text,
      "imageurl": imgController.text,
      "description": descController.text,
      "contact": contactController.text,
      "city": cityController.text,
    });

    fetchEvents();
    clearControllers();
    Get.snackbar("Success", "Event Updated");
  }

  void clearControllers() {
    titleController.clear();
    imgController.clear();
    descController.clear();
    contactController.clear();
    cityController.clear();
  }
}
