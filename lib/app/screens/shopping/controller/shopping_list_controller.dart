import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../models/shopping_list_model.dart';

class ShoppingListController extends GetxController {
  var shoppingLists = <ShoppingList>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchShoppingLists();
  }

  Future<void> fetchShoppingLists() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('shopping_lists').get();
      shoppingLists.value = snapshot.docs.map((doc) {
        final data = doc.data();
        return ShoppingList.fromMap(data, doc.id);
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch shopping lists: ${e.toString()}');
    }
  }

  Future<void> addShoppingList({
    required String name,
    required String quantity,
    required String date,
    required String time,
    required String priority,
    required List<String> sharedWith,
  }) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('shopping_lists').doc();
      await docRef.set({
        'name': name,
        'quantity': quantity,
        'date': date,
        'time': time,
        'priority': priority,
        'sharedWith': sharedWith,
      });
      shoppingLists.add(ShoppingList(
        id: docRef.id,
        name: name,
        quantity: quantity,
        date: date,
        time: time,
        priority: priority,
        sharedWith: sharedWith,
        items: [],
      ));

      Get.snackbar('Success', 'Shopping list added successfully.');
      Get.back();
      Get.offAllNamed(AppRoutes.homeScreen);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add shopping list: ${e.toString()}');
    }
  }

  Future<void> updateShoppingList({
    required String id,
    required String name,
    required String quantity,
    required String date,
    required String time,
    required String priority,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('shopping_lists').doc(id).update({
        'name': name,
        'quantity': quantity,
        'date': date,
        'time': time,
        'priority': priority,
      });
      final index = shoppingLists.indexWhere((list) => list.id == id);
      if (index != -1) {
        shoppingLists[index] = ShoppingList(
          id: id,
          name: name,
          quantity: quantity,
          date: date,
          time: time,
          priority: priority,
          sharedWith: shoppingLists[index].sharedWith,
          items: shoppingLists[index].items,
        );
      }

      Get.snackbar('Success', 'Shopping list updated successfully.');
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update shopping list: ${e.toString()}');
    }
  }

  Future<void> deleteShoppingList(String id) async {
    try {
      await FirebaseFirestore.instance.collection('shopping_lists').doc(id).delete();
      shoppingLists.removeWhere((list) => list.id == id);

      Get.snackbar('Success', 'Shopping list deleted successfully.');
      await fetchShoppingLists();
      Get.offAllNamed(AppRoutes.homeScreen);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete shopping list: ${e.toString()}');
    }
  }
}
