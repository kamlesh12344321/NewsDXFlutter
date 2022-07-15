import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:provider/provider.dart';

import '../router/app_state.dart';
import '../router/ui_pages.dart';
import '../screens/login_screen.dart';
import '../userprofile/user_profile_info_screen.dart';

class CommonToolbar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  const CommonToolbar( {Key? key, required this.title, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

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
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  const Size.fromHeight(55);
}
