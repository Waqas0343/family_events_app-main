import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import '../../app_styles/app_constant_file/app_constant.dart';
import '../../app_widgets/app_debug_widget/app_debug_pointer.dart';
import '../../app_widgets/dialogs/dialog.dart';
import '../../app_widgets/toaster.dart';
import '../../routes/app_routes.dart';
import '../../services/app_perferences.dart';

class SignUpController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final RxBool isLoading = RxBool(false);
  final RxString avatarUrl = RxString('assets/images/logo.png');
  final RxBool buttonAction = RxBool(true);
  final formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);
  Rx<String?> selectedImageBase64 = Rx<String?>(null);
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }


  Future<void> getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      final bytes = await File(pickedFile.path).readAsBytes();
      selectedImageBase64.value = base64Encode(bytes);
    }
  }

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    Get.dialog(const LoadingSpinner(), barrierDismissible: false);

    if (password != confirmPassword) {
      Toaster.showToast('Passwords do not match');
      Get.back(); // Close the loading spinner dialog
      return;
    }

    isLoading.value = true;

    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user == null) {
        Toaster.showToast('User creation failed. Please try again.');
        return;
      }

      String imageUrl = avatarUrl.value;

      if (selectedImage.value != null) {
        try {
          final Reference storageRef = FirebaseStorage.instance.ref().child('user_images/${user.uid}.jpg');
          final UploadTask uploadTask = storageRef.putFile(selectedImage.value!);
          final TaskSnapshot downloadTask = await uploadTask.whenComplete(() {});
          imageUrl = await downloadTask.ref.getDownloadURL();
        } catch (e) {
          Toaster.showToast('Failed to upload profile picture. Please try again.');
          Debug.log('Error uploading profile picture: ${e.toString()}');
        }
      }
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'imageURL': imageUrl,
      });

      Get.find<Preferences>().setString(Keys.userFirstName, firstName);
      Get.find<Preferences>().setString(Keys.userLastName, lastName);
      Get.find<Preferences>().setString(Keys.userEmail, email);
      Get.find<Preferences>().setBool(Keys.status, true);
      Get.offAllNamed(AppRoutes.homeScreen);
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          Toaster.showToast('The email address is already in use by another account.');
        } else {
          Toaster.showToast(e.message ?? 'An error occurred during sign up.');
        }
      } else {
        Toaster.showToast('An error occurred during sign up.');
      }

      Debug.log('Error during sign up: ${e.toString()}');
    } finally {
      isLoading.value = false;
      Get.back();
    }
  }



  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;

  }
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }


}
