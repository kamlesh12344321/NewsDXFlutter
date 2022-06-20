import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsdx/model/subscription_plan.dart';



class SubscriptionPlanCard extends StatelessWidget {
  final String data ;
  const SubscriptionPlanCard({Key? key, required this.data}) : super(key: key);



  @override
  Widget build(BuildContext context) {
     const Color topPicksSectionBg = Color(0xFF0F74FF);
    return Card(
      color: topPicksSectionBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child:  Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
             Padding(
                padding:  EdgeInsets.all(7.0),
                child:  Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Recommended",style: TextStyle(color: Colors.white),),
                    ),
                    Padding(padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [

                      ],
                    ),),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(data, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            Text("1 Year",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(10.0),
                      child: Text("100 / Year",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding:  EdgeInsets.all(7.0),
                      child: TextButton(
                        onPressed: () {},
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child:  Text("Checkout",
                          style: TextStyle(
                            color: topPicksSectionBg,
                            fontWeight: FontWeight.w400
                          ),),
                          onPressed: () {
                          },
                        ),
                      ),
                    ),

                   Container(
                     height: 150,
                     child:  ListView(
                       padding: const EdgeInsets.all(8),
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/tick.svg"),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text("Kumar", style: TextStyle(color: Colors.white),),
                            )
                          ],
                         ),
                       ],
                     ),
                   )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
