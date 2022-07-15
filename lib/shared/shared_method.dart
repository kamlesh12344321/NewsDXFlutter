
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

class Shared {

  static void onArticleShare(BuildContext context, String title, String articleUrl) async {
     final box = context.findRenderObject() as RenderBox?;
      await Share.share(articleUrl , subject: articleUrl,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}