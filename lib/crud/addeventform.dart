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
      eventsController.contactController.text = event['contact'];
      eventsController.cityController.text = event['city'];
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
            controller: eventsController.contactController,
            decoration: InputDecoration(
              labelText: 'Contact',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a contact';
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
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () {
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
