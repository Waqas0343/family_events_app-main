import 'package:family_events_app/app/app_widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_styles/app_constant_file/app_colors.dart';
import 'controller/shopping_list_controller.dart';
import 'models/shopping_list_model.dart';

class ShoppingListDetailScreen extends StatelessWidget {
  const ShoppingListDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ShoppingListController controller = Get.find();
    final String listId = Get.parameters['id']!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text('Shopping List Details'),
      ),
      body: Obx(() {
        final list = controller.shoppingLists.firstWhere(
              (list) => list.id == listId,
          orElse: () => ShoppingList(
            id: '',
            name: '',
            quantity: '',
            date: '',
            time: '',
            priority: '',
            sharedWith: [],
            items: [], // Ensure empty list if not found
          ),
        );
        if (list.id.isEmpty) {
          return const Center(child: Text('Shopping list not found.'));
        }
        return CustomCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  list.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Quantity: ${list.quantity}'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Date: ${list.date}'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Time: ${list.time}'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Priority: ${list.priority}'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: list.items.length,
                  itemBuilder: (context, index) {
                    final item = list.items[index];
                    return ListTile(
                      title: Text(item.name),
                      trailing: Checkbox(
                        value: item.isPurchased,
                        onChanged: (bool? value) {
                          // Implement update item logic here
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: Get.width,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.deleteShoppingList(listId);
                    },
                    child: const Text('Delete Item'),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
