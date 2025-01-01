import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';


class EventController extends GetxController {
  var events = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('events')
          .orderBy('createdAt', descending: true)
          .get();

      // Map documents to a list of events
      events.value = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'title': data['title'] ?? '',
          'date': data['date'] ?? '',
          'time': data['time'] ?? '',
        };
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch events: ${e.toString()}');
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await FirebaseFirestore.instance
          .collection('events')
          .doc(eventId)
          .delete();

      events.removeWhere((event) => event['id'] == eventId);
      Get.snackbar('Success', 'Event deleted successfully.');

      // Fetch updated events list
      await fetchEvents();

      // Navigate to the home screen
      Get.offAllNamed(AppRoutes.homeScreen);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete event: ${e.toString()}');
    }
  }


  void addEvent(Map<String, String> event) {
    events.add(event);
  }
}
