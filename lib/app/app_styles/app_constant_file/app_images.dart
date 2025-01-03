
import 'package:flutter/services.dart';

class MyImages{
  static const logo = "assets/images/logo.png";
  static const first = "assets/images/first.png";
  static const google = "assets/images/google.png";

  static Future<Uint8List> getImageBytes(String imagePath) async {
    final ByteData data = await rootBundle.load(imagePath);
    return data.buffer.asUint8List();
  }
}