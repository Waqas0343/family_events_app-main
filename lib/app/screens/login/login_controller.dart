import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../app_helpers/app_crypto_helper_algorithm.dart';
import '../../app_helpers/app_internet_connectivity.dart';
import '../../app_styles/app_constant_file/app_constant.dart';
import '../../app_widgets/app_debug_widget/app_debug_pointer.dart';
import '../../app_widgets/dialogs/dialog.dart';
import '../../app_widgets/toaster.dart';
import '../../routes/app_routes.dart';
import '../../services/app_perferences.dart';


class LoginController extends GetxController {
  final rememberMe = false.obs;
  final RxBool buttonAction = RxBool(true);
  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  var obscureText = true.obs;

  void login() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    buttonAction.value = false;

    Get.dialog(const LoadingSpinner(), barrierDismissible: false);

    if (!await Connectivity.isOnline()) {
      Connectivity.internetErrorDialog();
      buttonAction.value = true;
      Get.back();
      return;
    }

    if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
      Toaster.showToast('Login ID or Password is missing.');
      Get.back();
      buttonAction.value = true;
      return;
    }

    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: phoneController.text,
        password: passwordController.text,
      );

      final User? user = userCredential.user;
      Debug.log('User: ${user?.toString()}');

      if (user != null) {
        await saveUserData(user);
        Get.find<Preferences>().setBool(Keys.status, true);
        Get.offAllNamed(AppRoutes.homeScreen);
      } else {
        Toaster.showToast('User does not exist.');
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        String errorMessage;
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
          case 'user-disabled':
            errorMessage = 'This user has been disabled.';
            break;
          case 'user-not-found':
            errorMessage = 'No user found with this email.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password provided.';
            break;
          case 'too-many-requests':
            errorMessage = 'Too many login attempts. Please try again later.';
            break;
          case 'network-request-failed':
            errorMessage = 'Network error. Please check your internet connection.';
            break;
          default:
            errorMessage = 'An error occurred during login: ${e.message}';
            break;
        }
        Toaster.showToast(errorMessage);
        Debug.log('FirebaseAuthException: ${e.code} - ${e.message}');
      } else {
        Toaster.showToast('An unexpected error occurred. Please try again later.');
        Debug.log('Error: ${e.toString()}');
      }
    } finally {
      Get.back();
      buttonAction.value = true;
    }
  }


  Future<void> saveUserData(User? user) async {
    if (user != null && user.email != null) {
      final firestore = FirebaseFirestore.instance;
      final userDoc = firestore.collection('users').doc(user.uid);

      try {
        final userData = (await userDoc.get()).data();
        if (userData != null) {
          Get.find<Preferences>().setString(Keys.userFirstName, userData['firstName'] ?? "");
          Get.find<Preferences>().setString(Keys.userLastName, userData['lastName'] ?? "");
          Get.find<Preferences>().setString(Keys.userEmail, userData['email'] ?? "");
          Get.find<Preferences>().setString(Keys.userImage, userData['imageURL'] ?? "");
          Get.find<Preferences>().setBool(Keys.status, true);
        } else {
          Debug.log('No user data found in Firestore');
        }
      } catch (e) {
        Debug.log('Error saving user data: ${e.toString()}');
      }
    } else {
      Debug.log('User or User email is null');
    }
  }





  void toggleRememberMe(bool? value) {
    if (value != null) {
      rememberMe.value = value;
      Get.find<Preferences>().setBool(Keys.rememberMe, rememberMe.value);
    }
  }

  void saveLoginCredentials(String value) {
    if (rememberMe.value) {
      String? encyPassword =
      passwordController.text != null ? CryptoHelper.encryption(passwordController.text!) : null;
      Get.find<Preferences>().setString(Keys.userPassword, encyPassword);
      Get.find<Preferences>().setString(Keys.userId, phoneController.text);
    }
  }

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }
  @override
  Future<void> onInit() async {
    super.onInit();
  }
}
