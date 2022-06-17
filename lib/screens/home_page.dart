// ignore_for_file: prefer_collection_literals
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newsdx/preference/user_preference.dart';
import 'package:newsdx/screens/article_detail.dart';
import 'package:newsdx/viewmodel/Article_list_view_model.dart';
import 'package:newsdx/viewmodel/sections_list_view_model.dart';
import 'package:newsdx/viewmodel/sport_stars_view_model.dart';
import 'package:newsdx/widgets/AllSportsView.dart';
import 'package:newsdx/widgets/article_list.dart';
import 'package:newsdx/widgets/banner_ads.dart';
import 'package:newsdx/widgets/custom_tab_view.dart';
import 'package:newsdx/widgets/full_image_view_item.dart';
import 'package:newsdx/widgets/full_width_article.dart';
import 'package:newsdx/widgets/home_page_list_item.dart';
import 'package:newsdx/widgets/section_list.dart';
import 'package:newsdx/widgets/sport_star_item.dart';
import 'package:newsdx/widgets/sport_stars.dart';
import 'package:newsdx/widgets/subscribe_user.dart';
import 'package:newsdx/widgets/top_picks_item.dart';
import 'package:provider/provider.dart';
import '../utils/CustomColors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  String? token = Prefs.getAccessToken();
  late SectionsViewModel viewModel;
  late ArticleListViewModel articleListViewModel;
  late Sections? data;
  late HomeArticle? homeArticleData;
  List<Article> topPicksList = [];
  late SportStarsViewModel sportStarsViewModel;
  late SportStars? sportStarsList;
  late int _pageIndex = 0;
  late PageController _pageController;
  int initPosition = 0;
  late ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = ScrollController();
    viewModel = context.watch<SectionsViewModel>();
    articleListViewModel = context.watch<ArticleListViewModel>();
    data = viewModel.sectionList;
    int? lengthValue = data?.data?.length ?? 0;
    Section homeSection = Section();
    homeSection.sectionId = "1000";
    homeSection.name = "Home";
    homeSection.subSections = [];
    if (data?.data?[0].name != "Home") {
      data?.data?.insert(0, homeSection);
    }
    homeArticleData = articleListViewModel.homeArticles;
    sportStarsViewModel = context.watch<SportStarsViewModel>();
    sportStarsList = sportStarsViewModel.sportStars;
    String selectedReport = '';

    return SafeArea(
      child: CustomTabView(
        initPosition: initPosition,
        itemCount: lengthValue,
        tabBuilder: (context, index) => Tab(text: data?.data?[index].name,),
        pageBuilder: (context, index) {
          if (index == 0) {
            return Container(
              child: ListView.builder(
                addAutomaticKeepAlives: true,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: homeArticleData?.data?.length,
                controller: _controller,
                itemBuilder: (context, index) {
                  Article? ar = homeArticleData?.data?[index];
                  if (topPicksList.length < 5) {
                    if (ar != null) {
                      topPicksList.add(ar);
                    }
                  }
                  if (index == 0) {
                    return InkWell(
                      onTap: () {
                        _sendDataToSecondScreen(context, ar?.description);
                      },
                      child: FullImageViewItem(
                        article: ar,
                      ),
                    );
                  } else if (index == 3) {
                      return BannerAds();
                  } else if (index == 6) {
                    return SubscribeUserTemplate();
                  } else if (index == 10) {
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      color: CustomColors.topPicksSection,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                child: const Text(
                                  "Top Picks",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "FiraSans",
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, right: 10),
                                child: const Text(
                                  "View more",
                                  style: TextStyle(
                                      fontFamily: "FiraSans",
                                      fontSize: 16,
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                          TopPicksView(data: topPicksList),
                        ],
                      ),
                    );
                  } else if (index == 13) {
                    return sportStarItem(
                      data: sportStarsList?.data,
                    );
                  } else if (index == 16) {
                    return ListTile(
                      title: FullWidthImageItem(ar),
                      onTap: () {
                        _sendDataToSecondScreen(context, ar?.description);
                      },
                    );
                  } else if (index + 1 == homeArticleData?.data?.length) {
                    List<SubSection> sportsChipList =
                        _getSportChipsList(viewModel);
                    return AllSportsViewItem(sportsChipList);
                  }
                  return ListTile(
                    title: HomePageListItem(
                      articleTitle: ar?.title,
                      articleImageUrl: ar?.imgUrl,
                    ),
                    onTap: () {
                      _sendDataToSecondScreen(context, ar?.description);
                    },
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text(
                "Coming soon",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            );
          }
        },
        onPositionChange: (index) {
          initPosition = index;
        },
        onScroll: (position) => print('$position'),
      ),
    );
  }

  _getSportChipsList(SectionsViewModel? sectionsViewModel) {
    Sections? sections = sectionsViewModel?.sectionList;
    List<Section>? sectionList = sections?.data;
    if (sectionList!.isNotEmpty) {
      for (Section section in sectionList) {
        if (section.subSections!.isNotEmpty) {
          return section.subSections;
        }
      }
    }
  }

  void _sendDataToSecondScreen(BuildContext context, String? des) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArticleDetail(
          ),
        ));
  }

  void fetchSubSectionData(var sction_id) {}

}
