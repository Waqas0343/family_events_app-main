import 'package:family_events_app/app/app_widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_styles/app_constant_file/app_colors.dart';
import 'notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.put(NotificationController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text('Notifications'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.familyMembers.length,
          itemBuilder: (context, index) {
            Color backgroundColor = index % 2 == 0
                ? Colors.white
                : const Color(
              0xffe5f7f1,
            );
            final member = controller.familyMembers[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomCard(
                color: backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading:  CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: member['imageURL'] != null && member['imageURL']!.isNotEmpty
                          ? NetworkImage(member['imageURL']!)
                          : null,
                      child: (member['imageURL'] == null || member['imageURL']!.isEmpty)
                          ? const Icon(
                        Icons.person,
                        color: Colors.grey,
                      )
                          : null,
                    ),
                    title: Text(
                     '${member['firstName'] ?? ''}${ member['lastName'] ?? ''}',
                      style: Get.textTheme.titleLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      member['email'] ?? '',
                      style: Get.textTheme.titleLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
