

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:provider/provider.dart';

import '../preference/user_preference.dart';
import '../router/app_state.dart';
import '../router/ui_pages.dart';
import '../screens/login_screen.dart';
import '../userprofile/user_profile_info_screen.dart';
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
    final appState = Provider.of<AppState>(context, listen: false);

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: Text(widget._title),
      leading:IconButton(onPressed: (){
        Navigator.of(context).pop();
      }, icon: SvgPicture.asset("assets/back.svg")),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            icon: Transform.scale(
              scale: 1,
              child:   CircleAvatar(
                backgroundImage: Prefs.getIsLoggedIn() == true ?
                NetworkImage(Prefs.getUserImageUrlInfo()!) : const NetworkImage('https://newsdx.io/assets/others/carbon_user-avatar-filled.svg') ,
                radius: 15,
              ),
            ),
            onPressed: () {
              if(Prefs.getIsLoggedIn() == true){
                appState.currentAction = PageAction(
                    state: PageState.addWidget,
                    widget: const UserProfileInfoScreen(),
                    page: UserProfileInfoPageConfig);
              } else{
                appState.currentAction = PageAction(
                    state: PageState.addWidget,
                    widget: const LoginScreen(),
                    page: LoginPageConfig);
              }
            },
          ),
        )
      ],
    );
  }
}
