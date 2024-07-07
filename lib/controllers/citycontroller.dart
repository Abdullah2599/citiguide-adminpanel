import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class AdmincityController extends GetxController {
  late TextEditingController cityController = TextEditingController();
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
    for (var element in event.snapshot.children) {
      Map<dynamic, dynamic> data = element.value as Map<dynamic, dynamic>;
      citiesRecords.add(data);
    }
  }

  Future<void> deleteCity(String cityName) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("cityList");

    // Delete the city
    await ref.orderByChild("cname").equalTo(cityName).once().then((value) =>
        value.snapshot.children.first.ref.remove().then((_) => fetchCities()));
    Get.snackbar("Success", "City Deleted");
  }

  Future<void> addCity({
    required String cname,
    required String cimg,
    required String cdesc,
  }) async {
    // Add City and it should be unique
    final DatabaseReference database =
        FirebaseDatabase.instance.ref("cityList");

    // Check if city already exists
    if (await database
        .orderByChild("cname")
        .equalTo(cname)
        .once()
        .then((value) => value.snapshot.exists)) {
      Get.snackbar("Error", "City Already Exists");
      return;
    }

    database.push().set({
      "cname": cname,
      "cimg": cimg,
      "cdesc": cdesc,
    });

    fetchCities(); // Refresh the list after adding the city
    Get.snackbar("Success", "City Added");
  }
}
