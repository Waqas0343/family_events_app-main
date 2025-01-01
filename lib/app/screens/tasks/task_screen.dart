import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_styles/app_constant_file/app_colors.dart';
import 'controllers/task_controller.dart';
import '../../app_widgets/custom_card_widget.dart';
import '../../routes/app_routes.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.put(TaskController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Tasks'),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Obx(() {
        if (controller.tasks.isEmpty) {
          return const Center(child: Text("No Data Found"));
        }
        return ListView.builder(
          itemCount: controller.tasks.length,
          itemBuilder: (context, index) {
            Color backgroundColor =
                index % 2 == 0 ? Colors.white : const Color(0xffe5f7f1);
            final task = controller.tasks[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomCard(
                color: backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      task['title'],
                      style: Get.textTheme.titleLarge?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${task['date']} at ${task['time']}',
                          style:
                              Get.textTheme.titleSmall?.copyWith(fontSize: 12),
                        ),
                        Text(
                          '${task['assignedTo']}',
                          style:
                              Get.textTheme.titleSmall?.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.createNewTask,
                        arguments: {
                          'id': task['id'],
                          'title': task['title'],
                          'date': task['date'],
                          'time': task['time'],
                          'priority': task['priority'],
                          'assignedTo': task['assignedTo'],
                        },
                      );
                    },
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        controller.deleteTask(task['id']);
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.createNewTask);
        },
        backgroundColor: MyColors.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
