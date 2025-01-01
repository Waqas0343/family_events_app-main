import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_styles/app_constant_file/app_colors.dart';
import '../../app_helpers/app_spacing.dart';
import '../../app_styles/app_constant_file/app_images.dart';
import 'forget_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController controller = Get.put(ForgotPasswordController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              child: Image.asset(
                MyImages.logo,
                height: 300,
              ),
            ),
            Text(
              'Enter your email address to receive a password reset link.',
              textAlign: TextAlign.center,
              style: Get.textTheme.titleSmall?.copyWith(fontSize: 16),
            ),
            otherSpacerVertically(),
            TextFormField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            otherSpacerVertically(),
            SizedBox(
              width: Get.width,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  controller.sendPasswordResetEmail();
                },
                child: const Text('Send Reset Link'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
