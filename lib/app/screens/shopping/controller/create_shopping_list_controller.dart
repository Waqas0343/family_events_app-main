import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app_styles/app_constant_file/app_constant.dart';
import '../../../app_widgets/toaster.dart';
import '../../../notification_manager/app_notification.dart';
import '../../../routes/app_routes.dart';

class CreateShoppingListController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController itemQuantity = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final DateFormat dateFormat = DateFormat(Keys.dateFormat);
  final DateFormat timeFormat = DateFormat(Keys.timeFormat);
  DateTime dateTime = DateTime.now();
  var taskPriority = 'Normal'.obs;
  final List<String> lineSectionName = [
    'High',
    'Low',
    'Normal',
  ];

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> addShoppingList(String name, List<String> sharedWith) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('shopping_lists').doc();
      await docRef.set({
        'name': name,
        'quantity': itemQuantity.text,
        'date': dateController.text,
        'time': timeController.text,
        'priority': taskPriority.value,
        'sharedWith': sharedWith,
      });
      Toaster.showToast('shopping item added successfully.');
      Get.back();
      sendNotification("New Shopping List", "You have received a new shopping list notification");
      Get.offAllNamed(AppRoutes.homeScreen);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add shopping list: ${e.toString()}');
    }
  }

  Future<void> pickDate(TextEditingController dateController) async {
    DateTime? date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      dateController.text = dateFormat.format(date);
      dateTime = date;
    }
  }

  Future<void> pickTime(BuildContext context, String data) async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      final now = DateTime.now();
      final formattedTime = DateFormat.jm().format(DateTime(now.year, now.month, now.day, time.hour, time.minute));
      timeController.text = formattedTime;
    }
  }
  void sendNotification(String title, String body) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Shopping_Notification_Channel',
      'Shopping Notification Channel',
      channelDescription: 'Channel for shopping notifications',
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

}
