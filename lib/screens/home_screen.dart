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
import 'package:newsdx/router/ui_pages.dart';
import 'package:newsdx/subscription/subscriprtion_plan_screen.dart';
import 'package:provider/provider.dart';

import '../router/app_state.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: Row(
          children: const [
            Icon(Icons.ac_unit,),
            Text(MyConstant.appName),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: (){
                appState.currentAction = PageAction(
                    state: PageState.addWidget,
                    widget: const SubscriptionPlanScreen(),
                    page: SubscriptionPlanPageConfig);
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,

                ),
                child: CachedNetworkImage(
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  imageUrl: "https://picsum.photos/250?image=9",
                  placeholder: (context, url) => const CircularProgressIndicator(

                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: const Center(
        child: Text("Home"),
      ),

    );
  }

  @override
  void initState() {
    super.initState();
    getUserToken();
  }
}
getUserToken(){
  User? mUser = FirebaseAuth.instance.currentUser;
  if(mUser != null){
   mUser.getIdToken(true)
       .then((value) => {
         developer.log(value),
      sendDataToServer(value),


   })
       .whenComplete(() => {
     developer.log("whenComplete")
   })
       .onError((error, stackTrace) => {
     developer.log("onError :: "+error.toString())
   });
  }
}

Future sendDataToServer(String value) async {
  Map data = {
    "idTokenString": value,
    "propertyKey": "0a415906df2fd643733b865167adb19d",
  };
  var bodyData = json.encode(data);
  final response = await http.post(Uri.parse("https://api.newsdx.io/V1/end_users/verify_idTokenString"),
    body: bodyData
  );
 if(response.statusCode == 200){
  developer.log(response.body);
 }
}
