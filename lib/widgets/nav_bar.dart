import 'package:flutter/material.dart';
import 'package:newsdx/screens/bookmark.dart';
import 'package:newsdx/screens/more.dart';
import 'package:newsdx/screens/my_feed.dart';
import 'package:newsdx/widgets/big_text.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
         children: [
           Padding(padding: EdgeInsets.only(top: 40,left: 10, right: 10), child: ElevatedButton(
             style: ElevatedButton.styleFrom(
               primary: Colors.blue,
               minimumSize: const Size.fromHeight(50),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(30.0),
               ),
             ),
             child:  const Text("MyFeed"),
             onPressed: () {
               Navigator.of(context).pop();
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyFeed()));
             },
           ),),
           Padding(padding: EdgeInsets.only(top: 20,left: 10, right: 10), child: ElevatedButton(
             style: ElevatedButton.styleFrom(
               primary: Colors.blue,
               minimumSize: const Size.fromHeight(50),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(30.0),
               ),
             ),
             child:  const Text("Bookmark"),
             onPressed: () {
               Navigator.of(context).pop();
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BookMarks()));
             },
           ),),
           Padding(padding: EdgeInsets.only(top: 20,left: 10, right: 10), child: ElevatedButton(
             style: ElevatedButton.styleFrom(
               primary: Colors.blue,
               minimumSize: const Size.fromHeight(50),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(30.0),
               ),
             ),
             child:  const Text("Setting"),
             onPressed: () {
               Navigator.of(context).pop();
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MoreScreen()));
             },
           ),),
         ],
      ),
    );
  }
}
