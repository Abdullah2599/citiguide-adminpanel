import 'package:citiguide_adminpanel/titlescrud/addtileform.dart';
import 'package:citiguide_adminpanel/controllers/admintilecontroller.dart';
import 'package:citiguide_adminpanel/Widgets/drawer.dart';
import 'package:citiguide_adminpanel/titlescrud/tilesdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TileListScreen extends StatelessWidget {
  final AdminTileController tileController = Get.put(AdminTileController());

  TileListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places List'),
      ),
      drawer: const CustomDrawer(),
      body: Obx(
        () {
          if (tileController.tilesRecords.isEmpty) {
            return const Center(child: Text('No places available.'));
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddTileForm()),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildTable(context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width - 16,
          ),
          child: Column(
            children: [
              DataTable(
                columns: const [
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('City')),
                  DataColumn(label: Text('Category')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: tileController.tilesRecords.map((tile) {
                  return DataRow(cells: [
                    DataCell(Text(tile['title'] ?? "")),
                    DataCell(Text(tile['city'] ?? "")),
                    DataCell(Text(tile['category'] ?? "")),
                    DataCell(Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Set the text controllers with the selected tile data
                            tileController.titleController.text =
                                tile['title'] ?? "";
                            tileController.categoryController.text =
                                tile['category'] ?? "";
                            tileController.cityController.text =
                                tile['city'] ?? "";
                            tileController.contactController.text =
                                tile['contact'] ?? "";
                            tileController.descController.text =
                                tile['desc'] ?? "";
                            tileController.imageurlController.text =
                                tile['imageurl'] ?? "";
                            tileController.locationController.text =
                                tile['location'] ?? "";
                            tileController.priceController.text =
                                tile['price'].toString();
                            tileController.offerController.text =
                                (tile['offer'] as List).join(',');

                            // Navigate to AddTileForm with pre-filled data for editing
                            Get.to(() => AddTileForm(), arguments: tile);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          child: const Text('Edit'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => TileDetailsDialog(
                                title: tile['title'] ?? "",
                                category: tile['category'] ?? "",
                                city: tile['city'] ?? "",
                                contact: tile['contact'] ?? "",
                                description: tile['desc'] ?? "",
                                imageUrl: tile['imageurl'] ?? "",
                                location: tile['location'] ?? "",
                                price: tile['price'] ?? 0,
                                offers: List<String>.from(tile['offer'] ?? []),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          child: const Text('Details'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            tileController.deleteTile(tile['title'] ?? "");
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          child: const Text('Delete'),
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: tileController.tilesRecords.length,
      itemBuilder: (context, index) {
        final tile = tileController.tilesRecords[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(tile['title'] ?? ""),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('City: ${tile["city"] ?? ""}'),
                Text('Category: ${tile["category"] ?? ""}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Set the text controllers with the selected tile data
                    tileController.titleController.text = tile['title'] ?? "";
                    tileController.categoryController.text =
                        tile['category'] ?? "";
                    tileController.cityController.text = tile['city'] ?? "";
                    tileController.contactController.text =
                        tile['contact'] ?? "";
                    tileController.descController.text = tile['desc'] ?? "";
                    tileController.imageurlController.text =
                        tile['imageurl'] ?? "";
                    tileController.locationController.text =
                        tile['location'] ?? "";
                    tileController.priceController.text =
                        tile['price'].toString();
                    tileController.offerController.text =
                        (tile['offer'] as List).join(',');

                    // Navigate to AddTileForm with pre-filled data for editing
                    Get.to(() => AddTileForm(), arguments: tile);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.info),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => TileDetailsDialog(
                        title: tile['title'] ?? "",
                        category: tile['category'] ?? "",
                        city: tile['city'] ?? "",
                        contact: tile['contact'] ?? "",
                        description: tile['desc'] ?? "",
                        imageUrl: tile['imageurl'] ?? "",
                        location: tile['location'] ?? "",
                        price: tile['price'] ?? 0,
                        offers: List<String>.from(tile['offer'] ?? []),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    tileController.deleteTile(tile['title'] ?? "");
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
