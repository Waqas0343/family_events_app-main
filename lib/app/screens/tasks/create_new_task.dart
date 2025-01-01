import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_helpers/app_spacing.dart';
import '../../app_styles/app_constant_file/app_colors.dart';
import 'controllers/create_new_task_controller.dart';

class CreateNewTask extends StatelessWidget {
  const CreateNewTask({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateNewTaskController controller = Get.put(CreateNewTaskController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(Get.arguments == null ? 'Create New Task' : 'Update Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              controller: controller.taskTitleController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autofillHints: const [AutofillHints.username],
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Task Title',
              ),
            ),
            otherSpacerVertically(),
            GestureDetector(
              onTap: () async {
                await controller.pickDate(controller.taskDateController);
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: controller.taskDateController,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    filled: true,
                    label: Text("Date"),
                    hintText: "Date",
                    fillColor: Colors.white,
                    suffixIcon: Icon(Icons.calendar_month),
                  ),
                ),
              ),
            ),
            otherSpacerVertically(),
            GestureDetector(
              onTap: () {
                controller.pickTime(context, "Task Time");
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: controller.taskTimeController,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: "Time",
                    fillColor: Colors.white,
                    hintText: "12:00 PM",
                    suffixIcon: Icon(Icons.access_time),
                  ),
                ),
              ),
            ),
            otherSpacerVertically(),
            DropdownButtonFormField<String>(
              value: controller.taskPriority.value,
              onChanged: (String? newValue) {
                controller.taskPriority.value = newValue!;
              },
              hint: const Text("Select Priority"),
              items: controller.lineSectionName.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            otherSpacerVertically(),
            Obx(() {
              if (controller.usersList.isEmpty) {
                return const CircularProgressIndicator();
              } else {
                return DropdownButtonFormField<String>(
                  value: controller.assignedUser.value.isEmpty ? null : controller.assignedUser.value,
                  onChanged: (String? newValue) {
                    controller.assignedUser.value = newValue!;
                  },
                  hint: const Text("Select Assignee"),
                  items: controller.usersList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                );
              }
            }),
            otherSpacerVertically(),
            SizedBox(
              width: Get.width,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  controller.addOrUpdateTask();
                },
                child: Text(Get.arguments == null ? 'Save Task' : 'Update Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
