
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/router/ui_pages.dart';
import 'package:newsdx/subscription/subscriprtion_plan_screen.dart';
import 'package:newsdx/utils/device_information_list.dart';
import 'package:provider/provider.dart';

import '../model/subscription_plan.dart';
import '../router/app_state.dart';

class UserProfileInfoScreen extends StatefulWidget {
  const UserProfileInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileInfoScreen> createState() => _UserProfileInfoScreenState();
}

class _UserProfileInfoScreenState extends State<UserProfileInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Transform.scale(
          scale: 1,
          child: IconButton(
            icon: SvgPicture.asset("assets/back.svg"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Text(
                  "logout",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black54),
                ),
                IconButton(
                  icon: Transform.scale(
                    scale: 1,
                    child: SvgPicture.asset("assets/logout.svg"),
                  ),
                  onPressed: () {
                    // TODO Clear preference and DB
                  },
                )
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  [
                    CircleAvatar(
                      backgroundImage: Prefs.getIsLoggedIn() == true ?
                          NetworkImage(Prefs.getUserImageUrlInfo()!) : NetworkImage('https://picsum.photos/id/237/200/300') ,
                      radius: 30,
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.transparent,
                  height: 10,
                  thickness: 0.5,
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            Prefs.getIsLoggedIn() == true ? Prefs.getUserNameInfo()! : "Guest",
                            style: GoogleFonts.roboto(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          // Text(
                          //   "",
                          //   style: GoogleFonts.roboto(
                          //       fontSize: 28,
                          //       fontWeight: FontWeight.w700,
                          //       color: Colors.black),
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been",
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black
                      )
                  ),
                ),
                Visibility(visible: true,child: ListTile(
                  title: Text(
                     Prefs.getIsLoggedIn() == true ? Prefs.getUserNumberInfo()! : "", style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black
                  ),
                  ),
                  leading: const Icon(
                    Icons.phone,
                  ),
                  onTap: () => {},
                ),),
                ListTile(
                  title: Text(
                    Prefs.getIsLoggedIn() == true ? Prefs.getUserEmailInfo()! : "",
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black
                      ),
                  ),
                  leading: const Icon(
                    Icons.alternate_email,
                  ),
                  onTap: () => {},
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Column(
                          children: [
                            Text(
                              "No Active Plans",
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(visible: true,child: ListTile(
                  title: Text(
                    'Change Password',
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),),
                const Visibility(visible: true,child: Divider(
                  color: Colors.black,
                  height: 15,
                  thickness: 0.5,
                  indent: 10,
                  endIndent: 10,
                ),),
                ListTile(
                  title: Text(
                    'Payment History',
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onTap: () => {},
                ),
                const Divider(
                  color: Colors.black,
                  height: 15,
                  thickness: 0.5,
                  indent: 10,
                  endIndent: 10,
                ),
                ListTile(
                  title: Text(
                    'Change/Upgrade Plan',
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onTap: () => {
                    appState.currentAction = PageAction(
                        state: PageState.addWidget,
                        widget: const SubscriptionPlanScreen(),
                        page: SubscriptionPlanPageConfig)
                  },
                ),
                const SizedBox(
                  height: 60,
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('For support contact '),
                ),
                 Align(
                  alignment: Alignment.bottomCenter,
                  child:  Text(
                    'wecare@alpinenews.com',
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.blueAccent
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            )),
      ),
    );
  }

  Future<List<Plan>> fetchPost() async {
    String? getAccessToken =
        "Bearer ${"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0aW1lIjoxNjU1NzA5MTA4LCJwcm9wZXJ0eUtleSI6IjBhNDE1OTA2ZGYyZmQ2NDM3MzNiODY1MTY3YWRiMTlkIn0.DveZXEDBB2OJIUU31KlHexj-1L1nYEx1Uxisv45Q0oU"}";

    Map data = {
      "app_bundleId": "in.ninestars.NewsDX",
      "propertyKey": "0a415906df2fd643733b865167adb19d",
    };

    var url = Uri.parse("https://api.newsdx.io/V1/List_in_app_products/apple");
    final response = await http.post(
      url,
      body: data,
      headers: {"Authorization": getAccessToken},
    );

    if (response.statusCode == 200) {
      final subscriptionPlan = subscriptionPlanFromJson(response.body);
      return subscriptionPlan.data!;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
