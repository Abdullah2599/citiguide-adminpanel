import 'package:citiguide_adminpanel/controllers/eventscontrolle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsForm extends StatefulWidget {
  @override
  _EventsFormState createState() => _EventsFormState();
}

class _EventsFormState extends State<EventsForm> {
  final EventsController eventsController = Get.put(EventsController());
  String? key;

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      final event = Get.arguments;
      key = event['key'];
      eventsController.titleController.text = event['title'];
      eventsController.imgController.text = event['imageurl'];
      eventsController.descController.text = event['description'];
      eventsController.statusController.value = event['status'];
      eventsController.cityController.text = event['city'];
      eventsController.dateController.text = event['date'];
      eventsController.timeController.text = event['time'];
      eventsController.priceController.text = event['price'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(key != null ? 'Edit Event' : 'Add New Event'),
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
      key: eventsController.eventFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: eventsController.titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: eventsController.imgController,
            decoration: InputDecoration(
              labelText: 'Image URL',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an image URL';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: eventsController.descController,
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: eventsController.priceController,
            decoration: InputDecoration(
              labelText: 'Price',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a price';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: eventsController.cityController,
            decoration: InputDecoration(
              labelText: 'City',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a city';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: eventsController.dateController,
            decoration: InputDecoration(
              labelText: 'Date',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a date';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: eventsController.timeController,
            decoration: InputDecoration(
              labelText: 'Time',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a date';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Obx(() {
                return SizedBox(
                  width: 200,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: eventsController.statusController.value.isEmpty
                        ? null
                        : eventsController.statusController.value,
                    hint: Text('Select Status'),
                    items: [
                      DropdownMenuItem(
                        value: 'true',
                        child: Text('Available'),
                      ),
                      DropdownMenuItem(
                        value: 'false',
                        child: Text('Not Available'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        eventsController.statusController.value = value;
                        // Update reactive variable
                      }
                    },
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {
              print(key);
              if (eventsController.eventFormKey.currentState!.validate()) {
                if (key != null) {
                  eventsController.updateEvent(key!);
                } else {
                  eventsController.addEvent();
                }
                Get.back();
              }
            },
            child: Text(key != null ? 'Update Event' : 'Add Event'),
          ),
        ],
      ),
    );
  }
}
