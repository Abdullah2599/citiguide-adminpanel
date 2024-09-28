import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Map order;

  OrderDetailsScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    String status = order['status'];
    Timestamp timestamp = order['orderDate'];
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd At kk:mm').format(dateTime);

    return Scaffold(
      appBar: AppBar(title: Text('Order Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order['orderId']}'),
            Text('Event Name: ${order['eventName']}'),
            Text('Quantity: ${order['quantity']}'),
            Text('Phone: ${order['phone']}'),
            Text('Phone: ${order['address']}'),
            Text('Total Price: ${order['totalPrice']}'),
            Text('Order Date: $formattedDate'),
            SizedBox(height: 20),
            Text('Status:'),
            DropdownButton<String>(
              value: status,
              items: ['pending', 'completed', 'cancelled']
                  .map((value) => DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      ))
                  .toList(),
              onChanged: (newValue) {
                // Update status locally and in Firestore
                status = newValue!;
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(order['userEmail'])
                    .get()
                    .then((DocumentSnapshot documentSnapshot) {
                  if (documentSnapshot.exists) {
                    // Fetch the orders array
                    List<dynamic> orders = documentSnapshot.get('orders');

                    // Find the order by 'orderId'
                    int index = orders
                        .indexWhere((o) => o['orderId'] == order['orderId']);

                    if (index != -1) {
                      // Update the order status
                      orders[index]['status'] = status;

                      // Update the Firestore document with the modified array
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(order['userEmail'])
                          .update({'orders': orders});
                    }
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
