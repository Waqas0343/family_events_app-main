import 'package:get/get.dart';

class TeamMember {
  final String name;
  final String role;
  final String studentID;
  final String imageUrl;


  TeamMember({required this.name, required this.role, required this.imageUrl, required this.studentID});
}

class AboutUsController extends GetxController {
  var isLoading = true.obs;
  var teamMembers = <TeamMember>[].obs;
  final features = [
    'Shared Shopping Lists',
    'Event Scheduling',
    'Task Management',
    'Notifications and Reminders',
    'Secure and Private',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTeamMembers();
  }

  void fetchTeamMembers() async {
    // Simulate a network call
    await Future.delayed(Duration(seconds: 2));
    teamMembers.value = [
      TeamMember(
        name: 'Emadeldin Hafez Mohamed Elsayed',
        studentID: '100752420',
        role: 'Lead Developer',
        imageUrl: 'https://via.placeholder.com/150',
      ),

    ];
    isLoading.value = false;
  }
}
