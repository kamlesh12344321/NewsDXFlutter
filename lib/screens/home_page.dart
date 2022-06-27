import 'package:flutter/material.dart';
import 'package:newsdx/model/SectionList.dart';
import 'package:newsdx/model/home_section.dart';
import 'package:newsdx/preference/user_preference.dart';
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
  late HomeSectionsViewModel homeSectionsViewModel;
  late HomeSection homeSection;

  @override
  Widget build(BuildContext context) {
    _controller = ScrollController();
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
          return const Center(
            child: Text("coming soon"),
          );
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
}
