import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loggy/loggy.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/database/data_helper.dart';
import 'package:newsdx/model/SectionList.dart';
import 'package:newsdx/model/SectionPojo.dart';
import 'package:newsdx/model/home_section.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/router/app_state.dart';
import 'package:newsdx/router/ui_pages.dart';
import 'package:newsdx/screens/home_section_article_detail.dart';
import 'package:newsdx/screens/login_screen.dart';
import 'package:newsdx/userprofile/user_profile_info_screen.dart';
import 'package:newsdx/viewmodel/HomeSectionViewModel.dart';
import 'package:newsdx/viewmodel/sections_list_view_model.dart';
import 'package:newsdx/widgets/banner_ads.dart';
import 'package:newsdx/widgets/full_image_view_item.dart';
import 'package:newsdx/widgets/home_article_list_row.dart';
import 'package:newsdx/widgets/home_page_list_row.dart';
import 'package:newsdx/widgets/nav_bar.dart';
import 'package:newsdx/widgets/powered_widget.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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
  late HomeSectionsViewModel homeSectionsViewModel;
  HomeSection? homeSection;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    _controller = ScrollController();
    homeSectionsViewModel = context.watch<HomeSectionsViewModel>();
    sectionsViewModel = context.watch<SectionsViewModel>();
    homeSection = homeSectionsViewModel.homeSectionList;
    sectionsList = sectionsViewModel.sectionList;
    int? lengthValue = sectionsList?.data?.length ?? 0;
    Section homeSectionCreate = Section(
      id: "40",
      sectionName: "Home",
    );
    if (sectionsList?.data?[0].sectionName != "Home") {
      sectionsList?.data?.insert(0, homeSectionCreate);
    }
    return DefaultTabController(
      length: lengthValue,
      initialIndex: 0,
      child: Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          leading: Transform.scale(
              scale: 1.2,
              child: IconButton(
                  icon: SvgPicture.asset("assets/menu.svg"),
                  onPressed: () {
                    // Scaffold.of(context).openDrawer();
                  })),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                "assets/app_logo_new.svg",
                height: 37,
                width: 37,
              ),
              Column(
                children: [
                  Text("Alpine",
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))),
                  Text(
                    "NEWS",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal)),
                  )
                ],
              )
            ],
          ),
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
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,labelStyle: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14
            )
          ),
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
                List<HomeArticle>? bannerList = homeSection?.data.banner;
                List<WidgetHome>? widgetsList = homeSection?.data.widgets;
                List<HomeArticle>? homeArticle3 = homeSection?.data.articles;
                LiveWidget? liveWidget = homeSection?.data.liveWidget;
                HtmlWidget? htmlWidget = homeSection?.data.htmlWidget;

                int listSize = 0;
                if (bannerList != null) {
                  listSize++;
                }
                if (widgetsList != null) {
                  listSize++;
                }
                if (homeArticle3 != null) {
                  listSize++;
                }
                if (liveWidget != null) {
                  listSize++;
                }
                if (htmlWidget != null) {
                  listSize++;
                }
                return ListView.builder(
                    addAutomaticKeepAlives: true,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: listSize,
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
                              HomeArticle? article = bannerList[index];
                              return InkWell(
                                onTap: () {
                                  appState.currentAction = PageAction(
                                      state: PageState.addWidget,
                                      widget: HomeSectionArticleDetail(
                                        homeArticle: article.articleId,
                                        bookmarkStatus: getBookMarkStatus(article.articleId),
                                      ),
                                      page: HomeArticleDetailPageConfig);
                                },
                                child: FullImageViewItem(
                                  article: article,
                                ),
                              );
                            },
                          ),
                        );
                      }
                      if (index == 1) {
                        return ListView.builder(
                            addAutomaticKeepAlives: true,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: homeArticle3!.length,
                            controller: _controller,
                            itemBuilder: (context, index) {
                              HomeArticle? homeArticle = homeArticle3[index];
                              if (index == 4) {
                                return const BannerAds();
                              }
                              if (index == 12) {
                                return const PoweredByAdsWidget();
                              }
                              return InkWell(
                                onTap: () {
                                  appState.currentAction = PageAction(
                                      state: PageState.addWidget,
                                      widget: HomeSectionArticleDetail(
                                        homeArticle: homeArticle.articleId,
                                        bookmarkStatus: getBookMarkStatus(homeArticle.articleId),
                                      ),
                                      page: HomeArticleDetailPageConfig);
                                },
                                child: HomeArticleListItem(
                                    articleItem: homeArticle,
                                    bookmarkStatus: getBookMarkStatus(homeArticle.articleId),
                                ),
                              );
                            });
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
                      loggy.debug('SectionName :: $sectionName');
                      return ListView.builder(
                        itemCount: val?.articles?.length,
                        itemBuilder: (context, index) {
                          Articles? article = val?.articles?[index];
                          return ListTile(
                            tileColor: Colors.white,
                            title: HomePageListItem(
                              articleItem: article,
                              bookmarkStatus: getBookMarkStatus(article!.articleid!),
                            ),
                            onTap: () {
                              appState.currentAction = PageAction(
                                  state: PageState.addWidget,
                                  widget: HomeSectionArticleDetail(
                                    homeArticle: article.articleid,
                                    bookmarkStatus: getBookMarkStatus(article.articleid!),
                                  ),
                                  page: HomeArticleDetailPageConfig);
                            },
                          );
                        },
                      );
                    } else if (snapShot.hasError) {
                      String? er = snapShot.hasError.toString();
                      return Center(
                        child: Text(
                          "Error :: $er",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )
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
    );
  }



  Future<SectionPojo> getArticles(String? sectionId) async {
    String? getAccessToken = MyConstant.propertyToken;
    var url = Uri.parse(MyConstant.articleList);
    final response = await http.post(
      url,
      body: {"sectionId": sectionId},
      headers: {
        "Authorization": getAccessToken,
      },
    );

    SectionPojo allSection = modelClassFromJson(response.body);
    return allSection;
  }

  SectionPojo modelClassFromJson(String str) =>
      SectionPojo.fromJson(jsonDecode(str));

  bool getBookMarkStatus(String articleId) {
    var result = Helpers.queryArticleIds(articleId);
    if (result!.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  showProgressIndication(bool isVisible){
    Visibility(visible: isVisible,child:  const Center(
      child: CircularProgressIndicator(),
    ),);

  }
}
