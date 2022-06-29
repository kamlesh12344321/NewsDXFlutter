import 'package:flutter/material.dart';

class SubscribeUserTemplate extends StatefulWidget {
  const SubscribeUserTemplate({Key? key}) : super(key: key);

  @override
  State<SubscribeUserTemplate> createState() => _SubscribeUserTemplateState();
}

class _SubscribeUserTemplateState extends State<SubscribeUserTemplate> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: 250,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage("http://hindumysqlstaging.ninestars.in/admin/assets/images/icons/th/Light/xxhdpi/ads.png"))),
    );
  }
}
