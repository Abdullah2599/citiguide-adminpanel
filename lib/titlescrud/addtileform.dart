import 'package:citiguide_adminpanel/controllers/admintilecontroller.dart';
import 'package:citiguide_adminpanel/titlescrud/tilelistscree.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddTileForm extends StatefulWidget {
  @override
  _AddTileFormState createState() => _AddTileFormState();
}

class _AddTileFormState extends State<AddTileForm> {
  final AdminTileController tileController = Get.put(AdminTileController());
  String? key;
  List<String> selectedOffers = [];

  final List<String> offers = [
    'Fee Dining',
    'Bar',
    'Parking',
    'Fast Food',
    'WiFi',
    'Pool',
    'Games',
    'Museum',
    'Cafe',
    'Library',
    'Zoo',
    'ATM',
    'Subway',
    'Air Conditioned',
    'Shopping',
    'Food Stalls',
    'Mosque',
    'Church',
    'Temple',
    'Child Care',
    'Playing Area',
    'Tickets',
    'Hiking',
    'Farm Houses',
    'Cruise',
    'Park',
  ];

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
      selectedOffers = List<String>.from(tile['offer'] ?? []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(key != null ? 'Edit Tile' : 'Add New Tile'),
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
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: MultiSelectDialogField(
              items: offers
                  .map((offer) => MultiSelectItem<String>(offer, offer))
                  .toList(),
              initialValue: selectedOffers,
              title: Text("Offers"),
              listType: MultiSelectListType.CHIP,
              onConfirm: (values) {
                setState(() {
                  selectedOffers = values.cast<String>();
                });
              },
              chipDisplay: MultiSelectChipDisplay(
                onTap: (value) {
                  setState(() {
                    selectedOffers.remove(value);
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {
              if (tileController.tileFormKey.currentState!.validate()) {
                tileController.offerController.text = selectedOffers.join(",");
                if (key != null) {
                  tileController.updateTile(key!);
                } else {
                  tileController.addTile();
                }
                Get.to(() =>
                    TileListScreen()); // Navigate back to the previous page after submission
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
