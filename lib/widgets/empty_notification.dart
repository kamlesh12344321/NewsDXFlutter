import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyNotificationContainer extends StatelessWidget {
  const EmptyNotificationContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            children: [
              SvgPicture.asset("assets/more.svg"),
              const SizedBox(
                width: 5,
              ),
              const Text("Notification",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 32
                ),),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 10),
          child: Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset("assets/no_book_mark.svg"),
          ),
        ),
        Column(
          children: const [
            Text("Sorry", style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),),
            Text("No data to show", style: TextStyle(
                color: Colors.grey
            ),),
          ],
        ),
        const Expanded(child:
        SizedBox(height: 2,),
        ),
        Padding(padding: const EdgeInsets.only(bottom: 30),
          child:  Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: const [
                Text("For support contact", style: TextStyle(
                    fontWeight: FontWeight.w200,
                    color: Colors.black
                ),),
                Text("wecare@alpinenews.com", style: TextStyle(
                    color: Colors.blue,
                  fontWeight: FontWeight.w300,
                ),
                ),
              ],
            ),
          ),)
      ],
    );
  }
}
