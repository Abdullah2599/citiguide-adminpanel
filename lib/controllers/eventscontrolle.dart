import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class EventsController extends GetxController {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController imgController = TextEditingController();
  late TextEditingController descController = TextEditingController();
  var statusController = ''.obs;
  late TextEditingController cityController = TextEditingController();
  late TextEditingController dateController = TextEditingController();
  late TextEditingController timeController = TextEditingController();
  late TextEditingController priceController = TextEditingController();
  final eventFormKey = GlobalKey<FormState>();
  late RxList<Map<dynamic, dynamic>> eventsRecords =
      <Map<dynamic, dynamic>>[].obs;

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
    // print(titleController.text);
    // print(priceController.text);
    // print(statusController.value);
    // print(timeController.text);
    // print(dateController.text);
    // print(imgController.text);
    // print(descController.text);
    // print(cityController.text);

    final DatabaseReference database = FirebaseDatabase.instance.ref("events");

    database.push().set({
      "title": titleController.text,
      "price": int.parse(priceController.text),
      "status": statusController.value,
      "time": timeController.text,
      "date": dateController.text,
      "imageurl": imgController.text,
      "description": descController.text,
      "city": cityController.text,
    });
    clearControllers();
    fetchEvents();
    Get.snackbar("Success", "Event Added");
  }

  Future<void> updateEvent(String key) async {
    final DatabaseReference database =
        FirebaseDatabase.instance.ref("events/$key");

    database.update({
      "title": titleController.text,
      "price": int.parse(priceController.text),
      "status": statusController.value,
      "time": timeController.text,
      "date": dateController.text,
      "imageurl": imgController.text,
      "description": descController.text,
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
    dateController.clear();
    timeController.clear();
    statusController.value = '';
    priceController.clear();
    cityController.clear();
  }
}
