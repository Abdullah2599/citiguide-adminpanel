import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  var ordersList = [].obs;

  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  void fetchOrders() async {
    try {
      final usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      for (var userDoc in usersSnapshot.docs) {
        var userData = userDoc.data();
        if (userData.containsKey('orders')) {
          List orders = userData['orders'];
          for (var order in orders) {
            print(userData);

            // Append user's name and other info into the order data
              order['userEmail'] = userDoc.id;
            ordersList.add(order);
          }
        }
      }
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }
}
