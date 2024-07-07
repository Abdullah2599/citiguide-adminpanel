import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  final defaultPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            // DashBoardHeader(),
            // Gap(defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "My Products",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical: defaultPadding,
                              ),
                            ),
                            onPressed: () {
                              // showAddProductForm(context, null);
                            },
                            icon: Icon(Icons.add),
                            label: Text("Add New"),
                          ),
                          // Gap(20),
                          IconButton(
                              onPressed: () {
                                //TODO: should complete call getAllProduct
                              },
                              icon: Icon(Icons.refresh)),
                        ],
                      ),
                      // Gap(defaultPadding),
                      // ProductSummerySection(),
                      // Gap(defaultPadding),
                      // ProductListSection(),
                    ],
                  ),
                ),
                SizedBox(width: defaultPadding),
                // Expanded(
                //   flex: 2,
                //   child: OrderDetailsSection(),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}












// // import 'package:citiguide/widgets/Appbar.dart';
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// // import '../controllers/admincity_controller.dart';

// class AdmincityView extends GetView<AdmincityController> {
//   const AdmincityView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appbar("Admin City"),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [

//               Form(
//                 key: controller.cityformKey,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         controller: controller.city,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter city name';
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'City Name',
//               )
//                       )
//                     ) ,

//                     SizedBox(
//                       height: 20,
//                     ),

//                     ElevatedButton(onPressed: () {
//                       if( controller.cityformKey.currentState!.validate()) {
//                         controller.addCity();
//                       }
//                     }, child: Text('Add City'))
//                   ]
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Obx(
//                   () => controller.citiesRecords.length == 0
//                       ? Text("No Data")
//                       :
//                  ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: controller.citiesRecords.length,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemBuilder: (BuildContext context, int index) {
//                     // final city = controller.citylist[index];
//                     return DataCard(
//                       controller.citiesRecords[index]['name'].toString(),
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget DataCard(String title) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(

//           children: [
//             Icon(
//               Icons.location_city,
//               color: Colors.blue,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 title,
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//             Spacer(),
//             IconButton(onPressed: () {
//               Get.dialog(
//                 AlertDialog(
//                   title: Text("Delete City"),
//                   content: Text("Are you sure you want to delete this city?"),
//                   actions: [
//                     TextButton(onPressed: () {
//                       Get.back();
//                     }, child: Text("Cancel")),
//                     TextButton(onPressed: () {
//                       Get.back();
//                       controller.deleteCity(title);
//                     }, child: Text("Yes")),
//                   ],
//                 ),
//               );
//             }, icon: Icon(Icons.delete,color: Colors.red,)),
//           ],
//         ),
//       ),
//     );
//   }
// }
