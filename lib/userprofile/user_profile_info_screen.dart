import 'package:flutter/material.dart';
import 'package:newsdx/router/ui_pages.dart';
import 'package:newsdx/subscription/subscriprtion_plan_screen.dart';
import 'package:provider/provider.dart';

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
        body: Column(
          children: [
            InkWell(
              onTap: () {},
              child: Text("Payment History",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),),
            ),
            InkWell(
              onTap: () {
                appState.currentAction = PageAction(
                    state: PageState.addWidget,
                    widget: const SubscriptionPlanScreen(),
                    page: SubscriptionPlanPageConfig);
              },
              child: Text("Change/Upgrade Plan",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),),
            ),
          ],
        ));
  }
}
