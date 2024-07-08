import 'package:citiguide_adminpanel/controllers/citycontroller.dart';
import 'package:citiguide_adminpanel/crud/citlylisttile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Update this import path to match your project structure

class AddCityForm extends StatefulWidget {
  @override
  _AddCityFormState createState() => _AddCityFormState();
}

class _AddCityFormState extends State<AddCityForm> {
  // Create an instance of AdmincityController
  final AdmincityController adminCityController = AdmincityController();
  String? key;

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      final city = Get.arguments;
      key = city['key'];
      adminCityController.nameController.text = city['cname'];
      adminCityController.imgController.text = city['cimg'];
      adminCityController.descController.text = city['cdesc'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(key != null ? 'Edit City' : 'Add New City'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return buildWideForm();
            } else {
              return buildNarrowForm();
            }
          },
        ),
      ),
    );
  }

  Widget buildWideForm() {
    return Center(
      child: Container(
        width: 600,
        child: buildForm(),
      ),
    );
  }

  Widget buildNarrowForm() {
    return Center(
      child: SingleChildScrollView(
        child: buildForm(),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: adminCityController.cityFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: adminCityController.nameController,
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.title),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: adminCityController.imgController,
            decoration: InputDecoration(
              labelText: 'City Image Link',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.image),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an image link';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: adminCityController.descController,
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.description),
            ),
            maxLines: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {
              if (adminCityController.cityFormKey.currentState!.validate()) {
                // Call addCity method from AdmincityController
                if (key != null) {
                  adminCityController.updateCity(key!);
                } else {
                  adminCityController.addCity();
                }
                Get.to(() =>
                    CitiesScreen()); // Navigate back to the previous page after submission
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
