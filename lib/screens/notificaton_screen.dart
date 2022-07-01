import 'package:flutter/material.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/widgets/app_bar.dart';
import 'package:newsdx/widgets/empty_notification.dart';
import 'package:newsdx/widgets/notificaton_filled_container.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int size = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(MyConstant.noTitle,),
      body: size == 0 ? const EmptyNotificationContainer() : const NotificationFilledContainer(),
    );
  }
}
