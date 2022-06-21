import 'package:flutter/material.dart';
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/model/SectionList.dart';
import 'package:newsdx/model/home_section.dart';
import 'package:newsdx/preference/user_preference.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TextEditingController controller = TextEditingController();
  // String? token = Prefs.getAccessToken();
  late SectionsViewModel sectionsViewModel;

  // late ArticleListViewModel articleListViewModel;
  late SectionsList? sectionsList;

  // late ArticleList? homeArticleData;
  // List<Article> topPicksList = [];
  // late SportStarsViewModel sportStarsViewModel;
  // late SportStars? sportStarsList;
  // late int _pageIndex = 0;
  // late PageController _pageController;
  int initPosition = 0;
  late ScrollController _controller;
  late ScrollController _controllerBanner;
  late HomeSectionsViewModel homeSectionsViewModel;
  late HomeSection homeSection;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    _controller = ScrollController();
    _controllerBanner = ScrollController();
    homeSectionsViewModel = context.watch<HomeSectionsViewModel>();
    sectionsViewModel = context.watch<SectionsViewModel>();
    homeSection = homeSectionsViewModel.homeSectionList!;
    sectionsList = sectionsViewModel.sectionList;
    int? lengthValue = sectionsList?.data?.length ?? 0;
    Section homeSectionCreate =
    Section(id: "40", sectionName: "Home",);
    if (sectionsList?.data?[0].sectionName != "Home") {
      sectionsList?.data?.insert(0, homeSectionCreate);
    }
    return Scaffold(
      body: CustomTabView(
        initPosition: initPosition,
        itemCount: lengthValue,
        tabBuilder: (context, index) => Tab(
          text: sectionsList?.data?[index].sectionName,
        ),
        pageBuilder: (context, index){
          if(index == 0) {
            List<Article>? bannerList = homeSection.data?.banner;
            return ListView.builder(
              addAutomaticKeepAlives: true,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: homeSection.data?.articles?.length,
              controller: _controller,
              itemBuilder: (context, index) {
                if(index == 0){
                  return SizedBox(
                    height: 200,
                    width: double.infinity,
                    child:  PageView.builder(
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
                          return FullImageViewItem(article: article,);
                         },
                       ),
                  );
                }
                return Container();
              }
            );
          }
          return const Text("no data");
        },
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

  void _sendDataToSecondScreen(BuildContext context, String? des) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ArticleDetail(),
        ));
  }

  // static Future<Object> getArticles( String? sectionId) async {
  //   String? getAccessToken = "Bearer ${MyConstant.propertyToken}";
  //     var url = Uri.parse(MyConstant.ARTICLE_LIST);
  //     var response = await http.post(url,
  //       body: {"sectionId" : sectionId},
  //       headers: {
  //         "Authorization":  getAccessToken,
  //       },
  //     );
  //
  //       return homeArticleFromJson(response.body) as ArticleListById;
  // }
}
