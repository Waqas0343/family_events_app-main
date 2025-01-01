import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class NotificationController extends GetxController {
  var notifications = <Map<String, String>>[].obs;
  var familyMembers = <Map<String, String>>[].obs;
  @override
  void onInit() {
    fetchFamilyMembers();
    super.onInit();
  }
  Future<void> fetchFamilyMembers() async {
    try {
      final usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .get();
      final anotherCollectionSnapshot = await FirebaseFirestore.instance
          .collection('anotherCollection')
          .get();
      final combinedData = [
        ...usersSnapshot.docs,
        ...anotherCollectionSnapshot.docs,
      ];

      familyMembers.value = combinedData.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final firstName = data['firstName'] as String? ?? '';
        final lastName = data['lastName'] as String? ?? '';
        final email = data['email'] as String? ?? '';
        final imageUrl = data['imageURL'] as String? ?? '';

        return {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'imageURL': imageUrl,
        };
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch family members: ${e.toString()}');
    }
  }

  Future<void> deleteNotification(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('shopping_lists')
          .doc(id)
          .delete();

      notifications.removeWhere((notification) => notification["id"] == id);
      Get.snackbar('Success', 'Notification deleted successfully.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete notification: ${e.toString()}');
    }
  }
}
