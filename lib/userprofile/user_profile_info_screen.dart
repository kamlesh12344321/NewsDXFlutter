import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
             padding: const EdgeInsets.only(left: 10),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Column(
                   children: [
                     Text("Krishan"),
                     Text("Kanhai")
                   ],
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
              onTap: () => {

              },
            ),

            ListTile(
              title: Text(
                'newsdx@gmail.com',
              ),
              leading: Icon(
                Icons.alternate_email,
              ),
              onTap: () => {

              },
            ),


            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
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
                      Text("", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      Text("1 Year",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
              onTap: () => {

              },
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
              widget: const SubscriptionPlanScreen(),
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
              child:  const Text('wecare@alpinenews.com', style: TextStyle(color: Colors.blue),),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ));
  }
}
