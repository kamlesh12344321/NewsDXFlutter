
import 'package:flutter/material.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/widgets/app_bar.dart';

class SubscriptionPlanScreen extends StatefulWidget {
  const SubscriptionPlanScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Subscription List")),
      body: PageView(
        children: [
          Container()



        ],
      ),
    );
  }
}
