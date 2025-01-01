import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../app_styles/app_constant_file/app_colors.dart';
import '../../app_styles/app_constant_file/app_images.dart';
import '../../routes/app_routes.dart';
import 'login_controller.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: MyColors.lightCyan,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: GestureDetector(
            onTap: () => Get.focusScope?.unfocus(),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    child: Image.asset(
                      MyImages.logo,
                      height: 300,
                    ),
                  ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        children: [
                          AutofillGroup(
                            child: Form(
                              key: controller.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                    child: TextFormField(
                                      controller: controller.phoneController,
                                      decoration: const InputDecoration(
                                        labelText: 'Email',
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.email,
                                            color: MyColors.primaryColor),
                                      ),
                                      validator: (value) =>
                                      !RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                          .hasMatch(value!)
                                          ? "Enter a valid email"
                                          : null,
                                    ),
                                  ),
                                  const Divider(
                                      color: MyColors.lightBorderColor),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                    child: Obx(
                                          () => TextFormField(
                                        controller:
                                        controller.passwordController,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          border: InputBorder.none,
                                          prefixIcon: const Icon(Icons.lock,
                                              color: MyColors.primaryColor),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              controller.obscureText.value
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: MyColors.primaryColor,
                                            ),
                                            onPressed: controller
                                                .togglePasswordVisibility,
                                          ),
                                        ),
                                        validator: (text) {
                                          if (text!.isEmpty)
                                            return "Can't be empty";
                                          if (text !=
                                              controller
                                                  .passwordController.text) {
                                            return "Passwords don't match";
                                          }
                                          return null;
                                        },
                                        obscureText:
                                        controller.obscureText.value,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    minLeadingWidth: 0,
                                    horizontalTitleGap: 2,
                                    leading: SizedBox(
                                      width: 32,
                                      child: Obx(
                                            () => CheckboxListTile(
                                          value: controller.rememberMe.value,
                                          onChanged: (value) {
                                            controller.toggleRememberMe(value);
                                            TextInput.finishAutofillContext();
                                          },
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      'Remember Me',
                                      style: Get.textTheme.bodyLarge?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Obx(
                          () {
                        return ElevatedButton(
                          onPressed: controller.buttonAction.value
                              ? () {
                            TextInput.finishAutofillContext();
                            controller.login();
                          }
                              : null,
                          child: Text(
                            "Login",
                            style: Get.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: MyColors.shimmerHighlightColor),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.signupScreen);
                      },
                      child: Text(
                        "Sign Up",
                        style: Get.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: MyColors.shimmerHighlightColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.forgotPasswordScreen);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: MyColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
