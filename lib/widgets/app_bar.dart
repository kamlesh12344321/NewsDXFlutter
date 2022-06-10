

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsdx/app_constants/string_constant.dart';
class AppBarWidget extends StatefulWidget with PreferredSizeWidget {
  final String _title;
  AppBarWidget(this._title,{ Key? key}) : preferredSize = const Size.fromHeight(MyConstant.appbarHeight), super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
 final Size preferredSize;
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: Text(widget._title),
      leading:IconButton(onPressed: (){}, icon: Image.asset("assets/back_button.png")),
    );
  }
}
