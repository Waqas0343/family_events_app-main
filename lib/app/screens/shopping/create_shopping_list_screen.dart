import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_helpers/app_spacing.dart';
import '../../app_styles/app_constant_file/app_colors.dart';
import 'controller/create_shopping_list_controller.dart';
import 'controller/shopping_list_controller.dart';

class CreateShoppingListScreen extends StatelessWidget {
  const CreateShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateShoppingListController createController = Get.put(CreateShoppingListController());
    final ShoppingListController listController = Get.find();

    final args = Get.arguments as Map<String, dynamic>?;

    if (args != null) {
      createController.nameController.text = args['name'] ?? '';
      createController.itemQuantity.text = args['quantity'] ?? '';
      createController.dateController.text = args['date'] ?? '';
      createController.timeController.text = args['time'] ?? '';
      createController.taskPriority.value = args['priority'] ?? 'Normal';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(args == null ? 'Create Shopping List' : 'Update Shopping List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                await createController.pickDate(createController.dateController);
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: createController.dateController,
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
            TextFormField(
              keyboardType: TextInputType.text,
              controller: createController.nameController,
              decoration: const InputDecoration(
                labelText: 'Item Name',
              ),
            ),
            otherSpacerVertically(),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: createController.itemQuantity,
              decoration: const InputDecoration(
                labelText: 'Item Quantity',
              ),
            ),
            otherSpacerVertically(),
            DropdownButtonFormField<String>(
              value: createController.taskPriority.value,
              onChanged: (String? newValue) {
                createController.taskPriority.value = newValue!;
              },
              hint: const Text("Select Priority"),
              items: createController.lineSectionName
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            otherSpacerVertically(),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  createController.pickTime(context, "Event Time");
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: createController.timeController,
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
            ),
            otherSpacerVertically(),
            const SizedBox(height: 20),
            SizedBox(
              width: Get.width,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  final id = args?['id'];
                  if (id == null) {
                    listController.addShoppingList(
                      name: createController.nameController.text,
                      quantity: createController.itemQuantity.text,
                      date: createController.dateController.text,
                      time: createController.timeController.text,
                      priority: createController.taskPriority.value,
                      sharedWith: [], // Provide sharedWith list if needed
                    );
                  } else {
                    listController.updateShoppingList(
                      id: id,
                      name: createController.nameController.text,
                      quantity: createController.itemQuantity.text,
                      date: createController.dateController.text,
                      time: createController.timeController.text,
                      priority: createController.taskPriority.value,
                    );
                  }
                },
                child: Text(args == null ? 'Create List' : 'Update List'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
