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
  static const String fcmToken= "fcm_token";
  static const String fcmTokenSave = "fcm_token_save";
  static const String onBookMarkArticelId ="bookmakrarticelId";
  static const String userNameKey = "firebase_name_info";
  static const String userEmaiKey = "firebase_email_info";
  static const String userNumberKey = "firebase_number_info";
  static const String userImageKey = "firebase_image_info";

  static Future<SharedPreferences?> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<bool> saveIsLoggedIn( bool value) async =>
      await _prefs!.setBool(isLoggedInKey, value);
  static bool getIsLoggedIn() => _prefs!.getBool(isLoggedInKey) ?? false;

  static Future<bool> isFcmTokenSent(bool value) async =>
  await _prefs!.setBool(fcmToken, value);
  static bool getIsFcmTokenSent() => _prefs!.getBool(fcmToken) ?? false;

  static Future<bool> saveFcmToken(String? value) async =>
  await _prefs!.setString(fcmTokenSave, value!);
  static String? getSavedFcmToken() => _prefs!.getString(fcmTokenSave) ?? "";

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

  static Future<bool> saveBookMarkArticleId(String articleId) async =>
    await _prefs!.setString(onBookMarkArticelId, articleId);
  static String? getBookMarkArticelId() => _prefs!.getString(onBookMarkArticelId) ?? "";

  static Future<bool> saveUserNameInfo(String? info) async =>
      await _prefs!.setString(userNameKey, info ?? "");

  static String? getUserNameInfo() => _prefs!.getString(userNameKey);

  static Future<bool> saveUserEmailInfo(String? info) async =>
      await _prefs!.setString(userEmaiKey, info ?? "");

  static String? getUserEmailInfo() => _prefs!.getString(userEmaiKey);

  static Future<bool> saveUserPhoneInfo(String? info) async =>
      await _prefs!.setString(userNumberKey, info ?? "");

  static String? getUserNumberInfo() => _prefs!.getString(userNumberKey);

  static Future<bool> saveUserImageUrlInfo(String? info) async =>
      await _prefs!.setString(userImageKey, info ?? "");

  static String? getUserImageUrlInfo() => _prefs!.getString(userImageKey);



}