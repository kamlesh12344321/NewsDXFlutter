import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:newsdx/model/subscription_plan.dart';
import 'package:newsdx/widgets/subscription_plan_widget.dart';



class SubscriptionPlanScreen extends StatefulWidget {
  const SubscriptionPlanScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {

  // getEmployees()async {
  //   Map<String, dynamic> data = {
  //     "app_bundleId": "in.ninestars.NewsDX",
  //     "propertyKey": "0a415906df2fd643733b865167adb19d",
  //   };
  //   var url = Uri.parse("https://api.newsdx.io/V1/List_in_app_products/apple");
  //
  //   final response = await http.post(url, body: data);
  //
  //   var responsBody = json.decode(response.body);
  //   print(responsBody);
  //
  //
  //   return  SubscriptionPlanData.fromJson(json.decoder.convert(response.body)) as SubscriptionPlanData;
  // }

  // late Future<SubscriptionPlanData?> su  =  getSubscriptionDataToServer();
  // late List<Plans>? dataNew  = [];


  late Future<SubscriptionPlan> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
  }


  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    final int dataLength;



    return Scaffold(
        appBar: AppBar(title: Text("Subscriptions List")),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: SvgPicture.asset("assets/app_logo_new.svg"))),
              ),
              Padding(
                padding: EdgeInsets.only(top: 6),
                child: const SizedBox(
                    child: Text(
                  'Subscription Plan',
                 style: TextStyle(
                   fontWeight: FontWeight.w900,
                   fontSize: 30
                 ),),),
              ),
              SizedBox(height: 50,),
              Expanded(
                child: FutureBuilder<SubscriptionPlan>(
                  future: futurePost,
                    builder: (context , snapshot){
                    if (snapshot.hasData) {
                      return PageView.builder(
                        itemCount: 3,
                        controller:  controller,
                        itemBuilder: (context,index){
                          return SubscriptionPlanCard(data: "kumar",);
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                      // int  length = snapshot.data!;



                    }
                ),
              ),
              SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text('For support contact '),
              ),
             Align(
               alignment: Alignment.bottomCenter,
               child:  const Text('wecare@alpinenews.com', style: TextStyle(color: Colors.blue),),
             )
            ],
          ),
        ));
  }

  // Future<SubscriptionPlanData> getSubscriptionDataToServer() async {
  //   Map data = {
  //     "app_bundleId": "in.ninestars.NewsDX",
  //     "propertyKey": "0a415906df2fd643733b865167adb19d",
  //   };
  //   var url = Uri.parse("https://api.newsdx.io/V1/List_in_app_products/apple");
  //   final response = await http.post(url, body: data);
  //
  //   return SubscriptionPlanData.fromJson(jsonDecode(response.body)) as SubscriptionPlanData;
  // }


  Future<SubscriptionPlan> fetchPost() async {

    Map data = {
      "app_bundleId": "in.ninestars.NewsDX",
      "propertyKey": "0a415906df2fd643733b865167adb19d",
    };

    var url = Uri.parse("https://api.newsdx.io/V1/List_in_app_products/apple");
    final response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);

      return parsed.map<SubscriptionPlan>((json) => SubscriptionPlan.fromMap(json));
    } else {
      throw Exception('Failed to load album');
    }
  }

  // @override
  // void initState() {
  //   su =  getSubscriptionDataToServer();
  //   su.then((value) => {
  //     dataNew = value?.data,
  //   });
  // }
}


