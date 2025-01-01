import 'package:family_events_app/app/screens/signup/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../app_helpers/app_text_validation_formates.dart';
import '../../app_styles/app_constant_file/app_colors.dart';
import '../../app_styles/app_constant_file/app_constant.dart';
import '../../app_styles/app_constant_file/app_images.dart';
import '../../routes/app_routes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.put(SignUpController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.lightCyan,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.camera),
                                      title: const Text('Take a Photo'),
                                      onTap: () {
                                        controller.getImage(ImageSource.camera);
                                        Get.back();
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.image),
                                      title: const Text('Choose from Gallery'),
                                      onTap: () async {
                                        controller.getImage(ImageSource.gallery);
                                        Get.back();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Obx(
                                () {
                                  final selectedImage =
                                      controller.selectedImage.value;
                                  return Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CircleAvatar(
                                        radius: 70,
                                        backgroundImage: selectedImage != null
                                            ? Image.file(selectedImage)
                                                .image // Cast to ImageProvider
                                            : const AssetImage(MyImages.logo),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle, // Circular shape
                                    color: MyColors
                                        .primaryColor, // Add your desired background color
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  // Adjust the padding as needed
                                  child: const Icon(
                                    Icons.camera_alt_rounded,
                                    size: 32,
                                    color: Colors.white, // Icon color
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8.0,
                            spreadRadius: 1.0,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 12.0),
                            TextFormField(
                              controller: controller.firstNameController,
                              keyboardType: TextInputType.text,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                labelText: 'First Name',
                                border: InputBorder.none,

                              ),
                              validator: (text) {
                                if (text!.isEmpty) {
                                  return "Can't be empty";
                                } else if (!GetUtils.hasMatch(
                                  text,
                                  TextInputFormatterHelper.numberAndTextWithDot.pattern,
                                )) {
                                  return "First Name ${Keys.bothTextNumber}";
                                }
                                return null;
                              },
                            ),
                            const Divider(
                                color: MyColors.lightBorderColor),
                            TextFormField(
                              controller: controller.lastNameController,
                              keyboardType: TextInputType.text,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                labelText: 'Last Name',
                                border: InputBorder.none,

                              ),
                              validator: (text) {
                                if (text!.isEmpty) {
                                  return "Can't be empty";
                                } else if (!GetUtils.hasMatch(
                                  text,
                                  TextInputFormatterHelper.numberAndTextWithDot.pattern,
                                )) {
                                  return "First Name ${Keys.bothTextNumber}";
                                }
                                return null;
                              },
                            ),
                            const Divider(
                                color: MyColors.lightBorderColor),
                            TextFormField(
                              controller: controller.emailController,
                              decoration: const InputDecoration(
                                labelText: "Gmail",
                                border: InputBorder.none,
                                suffixIcon: Icon(Icons.email,color: MyColors.primaryColor),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: (value) =>
                              !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)
                                  ? "Enter a valid email"
                                  : null,
                            ),
                            const Divider(color: MyColors.lightBorderColor),
                            Obx(
                                  () => TextFormField(
                                controller: controller.passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                autofillHints: const [AutofillHints.password],
                                obscureText: !controller.isPasswordVisible.value,
                                validator: (text) =>
                                text!.isEmpty ? "Can't be empty" : null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Password',
                                  prefixIcon: const Icon(Icons.lock,
                                      color: MyColors.primaryColor),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.togglePasswordVisibility();
                                    },
                                    child: Icon(
                                      controller.isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: MyColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(color: MyColors.lightBorderColor),
                            Obx(
                                  () => TextFormField(
                                controller: controller.confirmPasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                autofillHints: const [AutofillHints.password],
                                obscureText: !controller.isConfirmPasswordVisible.value,
                                validator: (text) {
                                  if (text!.isEmpty) return "Can't be empty";
                                  if (text != controller.passwordController.text) {
                                    return "Passwords don't match";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(Icons.lock,
                                      color: MyColors.primaryColor),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.toggleConfirmPasswordVisibility();
                                    },
                                    child: Icon(
                                        controller.isConfirmPasswordVisible.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: MyColors.primaryColor
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                                color: MyColors.lightBorderColor),
                            const SizedBox(height: 32.0),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32.0),

                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          {
                            controller.signUp();
                          }
                        },
                        child: Text(
                          "Sign Up",
                          style: Get.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: MyColors.shimmerHighlightColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Get.offAllNamed(AppRoutes.loginScreen);
                        },
                        child: Text(
                          "Already have an account? Login",
                          style: Get.textTheme.headlineSmall!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: MyColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
