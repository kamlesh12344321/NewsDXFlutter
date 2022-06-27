import 'package:flutter/material.dart';

class BannerAds extends StatefulWidget {
  final String? articleImageUrl;

  const BannerAds({Key? key, this.articleImageUrl}) : super(key: key);

  @override
  State<BannerAds> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 300,
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
