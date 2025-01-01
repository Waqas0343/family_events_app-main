import 'package:family_events_app/app/app_widgets/custom_card_widget.dart';
import 'package:family_events_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_styles/app_constant_file/app_colors.dart';
import 'controller/shopping_list_controller.dart';

class SharedShoppingListsScreen extends StatelessWidget {
  const SharedShoppingListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ShoppingListController controller = Get.put(ShoppingListController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text(
          'Shared Shopping Lists',
        ),
      ),
      body: Obx(() {
        if (controller.shoppingLists.isEmpty) {
          return const Center(child: Text('No shared lists found.'));
        }
        return ListView.builder(
          itemCount: controller.shoppingLists.length,
          itemBuilder: (context, index) {
            final list = controller.shoppingLists[index];
            Color backgroundColor = index % 2 == 0
                ? Colors.white
                : const Color(
                    0xffe5f7f1,
                  );
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomCard(
                onLongPressed: () {
                  Get.toNamed(AppRoutes.createShoppingList, arguments: {
                    'id': list.id,
                    'name': list.name,
                    'quantity': list.quantity,
                    'date': list.date,
                    'time': list.time,
                    'priority': list.priority,
                    'sharedWith': list.sharedWith,
                  });
                },
                color: backgroundColor,
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    list.name,
                    style: Get.textTheme.titleSmall
                        ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('QTY: ${list.quantity}'),
                      Row(
                        children: [
                          Text(list.time),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(list.date),
                        ],
                      ),
                    ],
                  ),
                  trailing: Text(
                    list.priority,
                    style:
                        Get.textTheme.titleLarge?.copyWith(color: Colors.red),
                  ),
                  onTap: () => Get.toNamed('/shopping-list/${list.id}'),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primaryColor,
        onPressed: () => Get.toNamed(AppRoutes.createShoppingList),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
