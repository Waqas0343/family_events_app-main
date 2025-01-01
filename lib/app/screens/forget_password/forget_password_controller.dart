import 'package:family_events_app/app/app_widgets/toaster.dart';
import 'package:family_events_app/app/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final isLoading = false.obs; // Observable for loading spinner

  Future<void> sendPasswordResetEmail() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar('Error', 'Please enter your email address.');
      return;
    }

    isLoading.value = true;

    try {
      await _auth.sendPasswordResetEmail(email: email);
      Toaster.showToast('Success Password reset email sent. Please check your inbox.');
      isLoading.value = false;
      Get.offAllNamed(AppRoutes.loginScreen);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to send password reset email: ${e.toString()}');
    }
  }
}
