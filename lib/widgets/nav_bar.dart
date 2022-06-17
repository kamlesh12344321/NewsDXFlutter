import 'package:flutter/material.dart';
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
      child: ListView(
        children: [
          Image.asset("assets/images/landscape.jpg"),
          ListTile(
            leading: Image.asset("assets/images/crown_v90.png"),
            title: BigText(18,Colors.white,1,"Subscribe to Premium"),
            onTap: null,
            tileColor: Colors.blueAccent,

          )
        ],
      ),
    );
  }
}
