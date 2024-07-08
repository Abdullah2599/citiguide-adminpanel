import 'package:citiguide_adminpanel/Widgets/drawer.dart';
import 'package:citiguide_adminpanel/controllers/citycontroller.dart';
import 'package:citiguide_adminpanel/crud/addcityform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:your_app/controllers/admin_city_controller.dart';
// import 'package:your_app/widgets/drawer.dart';

class CitiesScreen extends StatelessWidget {
  final AdmincityController adminCityController =
      Get.put(AdmincityController());

  CitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cities'),
      ),
      drawer: const CustomDrawer(),
      body: Obx(() {
        if (adminCityController.citiesRecords.isEmpty) {
          return const Center(child: Text('No cities available.'));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return buildTable();
            } else {
              return buildList();
            }
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddCityForm()),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildTable() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('City')),
            DataColumn(label: Text('Image Link')),
            DataColumn(label: Text('Description')),
            DataColumn(label: Text('Actions')),
          ],
          rows: adminCityController.citiesRecords.map((city) {
            return DataRow(cells: [
              DataCell(Text(city["cname"] ?? "")),
              DataCell(Image.network(
                city["cimg"] ?? "",
                width: 100,
                height: 75,
                fit: BoxFit.cover,
              )),
              DataCell(Text(city["cdesc"] ??
                  "")), // You can add a description field if needed
              DataCell(Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      adminCityController.nameController.text =
                          city['cname'] ?? "";
                      adminCityController.imgController.text =
                          city['cimg'] ?? "";
                      adminCityController.descController.text =
                          city['cdesc'] ?? "";

                      // Navigate to AddCityForm with pre-filled data for editing
                      Get.to(() => AddCityForm(), arguments: city);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text('Edit'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Details action
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text('Details'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      adminCityController.deleteCity(city["cname"] ?? "");
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
      itemCount: adminCityController.citiesRecords.length,
      itemBuilder: (context, index) {
        final city = adminCityController.citiesRecords[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.network(
              city["cimg"] ?? "",
              width: 50,
              height: 50,
              fit: BoxFit.fill,
            ),
            title: Text(city["cname"] ?? ""),
            subtitle: Text(city["cdesc"] ??
                ""), // You can add a description field if needed
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    adminCityController.nameController.text =
                        city['cname'] ?? "";
                    adminCityController.imgController.text = city['cimg'] ?? "";
                    adminCityController.descController.text =
                        city['cdesc'] ?? "";

                    // Navigate to AddCityForm with pre-filled data for editing
                    Get.to(() => AddCityForm(), arguments: city);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.info),
                  onPressed: () {
                    // Details action
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    adminCityController.deleteCity(city["cname"] ?? "");
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
