import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_styles/app_constant_file/app_colors.dart';
import 'controller/notice_board_controller.dart';

class CreateNoticeboardItemScreen extends StatelessWidget {
  final NoticeboardController controller = Get.find();
  final TextEditingController nameController = TextEditingController();
  final String type = 'event';

  CreateNoticeboardItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text(
          'Create Noticeboard Item',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Item Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.addItemToNoticeboard(nameController.text, type);
                Get.back();
              },
              child: const Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}
