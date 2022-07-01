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
  static const String accessToken = "accessToken";
  static const String isProfileImagePresent = "profile_image_present";
  static const String articleIdsList = "article_id_list";
  static const String onBoardingstatus = "onboarding";

  static Future<SharedPreferences?> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<bool> saveIsLoggedIn( bool value) async =>
      await _prefs!.setBool(isLoggedInKey, value);
  static bool getIsLoggedIn() => _prefs!.getBool(isLoggedInKey) ?? false;

  static Future<bool> saveOtpId( int value) async =>
      await _prefs!.setInt(otpId, value);
  static int getOtpId() => _prefs!.getInt(otpId) ?? 0;

  static Future<bool> saveAccessToken(String? value) async =>
      await _prefs!.setString(accessToken, value!);
  static String? getAccessToken() => _prefs!.getString(accessToken) ?? "";

  static Future<bool> saveIsProfileImagePre(bool value) async =>
      await _prefs!.setBool(isProfileImagePresent,value);
  static bool getProfilePre() => _prefs!.getBool(isProfileImagePresent) ?? false;

  static Future<bool> saveArticleBookedList(List<String>?  value) async =>
      await _prefs!.setStringList(articleIdsList, value ?? []);
  static List<String> getArticleStringList() => _prefs!.getStringList(articleIdsList) ?? [];

  static Future<bool> saveOnbording(bool value) async =>
      await _prefs!.setBool(onBoardingstatus, value);
  static bool getOnBoarding() => _prefs!.getBool(onBoardingstatus) ?? false;

}