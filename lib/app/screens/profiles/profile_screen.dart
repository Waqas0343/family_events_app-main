import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text(
              "Name: ${controller.userName.value}",
              style: const TextStyle(fontSize: 20.0),
            )),
            const SizedBox(height: 10.0),
            Obx(() => Text(
              "Email: ${controller.email.value}",
              style: const TextStyle(fontSize: 20.0),
            )),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _showEditProfileDialog(context, controller);
              },
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, ProfileController controller) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Enter name'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Enter email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.updateProfile(nameController.text, emailController.text);
                Get.back();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
