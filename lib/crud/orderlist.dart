import 'package:citiguide_adminpanel/controllers/orderslisttle.dart';
import 'package:citiguide_adminpanel/crud/orderdetailscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrdersListScreen extends StatelessWidget {
  final OrdersController ordersController = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: Obx(() {
        return ListView.builder(
          itemCount: ordersController.ordersList.length,
          itemBuilder: (context, index) {
            var order = ordersController.ordersList[index];
            Timestamp timestamp = order['orderDate'];
            DateTime dateTime = timestamp.toDate();
            String formattedDate =
                DateFormat('yyyy-MM-dd At kk:mm').format(dateTime);
            return ListTile(
              title: Text('Order ID: ${order['orderId']}'),
              subtitle:
                  Text('Date: $formattedDate - User: ${order['userEmail']}'),
              onTap: () {
                // Navigate to order details
                Get.to(() => OrderDetailsScreen(order: order));
              },
            );
          },
        );
      }),
    );
  }
}
