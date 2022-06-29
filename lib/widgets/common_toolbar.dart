import 'package:flutter/material.dart';

class CommonToolbar extends StatelessWidget with PreferredSizeWidget {
  var title  = "";
  CommonToolbar(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.black
      ),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: "FiraSans"
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}
