import 'package:get/get.dart';

class ProfileController extends GetxController {
  var userName = "John Doe".obs;
  var email = "john.doe@example.com".obs;

  void updateProfile(String name, String email) {
    userName.value = name;
    this.email.value = email;
  }
}
