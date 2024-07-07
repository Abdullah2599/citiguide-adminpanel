import 'package:citiguide_adminpanel/titlescrud/addtileform.dart';
import 'package:citiguide_adminpanel/controllers/admintilecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TileListScreen extends StatelessWidget {
  final AdminTileController tileController = Get.put(AdminTileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tile List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(AddTileForm());
            },
          ),
        ],
      ),
      body: Obx(
        () {
          if (tileController.tilesRecords.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('City')),
                  DataColumn(label: Text('Category')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: tileController.tilesRecords.map((tile) {
                  return DataRow(cells: [
                    DataCell(Text(tile['title'])),
                    DataCell(Text(tile['city'])),
                    DataCell(Text(tile['category'])),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Set the text controllers with the selected tile data
                              tileController.titleController.text =
                                  tile['title'];
                              tileController.categoryController.text =
                                  tile['category'];
                              tileController.cityController.text = tile['city'];
                              tileController.contactController.text =
                                  tile['contact'];
                              tileController.descController.text = tile['desc'];
                              tileController.imageurlController.text =
                                  tile['imageurl'];
                              tileController.locationController.text =
                                  tile['location'];
                              tileController.priceController.text =
                                  tile['price'].toString();
                              tileController.offerController.text =
                                  (tile['offer'] as List).join(',');

                              // Navigate to AddTileForm with pre-filled data for editing
                              Get.to(AddTileForm(), arguments: tile);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              tileController.deleteTile(tile['title']);
                            },
                          ),
                        ],
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddTileForm()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
