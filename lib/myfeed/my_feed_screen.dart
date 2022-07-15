import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:getwidget/types/gf_toggle_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsdx/model/SectionList.dart';
import 'package:newsdx/myfeed/model/myfeed_section.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/viewmodel/sections_list_view_model.dart';
import 'package:provider/provider.dart';

import '../database/data_helper.dart';

class MyFeedScreen extends StatefulWidget {
  @override
  State<MyFeedScreen> createState() => _MyFeedScreenState();
}

class _MyFeedScreenState extends State<MyFeedScreen> {
  late SectionsViewModel sectionsViewModel;
  late SectionsList? sectionsList;
  TextEditingController myController = TextEditingController();
  String? article_title = "";
  bool rememberMe = false;
  List<String> selectedArticleList = [];
  List<Section>?  sectionSList = [];
  List<Section>?  filteredList = [];

  @override
  Widget build(BuildContext context) {
    sectionsViewModel = context.watch<SectionsViewModel>();
    sectionsList = sectionsViewModel?.sectionList;
    sectionsList?.data?.removeAt(0);
    int? lengthValue = sectionsList?.data?.length ?? 0;
    String filter = "";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
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
                 Text(
                  "myFeed",
                  style:  GoogleFonts.roboto(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.black
                  ),
                 ),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: lengthValue,
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
                                        style:   GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54
                                        )
                                    ),
                                    GFToggle(
                                      onChanged: (val) {
                                        addOrRemoveSectionId(title!);
                                      },
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
                    const SizedBox(height: 40,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child:  Text("Save",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),),
                      onPressed: () {

                      },
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
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

  bool addOrRemoveSectionId(String sectionId){

    var result = Helpers.queryMyFeed(sectionId);
    if (result!.length == 0) {
      var myFeed = MyFeedModel(sectionId: sectionId);
      Helpers.insertMyFeed(myFeed);
      return false;
    } else {
      Helpers.deleteMyFeed(result.first.sectionId);
      return true;
    }

    /*if(selectedArticleList.contains(id)){
      selectedArticleList.add(id);
    } else{
      selectedArticleList.remove(id);
    }*/
  }

}
