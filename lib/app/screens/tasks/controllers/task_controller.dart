import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';



class TaskController extends GetxController {
  var tasks = <Map<String, dynamic>>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('tasks').get();
      tasks.value = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch tasks: ${e.toString()}');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();
      tasks.removeWhere((task) => task['id'] == taskId);
      Get.snackbar('Success', 'Task deleted successfully.');
      await fetchTasks();
      Get.offAllNamed(AppRoutes.homeScreen);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task: ${e.toString()}');
    }
  }

  void addTask(Map<String, dynamic> task) {
    tasks.add(task);
  }

  void editTask(String taskId, Map<String, dynamic> newTask) {
    int index = tasks.indexWhere((task) => task['id'] == taskId);
    if (index != -1) {
      tasks[index] = newTask;
    }
  }
}
