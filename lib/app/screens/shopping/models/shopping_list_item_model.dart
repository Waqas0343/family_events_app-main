class ShoppingListItem {
  String id;
  String name;
  bool isPurchased;

  ShoppingListItem({
    required this.id,
    required this.name,
    this.isPurchased = false,
  });
}