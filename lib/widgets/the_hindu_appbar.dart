import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsdx/screens/bookmark.dart';
import 'package:newsdx/userprofile/user_profile_info_screen.dart';

class TheHinduAppBar extends StatelessWidget with PreferredSizeWidget {
  const TheHinduAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 56,
      elevation: 0.0,
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: SizedBox(
          child: SvgPicture.asset("assets/hamburger.svg"),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         SvgPicture.asset("assets/app_log.svg.svg",)
        ],
      ),
      actions: [
        IconButton(
          icon: Image.asset('assets/crown_v90.png'),
          iconSize: 12,
          padding: const EdgeInsets.only(right: 16),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const UserProfileInfoScreen()));
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
