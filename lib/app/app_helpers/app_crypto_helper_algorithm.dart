import 'package:encrypt/encrypt.dart';
import '../app_styles/app_constant_file/app_constant.dart';
import '../app_widgets/app_debug_widget/app_debug_pointer.dart';


class CryptoHelper {
  static final _encrypter = Encrypter(AES(Key.fromUtf8(Keys.cryptoKey),
      mode: AESMode.cbc, padding: "PKCS7"));
  static final _iv = IV.fromLength(16);

  static String decryption(String value) {
    String finalValue = value.replaceAll(" ", "+").trim();
    try {
      return _encrypter.decrypt64(finalValue, iv: _iv).toString();
    } catch (e) {
      Debug.log(e);
    }
    return "";
  }

  static String encryption(String value) {
    try {
      return _encrypter.encrypt(value, iv: _iv).base64;
    } catch (e) {
      Debug.log("Password Encryption Error: $e");
    }
    return "";
  }
}