import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsdx/preference/user_preference.dart';

class CommonToolbar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  const CommonToolbar( {Key? key, required this.title, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
      leading: Transform.scale(
        scale: 1.2,
        child: IconButton(
            icon: SvgPicture.asset("assets/back.svg"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      actions: [
        Padding(
          padding:  const EdgeInsets.only(right: 16),
          child: Transform.scale(
            scale: 1,
            child:   CircleAvatar(
              backgroundImage: Prefs.getIsLoggedIn() == true ?
              NetworkImage(Prefs.getUserImageUrlInfo()!) : NetworkImage('https://picsum.photos/id/237/200/300') ,
              radius: 15,
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  Size.fromHeight(55);
}
