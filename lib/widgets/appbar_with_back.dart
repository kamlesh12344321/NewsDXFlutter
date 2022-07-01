import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/screens/bookmark.dart';
import 'package:newsdx/userprofile/user_profile_info_screen.dart';

class AppBarWithBack extends StatelessWidget with PreferredSizeWidget {
  const AppBarWithBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
      toolbarHeight: 56,
      leading: IconButton(
        onPressed: () {

        },
        icon: SizedBox(
          child: SvgPicture.asset("assets/back.svg"),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         SvgPicture.asset("assets/app_log.svg",height: 50,width: 100,)
        ],
      ),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16.0,
              child: ClipRect(
                child: Prefs.getProfilePre() ? Image.network('https://picsum.photos/250?image=9') : SvgPicture.asset("assets/profile_placeholder.svg"),
              ),
            )
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
