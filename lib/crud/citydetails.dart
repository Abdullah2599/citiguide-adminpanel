// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CustomerPage extends StatelessWidget {
//   final List<Map<String, String>> customers = [
//     {
//       "CustomerId": "CS11009500",
//       "FirstName": "NADIA Z SAAB",
//       "LastName": "MS.",
//       "PhoneNo": "1234567890",
//       "EmailId": "nadia@example.com",
//       "Image": "assets/avatar1.png"
//     },
//     {
//       "CustomerId": "CS11009503",
//       "FirstName": "GADAH AHMED ALGAFALI",
//       "LastName": "MS.",
//       "PhoneNo": "1234567891",
//       "EmailId": "gadah@example.com",
//       "Image": "assets/avatar2.png"
//     },
//     {
//       "CustomerId": "CS11009505",
//       "FirstName": "KAMLA SAIF NAUMAN ABID",
//       "LastName": "MS.",
//       "PhoneNo": "1234567892",
//       "EmailId": "kamla@example.com",
//       "Image": "assets/avatar3.png"
//     },
//     {
//       "CustomerId": "CS11009527",
//       "FirstName": "FELMA D ULTRA",
//       "LastName": "MS.",
//       "PhoneNo": "1234567893",
//       "EmailId": "felma@example.com",
//       "Image": "assets/avatar4.png"
//     },
//     {
//       "CustomerId": "CS11009530",
//       "FirstName": "SYED MOHAMMED HASAN",
//       "LastName": "HUSSAINI",
//       "PhoneNo": "1234567894",
//       "EmailId": "syed@example.com",
//       "Image": "assets/avatar5.png"
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Customers'),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text(
//                 'Menu',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.home),
//               title: Text('Home'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Icon(Icons.settings),
//               title: Text('Settings'),
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth > 600) {
//             return buildTable();
//           } else {
//             return buildList();
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.toNamed('/addcityform');
//           // Add new customer
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   Widget buildTable() {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(8.0),
//       child: DataTable(
//         columns: [
//           DataColumn(label: Text('CustomerId')),
//           DataColumn(label: Text('FirstName')),
//           DataColumn(label: Text('LastName')),
//           DataColumn(label: Text('PhoneNo')),
//           DataColumn(label: Text('EmailId')),
//           DataColumn(label: Text('Actions')),
//         ],
//         rows: customers.map((customer) {
//           return DataRow(cells: [
//             DataCell(Text(customer["CustomerId"]!)),
//             DataCell(Row(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: AssetImage(customer["Image"]!),
//                 ),
//                 SizedBox(width: 8),
//                 Text(customer["FirstName"]!),
//               ],
//             )),
//             DataCell(Text(customer["LastName"]!)),
//             DataCell(Text(customer["PhoneNo"]!)),
//             DataCell(Text(customer["EmailId"]!)),
//             DataCell(Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     // Edit action
//                   },
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//                   child: Text('Edit'),
//                 ),
//                 SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Details action
//                   },
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//                   child: Text('Details'),
//                 ),
//                 SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Delete action
//                   },
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                   child: Text('Delete'),
//                 ),
//               ],
//             )),
//           ]);
//         }).toList(),
//       ),
//     );
//   }

//   Widget buildList() {
//     return ListView.builder(
//       itemCount: customers.length,
//       itemBuilder: (context, index) {
//         final customer = customers[index];
//         return Card(
//           margin: EdgeInsets.all(8.0),
//           child: ListTile(
//             leading: CircleAvatar(
//               backgroundImage: AssetImage(customer["Image"]!),
//             ),
//             title: Text(customer["FirstName"]!),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('CustomerId: ${customer["CustomerId"]}'),
//                 Text('LastName: ${customer["LastName"]}'),
//                 Text('PhoneNo: ${customer["PhoneNo"]}'),
//                 Text('EmailId: ${customer["EmailId"]}'),
//               ],
//             ),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () {
//                     // Edit action
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.info),
//                   onPressed: () {
//                     // Details action
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () {
//                     // Delete action
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
