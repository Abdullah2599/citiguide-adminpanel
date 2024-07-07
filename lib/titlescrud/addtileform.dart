import 'package:citiguide_adminpanel/controllers/admintilecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTileForm extends StatefulWidget {
  @override
  _AddTileFormState createState() => _AddTileFormState();
}

class _AddTileFormState extends State<AddTileForm> {
  final AdminTileController tileController = Get.put(AdminTileController());
  String? key;

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      final tile = Get.arguments;
      key = tile['key'];
      tileController.titleController.text = tile['title'];
      tileController.categoryController.text = tile['category'];
      tileController.cityController.text = tile['city'];
      tileController.contactController.text = tile['contact'];
      tileController.descController.text = tile['desc'];
      tileController.imageurlController.text = tile['imageurl'];
      tileController.locationController.text = tile['location'];
      tileController.priceController.text = tile['price'].toString();
      tileController.offerController.text = (tile['offer'] as List).join(',');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Tile'),
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
      key: tileController.tileFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildTextFormField(
            controller: tileController.titleController,
            label: 'Title',
            icon: Icons.title,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          buildTextFormField(
            controller: tileController.categoryController,
            label: 'Category',
            icon: Icons.category,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a category';
              }
              return null;
            },
          ),
          buildTextFormField(
            controller: tileController.cityController,
            label: 'City',
            icon: Icons.location_city,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a city';
              }
              return null;
            },
          ),
          buildTextFormField(
            controller: tileController.contactController,
            label: 'Contact',
            icon: Icons.contact_phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a contact';
              }
              return null;
            },
          ),
          buildTextFormField(
            controller: tileController.descController,
            label: 'Description',
            icon: Icons.description,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          buildTextFormField(
            controller: tileController.imageurlController,
            label: 'Image URL',
            icon: Icons.image,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an image URL';
              }
              return null;
            },
          ),
          buildTextFormField(
            controller: tileController.locationController,
            label: 'Location',
            icon: Icons.location_on,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a location';
              }
              return null;
            },
          ),
          buildTextFormField(
            controller: tileController.priceController,
            label: 'Price',
            icon: Icons.money,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a price';
              }
              return null;
            },
          ),
          buildTextFormField(
            controller: tileController.offerController,
            label: 'Offer (comma separated)',
            icon: Icons.local_offer,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter offers';
              }
              return null;
            },
          ),
          SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {
              if (tileController.tileFormKey.currentState!.validate()) {
                if (key != null) {
                  tileController.updateTile(key!);
                } else {
                  tileController.addTile();
                }
                Get.back(); // Navigate back to the previous page after submission
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

  Widget buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefixIcon: Icon(icon),
        ),
        validator: validator,
      ),
    );
  }
}
