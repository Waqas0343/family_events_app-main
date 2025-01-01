import 'package:family_events_app/app/app_styles/app_constant_file/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_widgets/app_debug_widget/app_debug_pointer.dart';


class Preferences extends GetxService {
  late SharedPreferences _preferences;

  Future<Preferences> initial() async {
    _preferences = await SharedPreferences.getInstance();
    return this;
  }

  Future setString(String key, String? value) async {
    if (value == null) return;
    try {
      await _preferences.setString(key, value);
    } catch (e) {
      Debug.log("$e");
    }
  }

  Future setInt(String key, int? value) async {
    if (value == null) return;
    try {
      await _preferences.setInt(key, value);
    } catch (e) {
      Debug.log("$e");
    }
  }

  Future setBool(String key, bool? value) async {
    if (value == null) return;
    try {
      await _preferences.setBool(key, value);
    } catch (e) {
      Debug.log("$e");
    }
  }

  String? getString(String key) {
    try {
      return _preferences.getString(key);
    } catch (e) {
      Debug.log("$e");
    }

    return "";
  }

  int? getInt(String key) {
    try {
      return _preferences.getInt(key);
    } catch (e) {
      Debug.log("$e");
    }
    return 0;
  }

  bool? getBool(String key) {
    try {
      return _preferences.getBool(key);
    } catch (e) {
      Debug.log("$e");
    }
    return null;
  }

  Future clear() async {
    await _preferences.clear();
  }
  Future remove(String key) async {
    try {
      await _preferences.remove(key);
    } catch (e) {
      Debug.log("$e");
    }
  }


  Future<void> logout() async {
    await Get.find<Preferences>().clear();
    setBool(Keys.isFirstTime, false);
  }
}