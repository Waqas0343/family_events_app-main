import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';

import '../../../notification_manager/app_notification.dart';
import '../../../routes/app_routes.dart';

class CreateNewTaskController extends GetxController {
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDateController = TextEditingController();
  final TextEditingController taskTimeController = TextEditingController();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  final DateFormat timeFormat = DateFormat('hh:mm a');
  var taskPriority = 'Normal'.obs;
  var assignedUser = ''.obs;
  DateTime dateTime = DateTime.now();
  final List<String> lineSectionName = ['High', 'Low', 'Normal'];
  final RxList<String> usersList = <String>[].obs;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      taskTitleController.text = args['title'] ?? '';
      taskDateController.text = args['date'] ?? '';
      taskTimeController.text = args['time'] ?? '';
      taskPriority.value = args['priority'] ?? 'Normal';
      assignedUser.value = args['assignedTo'] ?? '';
    }
  }

  Future<void> fetchUsers() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('users').get();
      usersList.value = snapshot.docs.map((doc) => doc.data()['email'] as String).toList();
      if (usersList.isNotEmpty) {
        assignedUser.value = usersList.first;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch users: ${e.toString()}');
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
      taskTimeController.text = formattedTime;
      update();
    }
  }

  Future<void> addOrUpdateTask() async {
    final taskTitle = taskTitleController.text;
    final taskDate = taskDateController.text;
    final taskTime = taskTimeController.text;
    final taskPriorityValue = taskPriority.value;
    final assignedUserValue = assignedUser.value;

    if (taskTitle.isEmpty || taskDate.isEmpty || taskTime.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields.');
      return;
    }

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        Get.snackbar('Error', 'User not authenticated.');
        return;
      }

      if (Get.arguments == null) {
        // Add new task
        await FirebaseFirestore.instance.collection('tasks').add({
          'title': taskTitle,
          'date': taskDate,
          'time': taskTime,
          'priority': taskPriorityValue,
          'assignedTo': assignedUserValue,
          'createdAt': Timestamp.now(),
        });
      } else {
        // Update existing task
        final taskId = Get.arguments['id'];
        await FirebaseFirestore.instance.collection('tasks').doc(taskId).update({
          'title': taskTitle,
          'date': taskDate,
          'time': taskTime,
          'priority': taskPriorityValue,
          'assignedTo': assignedUserValue,
        });
      }

      sendNotification("New Task", "You have received a new task notification");
      Get.offAllNamed(AppRoutes.homeScreen);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void sendNotification(String title, String body) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Task_Notification_Channel',
      'Task Notification Channel',
      channelDescription: 'Channel for task notifications',
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
