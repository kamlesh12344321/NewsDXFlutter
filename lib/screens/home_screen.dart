import 'dart:ffi';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:newsdx/model/otp_verification.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/viewmodel/Article_list_view_model.dart';
import 'package:newsdx/viewmodel/generic_list_view_model.dart';
import 'package:newsdx/viewmodel/sections_list_view_model.dart';
import 'package:newsdx/viewmodel/sport_stars_view_model.dart';
import 'package:newsdx/widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return const TheHinduBottomNav();
  }

  @override
  void initState() {
    super.initState();
    if(Prefs.getAccessToken() == null ){
    getUserToken();
  }
  }
}
getUserToken(){
  User? mUser = FirebaseAuth.instance.currentUser;
  Future<OtpVerification> tokenResponse;
  if(mUser != null){
   mUser.getIdToken(true)
       .then((value) => {
         developer.log(value),
     tokenResponse =  sendDataToServer(value),
     tokenResponse.then((value) => {
       Prefs.saveAccessToken(value.data.accessToken)
     })
   })
       .whenComplete(() => {
     developer.log("whenComplete")
   })
       .onError((error, stackTrace) => {
     developer.log("onError :: $error")
   });
  }
}

Future<OtpVerification> sendDataToServer(String value) async {
  Map<String, String> val = {"idTokenString": value, "propertyKey": MyConstant.propertyKey};
  final response = await http.post(Uri.parse("https://api.newsdx.io/V1/end_users/verify_idTokenString"), body: val
  );
 if(response.statusCode == 200){
  developer.log(response.body);
 }
 return OtpVerification.fromJson(jsonDecode(response.body));
}
