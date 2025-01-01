// models/shopping_list_model.dart
class ShoppingList {
  final String id;
  final String name;
  final String quantity;
  final String date;
  final String time;
  final String priority;
  final List<String> sharedWith;
  final List<ShoppingListItem> items; // Ensure this is included

  ShoppingList({
    required this.id,
    required this.name,
    required this.quantity,
    required this.date,
    required this.time,
    required this.priority,
    required this.sharedWith,
    required this.items, // Include this in constructor
  });

  factory ShoppingList.fromMap(Map<String, dynamic> map, String id) {
    return ShoppingList(
      id: id,
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      priority: map['priority'] ?? '',
      sharedWith: List<String>.from(map['sharedWith'] ?? []),
      items: List<Map<String, dynamic>>.from(map['items'] ?? []).map((item) => ShoppingListItem.fromMap(item)).toList(), // Handle items
    );
  }
}

class ShoppingListItem {
  final String name;
  final bool isPurchased;

  ShoppingListItem({
    required this.name,
    required this.isPurchased,
  });

  factory ShoppingListItem.fromMap(Map<String, dynamic> map) {
    return ShoppingListItem(
      name: map['name'] ?? '',
      isPurchased: map['isPurchased'] ?? false,
    );
  }
}
