import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import '../preference/user_preference.dart';

class DeviceInfo {
  static Future<String> getPhoneInfo() async {
    if (Platform.isAndroid) {
      return "Android";
    } else if (Platform.isIOS) {
      return "iOS";
    }
    return "";
  }

  static saveUserInformation(User user) {
    Prefs.saveUserNameInfo(user.displayName);
    Prefs.saveUserEmailInfo(user.email);
    Prefs.saveUserPhoneInfo(user.phoneNumber);
    Prefs.saveUserImageUrlInfo(user.photoURL);
  }
}

