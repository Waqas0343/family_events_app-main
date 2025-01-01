import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/notice_board_controller.dart';

class SharedNoticeboardScreen extends StatelessWidget {
  const SharedNoticeboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NoticeboardController controller = Get.put(NoticeboardController());
    return Scaffold(
      appBar: AppBar(title: const Text('Shared Noticeboard')),
      body: Obx(() {
        if (controller.noticeboardItems.isEmpty) {
          return const Center(child: Text('No items found.'));
        }
        return ListView.builder(
          itemCount: controller.noticeboardItems.length,
          itemBuilder: (context, index) {
            final item = controller.noticeboardItems[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text(item.type),
              onTap: () => Get.toNamed('/item-details/${item.id}'),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/create-noticeboard-item'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
