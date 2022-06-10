import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferenceService {
  static final LocalPreferenceService _preferences = LocalPreferenceService._internal();

  factory LocalPreferenceService() {
    return _preferences;
  }

  LocalPreferenceService._internal();



saveIsLoggedIn() async {
  await _preferences.setBool(MyConstant.isLoggedInKey, true);
}

  setBool(String isLoggedInKey, bool bool) {}

}