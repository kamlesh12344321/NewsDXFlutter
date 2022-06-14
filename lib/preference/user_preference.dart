import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs  {
  static SharedPreferences? _prefs;
  static const String firebaseUserData = "user_data";
  static const String isLoggedInKey = "isLoggedIn";
  static const String otpId = "otp_id";

  static Future<SharedPreferences?> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<bool> saveIsLoggedIn( bool value) async =>
      await _prefs!.setBool(isLoggedInKey, value);

  static bool getIsLoggedIn() => _prefs!.getBool(isLoggedInKey) ?? false;

  static Future<bool> saveOtpId( bool value) async =>
      await _prefs!.setBool(otpId, value);

  static int getOtpId() => _prefs!.getInt(otpId) ?? 0;

}