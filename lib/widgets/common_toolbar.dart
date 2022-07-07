import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          padding:  EdgeInsets.only(right: 16),
          child: Transform.scale(
            scale: 1,
            child: SvgPicture.asset("assets/profile_placeholder.svg"),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  Size.fromHeight(55);
}
