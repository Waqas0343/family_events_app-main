import 'package:family_events_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';


class CreateNewEventController extends GetxController {
  final TextEditingController eventTitleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  final DateFormat timeFormat = DateFormat('hh:mm a');
  DateTime dateTime = DateTime.now();
  String? eventId;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic>? args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      eventId = args['id'] as String?;
      eventTitleController.text = args['title'] as String? ?? '';
      dateController.text = args['date'] as String? ?? '';
      timeController.text = args['time'] as String? ?? '';
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
      update();
    }
  }

  Future<void> addOrUpdateEvent() async {
    final eventTitle = eventTitleController.text;
    final eventDate = dateController.text;
    final eventTime = timeController.text;

    if (eventTitle.isEmpty || eventDate.isEmpty || eventTime.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields.');
      return;
    }

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        Get.snackbar('Error', 'User not authenticated.');
        return;
      }

      if (eventId == null) {
        // Add new event
        await FirebaseFirestore.instance.collection('events').add({
          'title': eventTitle,
          'date': eventDate,
          'time': eventTime,
          'createdAt': Timestamp.now(),
        });
      } else {
        // Update existing event
        await FirebaseFirestore.instance.collection('events').doc(eventId).update({
          'title': eventTitle,
          'date': eventDate,
          'time': eventTime,
        });
      }

      sendNotification("New Event", "You have received a new event notification");
      Get.offAllNamed(AppRoutes.homeScreen);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void sendNotification(String title, String body) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Event_Notification_Channel',
      'Event Notification Channel',
      channelDescription: 'Channel for event notifications',
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
