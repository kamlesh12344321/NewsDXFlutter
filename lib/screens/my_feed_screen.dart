import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:getwidget/types/gf_toggle_type.dart';
import 'package:newsdx/model/SectionList.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/viewmodel/sections_list_view_model.dart';
import 'package:provider/provider.dart';

class PremiumPage extends StatefulWidget {
  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  late SectionsViewModel sectionsViewModel;
  late SectionsList? sectionsList;
  TextEditingController myController = TextEditingController();
  String? article_title = "";
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    sectionsViewModel = context.watch<SectionsViewModel>();
    sectionsList = sectionsViewModel?.sectionList;
    int? lengthValue = sectionsList?.data?.length ?? 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        // leading: Transform.scale(
        //   scale: 1.2,
        //   child: IconButton(
        //       icon: SvgPicture.asset("assets/back.svg"),
        //       onPressed: () {
        //         Navigator.of(context).pop();
        //       }),
        // ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CircleAvatar(
                radius: 16.0,
                child: ClipRect(
                  child: Prefs.getProfilePre()
                      ? Image.network('https://picsum.photos/250?image=9')
                      : SvgPicture.asset("assets/profile_placeholder.svg"),
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 0),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/more.svg",
                  height: 20,
                  width: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "myFeed",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w900),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: myController,
              maxLines: 1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Search Articles"),
              ),
              onChanged: (text) {
                setState() {
                  article_title = text;
                }
              },
            ),
            Expanded(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: lengthValue + 1,
                  itemBuilder: (context, index) {
                    String? title = sectionsList?.data?[index].sectionName;
                    return Padding(
                      padding:
                      const EdgeInsets.only(left: 0, right: 0, top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title ?? "",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              GFToggle(
                                onChanged: (val) {},
                                value: false,
                                enabledTrackColor: Colors.blue,
                                type: GFToggleType.ios,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );

}
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    myController.addListener(() {
      article_title = myController.text;
      setState(() {});
    });
    super.initState();
  }

}
