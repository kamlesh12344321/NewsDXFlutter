import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loggy/loggy.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/model/SectionList.dart';
import 'package:newsdx/model/SectionPojo.dart';
import 'package:newsdx/model/home_section.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/repo/api_status.dart';
import 'package:newsdx/repo/section_service.dart';
import 'package:newsdx/screens/article_detail.dart';
import 'package:newsdx/viewmodel/Article_list_view_model.dart';
import 'package:newsdx/viewmodel/HomeSectionViewModel.dart';
import 'package:newsdx/viewmodel/generic_list_view_model.dart';
import 'package:newsdx/viewmodel/sections_list_view_model.dart';
import 'package:newsdx/viewmodel/sport_stars_view_model.dart';
import 'package:newsdx/widgets/AllSportsView.dart';
import 'package:newsdx/widgets/article_list.dart';
import 'package:newsdx/widgets/banner_ads.dart';
import 'package:newsdx/widgets/custom_tab_view.dart';
import 'package:newsdx/widgets/full_image_view_item.dart';
import 'package:newsdx/widgets/full_width_article.dart';
import 'package:newsdx/widgets/home_page_list_item.dart';
import 'package:newsdx/widgets/sport_star_item.dart';
import 'package:newsdx/widgets/sport_stars.dart';
import 'package:newsdx/widgets/subscribe_user.dart';
import 'package:newsdx/widgets/top_picks_item.dart';
import 'package:provider/provider.dart';
import '../utils/CustomColors.dart';
import 'package:http/http.dart' as http;
import 'package:loggy/loggy.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with UiLoggy {
  late SectionsViewModel sectionsViewModel;
  late SectionsList? sectionsList;
  int initPosition = 0;
  late ScrollController _controller;
  late ScrollController _controllerBanner;
  late HomeSectionsViewModel homeSectionsViewModel;
  HomeSection? homeSection;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    _controller = ScrollController();
    _controllerBanner = ScrollController();
    homeSectionsViewModel = context.watch<HomeSectionsViewModel>();
    sectionsViewModel = context.watch<SectionsViewModel>();
    homeSection = homeSectionsViewModel.homeSectionList;
    sectionsList = sectionsViewModel?.sectionList;
    int? lengthValue = sectionsList?.data?.length ?? 0;
    int onScrolledPosition = 0;
    Section homeSectionCreate = Section(
      id: "40",
      sectionName: "Home",
    );
    if (sectionsList?.data?[0].sectionName != "Home") {
      sectionsList?.data?.insert(0, homeSectionCreate);
    }
    return WillPopScope(
      onWillPop: () {
        return Future.value(true); // or return Future.value(false);
      },
        child: DefaultTabController(
          length: lengthValue,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              elevation: 0.0,
              leading: Transform.scale(
                  scale: 1.2,
                  child: IconButton(
                      icon: SvgPicture.asset("assets/menu.svg"), onPressed: () {})),
              title: Transform.scale(
                scale: 1,
                child: SvgPicture.asset("assets/app_log.svg"),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Transform.scale(
                    scale: 1,
                    child: SvgPicture.asset("assets/profile_placeholder.svg"),
                  ),
                )
              ],
              bottom: TabBar(
                isScrollable: true,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black,
                tabs: List<Widget>.generate(lengthValue, (int index) {
                  return Tab(
                    text: sectionsList?.data?[index].sectionName,
                  );
                }),
              ),
            ),
            body: TabBarView(
              children: List<Widget>.generate(
                lengthValue,
                    (int index) {
                  if (index == 0) {
                    List<Article>? bannerList = homeSection?.data?.banner;
                    return ListView.builder(
                        addAutomaticKeepAlives: true,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: homeSection?.data?.articles?.length ?? 0,
                        controller: _controller,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return SizedBox(
                              height: 260,
                              width: double.infinity,
                              child: PageView.builder(
                                controller: PageController(
                                  initialPage: _currentIndex,
                                  keepPage: true,
                                ),
                                onPageChanged: (int index) {
                                  _currentIndex = index;
                                  FocusScope.of(context).requestFocus(FocusNode());
                                },
                                itemCount: bannerList!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Article? article = bannerList[index];
                                  return InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => ArticleDetail(
                                      //       articleItem: article,
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                    child: FullImageViewItem(
                                      article: article,
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          return Container();
                        });
                  } else {
                    return FutureBuilder<SectionPojo>(
                      future: getArticles(sectionsList?.data?[index].id),
                      builder: (context, snapShot) {
                        if (snapShot.hasData) {
                          DataPojo? val = snapShot.data?.data;
                          List<Articles>? listValue = val?.articles;
                          var sectionName = listValue![0].sectionname;
                          var sectionId = listValue[0].sectionid;
                          loggy.debug('SectionName :: $sectionName');
                          return ListView.builder(
                            itemCount: val?.articles?.length,
                            itemBuilder: (context, index) {
                              Articles? article = val?.articles?[index];
                              return ListTile(
                                title: HomePageListItem(
                                  articleItem: article,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ArticleDetail(
                                        articleItem: article,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        } else if (snapShot.hasError) {
                          String? er = snapShot.hasError.toString();
                          return Center(
                            child: Text(
                              "Error :: $er",
                              style: const TextStyle(
                                  color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                          );
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ),
    );
  }

  _getSportChipsList(SectionsViewModel? sectionsViewModel) {
    SectionsList? sections = sectionsViewModel?.sectionList;
    List<Section>? sectionList = sections?.data;
    if (sectionList!.isNotEmpty) {
      for (Section section in sectionList) {
        if (section.subsections!.isNotEmpty) {
          return section.subsections;
        }
      }
    }
  }

  Future<SectionPojo> getArticles(String? sectionId) async {
    String? getAccessToken = "Bearer ${MyConstant.propertyToken}";
    var url = Uri.parse(MyConstant.ARTICLE_LIST);

    final response = await http.post(
      url,
      body: {"sectionId": sectionId},
      headers: {
        "Authorization": getAccessToken,
      },
    );

    print(
        "######################################################################");
    //String res = response.body;
    //print(res);

    SectionPojo allSection = modelClassFromJson(response.body);

    // AllSection allSection = allSectionFromJson(response.body);
    // String? sectionName = allSection?.data?.articles![0].sectionName;

    print(
        "######################################################################");
    // loggy.debug('Section ID :: $allSection?.data?.articles![0].sectionId');
    // loggy.debug('Section ID :: $allSection?.data?.articles![0].sectionId.toString()');
    // String? sectionIdd = allSection?.data?.articles![0].sectionid.toString();
    // loggy.debug(sectionIdd);
    // loggy.debug('Sec :: $sectionIdd');
    /*print('Method Section ID :: $allSection?.status :: $sectionId');
    print('Section ID :: $allSection?.data?.articles![0].sectionId');
    print('Section Name :: $allSection?.data?.articles![0].sectionName');*/
    // print('Status :: $allSection?.status');

    return allSection; //allSectionFromJson(response.body);
  }

  SectionPojo modelClassFromJson(String str) =>
      SectionPojo.fromJson(json.decode(str));
}
