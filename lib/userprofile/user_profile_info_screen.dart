import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:newsdx/router/ui_pages.dart';
import 'package:newsdx/subscription/subscriprtion_plan_screen.dart';
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
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
      ),
      body: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.only(top: 30,left: 16, right: 16), child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage:
                    NetworkImage('https://picsum.photos/id/237/200/300'),
                    radius: 30,
                  ),
                ],
              ),
              Divider(
                color: Colors.transparent,
                height: 30,
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
                      children: [Text("Krishan"), Text("Kanhai")],
                    )
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been",
                ),
              ),
              ListTile(
                title: Text(
                  '9999999999',
                ),
                leading: Icon(
                  Icons.phone,
                ),
                onTap: () => {},
              ),
              ListTile(
                title: Text(
                  'newsdx@gmail.com',
                ),
                leading: Icon(
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
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          "",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "1 Year",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Change Password',
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
              Divider(
                color: Colors.black,
                height: 20,
                thickness: 0.5,
                indent: 10,
                endIndent: 10,
              ),
              ListTile(
                title: Text(
                  'Payment History',
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () => {},
              ),
              Divider(
                color: Colors.black,
                height: 20,
                thickness: 0.5,
                indent: 10,
                endIndent: 10,
              ),
              ListTile(
                title: Text(
                  'Change/Upgrade Plan',
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () => {
                  appState.currentAction = PageAction(
                      state: PageState.addWidget,
                      widget: SubscriptionPlanScreen(),
                      page: SubscriptionPlanPageConfig)
                },
              ),
              SizedBox(
                height: 40,
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text('For support contact '),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: const Text(
                  'wecare@alpinenews.com',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          )),),
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
