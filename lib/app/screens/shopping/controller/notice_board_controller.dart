import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/notics_board_model.dart';

class NoticeboardController extends GetxController {
  var noticeboardItems = <NoticeboardItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNoticeboardItems();
  }

  Future<void> fetchNoticeboardItems() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('noticeboards').doc('shared').collection('items').get();
      noticeboardItems.value = snapshot.docs.map((doc) {
        final data = doc.data();
        return NoticeboardItem(
          id: doc.id,
          name: data['name'] ?? '',
          type: data['type'] ?? '',
        );
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch noticeboard items: ${e.toString()}');
    }
  }

  Future<void> addItemToNoticeboard(String name, String type) async {
    try {
      final itemRef = FirebaseFirestore.instance.collection('noticeboards').doc('shared').collection('items').doc();
      await itemRef.set({
        'name': name,
        'type': type,
      });
      fetchNoticeboardItems();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add noticeboard item: ${e.toString()}');
    }
  }
}
