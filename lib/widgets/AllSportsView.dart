import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsdx/utils/CustomColors.dart';
import 'package:newsdx/widgets/big_text.dart';
import 'package:newsdx/widgets/generic_data.dart';
import 'package:newsdx/widgets/section_list.dart';
import 'package:newsdx/widgets/small_icon_article.dart';
import 'package:newsdx/widgets/small_text.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AllSportsViewItem extends StatefulWidget {
  late List<SubSection> sportSectionData;

  AllSportsViewItem(this.sportSectionData, {Key? key}) : super(key: key);

  @override
  State<AllSportsViewItem> createState() => _AllSportsViewItemState();
}

class _AllSportsViewItemState extends State<AllSportsViewItem> {
  late List<GenericItem> genericListItems;
  late GenericList genericList = GenericList();
  late List<GenericItem> sportsList = [];
  late List<GenericItem> sportsList1 = [];
  var count = 0;

  @override
  Widget build(BuildContext context) {
    SubSection subSection = widget.sportSectionData[0];
    getGenericSportsList(subSection.sectionId.toString());

    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      color: CustomColors.sportUbSectionBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              height: 40,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 16),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.sportSectionData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    String? title = widget.sportSectionData[index].name;
                    return InkWell(
                        onTap: () {
                          setState(() {
                            for (SubSection sub in widget.sportSectionData) {
                              sub.isSelected = false;
                            }
                            SubSection su = widget.sportSectionData[index];
                            su.isSelected = true;

                            String? sec_id_tab =
                                widget.sportSectionData[index].sectionId;
                            count--;
                            getGenericSportsList(sec_id_tab!);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              title!,
                              style: TextStyle(
                                color: widget.sportSectionData[index].isSelected
                                    ? Colors.white
                                    : Colors.grey,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ));
                  })),
          Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 20),
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: sportsList1.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 112,
                    margin: const EdgeInsets.only(
                        top: 12, bottom: 12, left: 16, right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 149.0,
                            height: 112.0,
                            margin: EdgeInsets.only(top: 10),
                            child: CachedNetworkImage(
                              imageUrl: sportsList1[index].imgUrl,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 149.0,
                                height: 112.0,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Image.asset("assets/images/place_holder.png"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BigText(16, Colors.black, 1,
                                  sportsList1[index].title ?? ""),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SmallText(
                                          "National  ", 12, Colors.black, 1.0),
                                      SmallText(
                                          "Time  ", 12, Colors.black, 1.0),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SmallIconArticle(
                                        'assets/images/share.png',
                                        18.0,
                                        17.0,
                                      ),
                                      const SizedBox(
                                        width: 18,
                                        height: 17,
                                      ),
                                      SmallIconArticle(
                                          "assets/images/fav.png", 18.0, 17.0),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<GenericList> getGenericSportsList(String id) async {
    if (count == 0) {
      count++;
      String bodyData = json.encode({
        'section_id': id,
      });
      String url =
          "http://192.168.12.169/projects/Hindu/mvp/project-root/public/api/articles";
      // var bodyData = new Map<String, dynamic>();
      // bodyData["section_id"] = id;
      var response = await http.post(Uri.parse(url), body: bodyData);
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        genericList = GenericList.fromJson(res);
        if (genericList.data!.isNotEmpty) {
          var data = res["data"] as List;
          setState(() {
            sportsList = data
                .map<GenericItem>((json) => GenericItem.fromJson(json))
                .toList();
            sportsList1 = sportsList.sublist(0, 8);
          });
        }
      }
    }
    return genericList;
  }
}
