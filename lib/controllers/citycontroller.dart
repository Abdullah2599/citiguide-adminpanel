import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class AdmincityController extends GetxController {
  late TextEditingController nameController = TextEditingController();
  late TextEditingController imgController = TextEditingController();
  late TextEditingController descController = TextEditingController();
  final cityFormKey = GlobalKey<FormState>();
  late RxList<Map<dynamic, dynamic>> citiesRecords =
      <Map<dynamic, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCities();
  }

  Future<void> fetchCities() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("cityList");

    // Get the data once
    DatabaseEvent event = await ref.once();

    // Clear the list before populating it
    citiesRecords.clear();

    // Iterate through children and add values to the list
    event.snapshot.children.forEach((element) {
      Map<dynamic, dynamic> data = element.value as Map<dynamic, dynamic>;
      data['key'] = element.key;
      data['cdesc'] = data['cdesc'] ?? "";
      citiesRecords.add(data);
    });
  }

  Future<void> deleteCity(String cityName) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("cityList");

    // Delete the city
    await ref.orderByChild("cname").equalTo(cityName).once().then((value) =>
        value.snapshot.children.first.ref.remove().then((_) => fetchCities()));
    Get.snackbar("Success", "City Deleted");
  }

  Future<void> addCity() async {
    // Add City and it should be unique
    final DatabaseReference database =
        FirebaseDatabase.instance.ref("cityList");

    // Check if city already exists
    if (await database
        .orderByChild("cname")
        .equalTo(nameController.text)
        .once()
        .then((value) => value.snapshot.exists)) {
      Get.snackbar("Error", "City Already Exists");
      return;
    }

    database.push().set({
      "cname": nameController.text,
      "cimg": imgController.text,
      "cdesc": descController.text,
    });
    clearControllers();
    fetchCities();
    Get.snackbar("Success", "City Added");

    // fetchCities(); // Refresh the list after adding the city
  }

  Future<void> updateCity(String key) async {
    final DatabaseReference database =
        FirebaseDatabase.instance.ref("cityList/$key");

    database.update({
      "cname": nameController.text,
      "cimg": imgController.text,
      "cdesc": descController.text.isNotEmpty ? descController.text : "",
    });

    fetchCities();
    clearControllers();
    Get.snackbar("Success", "Tile Updated");
  }

  void clearControllers() {
    nameController.clear();
    imgController.clear();
    descController.clear();
  }
}
