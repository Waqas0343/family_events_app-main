import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../app_styles/app_constant_file/app_constant.dart';
import '../../services/app_perferences.dart';

class HomeController extends GetxController {
  var tasks = 0.obs;
  var messages = 0.obs;
  var notifications = 0.obs;
  var events = 0.obs;
  var familyMembers = <Map<String, String>>[].obs;
  var upcomingEvents = <Map<String, String>>[].obs;
  var recentlyTask = <Map<String, String>>[].obs;
  var recentlyShopping = <Map<String, String>>[].obs;
  String userName = Get.find<Preferences>().getString(Keys.userFirstName) ?? "";
  String userLastName = Get.find<Preferences>().getString(Keys.userLastName) ?? "";
  String userEmail = Get.find<Preferences>().getString(Keys.userEmail) ?? "";
  String userImage = '';


  @override
  void onInit() {
    super.onInit();
    fetchUpcomingEvents();
    fetchFamilyMembers();
    fetchTasks();
    fetchAllMessage();
  }

  Future<void> fetchUpcomingEvents() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('events')
          .orderBy('createdAt', descending: true)
          .get();

      upcomingEvents.value = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'title': data['title'] as String? ?? '',
          'date': data['date'] as String? ?? '',
        };
      }).toList();
      events.value = upcomingEvents.length;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch events: ${e.toString()}');
    }
  }

  Future<void> fetchFamilyMembers() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .get();

      familyMembers.value = snapshot.docs.map((doc) {
        final data = doc.data();
        final firstName = data['firstName'] as String? ?? '';
        final lastName = data['lastName'] as String? ?? '';
        final email = data['email'] as String? ?? '';
         userImage = data['imageURL'] as String? ?? '';

        return {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'imageURL': userImage,
        };
      }).toList();
      notifications.value = snapshot.docs.length;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch family members: ${e.toString()}');
    }
  }


  Future<void> fetchTasks() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('tasks')
          .get();

      recentlyTask.value = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'title': data['title'] as String? ?? '',
          'date': data['date'] as String? ?? '',
        };
      }).toList();

      tasks.value = snapshot.docs.length;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch tasks: ${e.toString()}');
    }
  }

  Future<void> fetchAllMessage() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('shopping_lists')
          .get();
      recentlyShopping.value = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          "id": doc.id,
          "title": data['name'] as String? ?? 'No Title',
          "description": "Quantity: ${data['quantity'] as String? ?? 'N/A'}",
        };
      }).toList();
      messages.value = snapshot.docs.length;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch tasks: ${e.toString()}');
    }
  }
  String get greeting {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }
}
