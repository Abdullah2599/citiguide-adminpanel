import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class AdminTileController extends GetxController {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController categoryController = TextEditingController();
  late TextEditingController cityController = TextEditingController();
  late TextEditingController contactController = TextEditingController();
  late TextEditingController descController = TextEditingController();
  late TextEditingController imageurlController = TextEditingController();
  late TextEditingController locationController = TextEditingController();
  late TextEditingController priceController = TextEditingController();
  late TextEditingController offerController = TextEditingController();

  final tileFormKey = GlobalKey<FormState>();
  late RxList<dynamic> tilesRecords = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTiles();
  }

  Future<void> fetchTiles() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("data");

    // Get the data once
    DatabaseEvent event = await ref.once();

    // Clear the list before populating it
    tilesRecords.clear();

    // Iterate through children and add values to the list
    event.snapshot.children.forEach((element) {
      Map<dynamic, dynamic> data = element.value as Map<dynamic, dynamic>;
      data['key'] = element.key;
      tilesRecords.add(data);
    });
  }

  Future<void> deleteTile(String title) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("data");

    // Delete the tile
    await ref.orderByChild("title").equalTo(title).once().then((value) => value
        .snapshot.children.first.ref
        .remove()
        .then((value) => fetchTiles()));
    Get.snackbar("Success", "Tile Deleted");
  }

  Future<void> addTile() async {
    final DatabaseReference database = FirebaseDatabase.instance.ref("data");

    // Check if tile already exists
    if (await database
        .orderByChild("title")
        .equalTo(titleController.text)
        .once()
        .then((value) => value.snapshot.exists)) {
      Get.snackbar("Error", "Tile Already Exists");
      return;
    }

    database.push().set({
      "title": titleController.text,
      "category": categoryController.text,
      "city": cityController.text,
      "contact": contactController.text,
      "desc": descController.text,
      "imageurl": imageurlController.text,
      "location": locationController.text,
      "price": int.parse(priceController.text),
      "offer": offerController.text
          .split(","), // Assuming offers are comma-separated
      'likes': [],
    });

    clearControllers();
    fetchTiles();
    Get.snackbar("Success", "Tile Added");
  }

  Future<void> updateTile(String key) async {
    final DatabaseReference database =
        FirebaseDatabase.instance.ref("data/$key");

    database.update({
      "title": titleController.text,
      "category": categoryController.text,
      "city": cityController.text,
      "contact": contactController.text,
      "desc": descController.text,
      "imageurl": imageurlController.text,
      "location": locationController.text,
      "price": int.parse(priceController.text),
      "offer": offerController.text.split(",")
    });

    clearControllers();
    fetchTiles();
    Get.snackbar("Success", "Tile Updated");
  }

  void clearControllers() {
    titleController.clear();
    categoryController.clear();
    cityController.clear();
    contactController.clear();
    descController.clear();
    imageurlController.clear();
    locationController.clear();
    priceController.clear();
    offerController.clear();
  }
}
