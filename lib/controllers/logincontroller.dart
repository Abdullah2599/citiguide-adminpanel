import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController password = TextEditingController();
  // final RoundedLoadingButtonController btnController =
  //     RoundedLoadingButtonController();
  final RxBool loader = false.obs;
  Future<void> signInWithEmailAndPassword() async {
    try {
      loader.value = true;
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: emailAddress.text,
        password: password.text,
      );

      final idTokenResult = await userCredential.user!.getIdTokenResult();
      if (idTokenResult.claims != null &&
          idTokenResult.claims!['admin'] == true) {
        loader.value = false;
        Get.offAllNamed('/adminHomePage');
      } else {
        loader.value = false;
        Get.snackbar('Error', 'You do not have admin rights.');
        await Future.delayed(Duration(seconds: 2));
        // btnController.reset();
        _auth.signOut();
      }
    } on FirebaseAuthException catch (e) {
      // btnController.error();
      loader.value = false;
      Get.snackbar('Error', 'Failed to sign in: $e');
      await Future.delayed(Duration(seconds: 2));
      // btnController.reset();
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.offAllNamed('/login'); // Redirect to the login page
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out: $e');
    }
  }
}
