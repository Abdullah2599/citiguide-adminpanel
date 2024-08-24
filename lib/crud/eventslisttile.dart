import 'package:citiguide_adminpanel/controllers/eventscontrolle.dart';
import 'package:citiguide_adminpanel/crud/addeventform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EventsScreen extends StatelessWidget {
  final EventsController eventsController = Get.put(EventsController());

  EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: Obx(() {
        if (eventsController.eventsRecords.isEmpty) {
          return const Center(child: Text('No events available.'));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return buildTable(context);
            } else {
              return buildList();
            }
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => EventsForm()),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildTable(context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Title')),
            DataColumn(label: Text('Image')),
            DataColumn(label: Text('Description')),
            DataColumn(label: Text('City')),
            DataColumn(label: Text('Actions')),
          ],
          rows: eventsController.eventsRecords.map((event) {
            return DataRow(cells: [
              DataCell(Text(event["title"] ?? "")),
              DataCell(
                CachedNetworkImage(
                  imageUrl: event["imageurl"] ?? "",
                  width: 100,
                  height: 75,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              DataCell(Text(event["description"] ?? "")),
              DataCell(Text(event["city"] ?? "")),
              DataCell(Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      eventsController.titleController.text = event['title'] ?? "";
                      eventsController.imgController.text = event['imageurl'] ?? "";
                      eventsController.descController.text = event['description'] ?? "";
                      eventsController.contactController.text = event['contact'] ?? "";
                      eventsController.cityController.text = event['city'] ?? "";

                      Get.to(() => EventsForm(), arguments: event);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text('Edit'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      eventsController.deleteEvent(event["key"] ?? "");
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Delete'),
                  ),
                ],
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: eventsController.eventsRecords.length,
      itemBuilder: (context, index) {
        final event = eventsController.eventsRecords[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: event["imageurl"] ?? "",
              width: 50,
              height: 50,
              fit: BoxFit.fill,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            title: Text(event["title"] ?? ""),
            subtitle: Text(event["description"] ?? ""),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    eventsController.titleController.text = event['title'] ?? "";
                    eventsController.imgController.text = event['imageurl'] ?? "";
                    eventsController.descController.text = event['description'] ?? "";
                    eventsController.contactController.text = event['contact'] ?? "";
                    eventsController.cityController.text = event['city'] ?? "";

                    Get.to(() => EventsForm(), arguments: event);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    eventsController.deleteEvent(event["key"] ?? "");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
