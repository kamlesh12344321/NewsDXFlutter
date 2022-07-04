import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsdx/screens/brifeing_page.dart';
import 'package:newsdx/screens/home_list.dart';
import 'package:newsdx/screens/setting_screen.dart';
import 'package:newsdx/myfeed/my_feed_screen.dart';
import 'package:newsdx/screens/trending_screen.dart';
import 'package:newsdx/widgets/nav_bar.dart';
import 'package:newsdx/widgets/appbar_with_back.dart';

class TheHinduBottomNav extends StatefulWidget {
  const TheHinduBottomNav({Key? key}) : super(key: key);

  @override
  State<TheHinduBottomNav> createState() => _TheHinduBottomNavState();
}

class _TheHinduBottomNavState extends State<TheHinduBottomNav> {
  int _pageIndex = 0;
  late PageController _pageController;
  List<Widget> tabPages = [
    const HomePage(),
    const BriefingPage(),
    const TrendingPage(),
    MyFeedScreen(),
    const MyAccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(icon: SvgPicture.asset("assets/home_un_selected.svg"), label: "",activeIcon: SvgPicture.asset("assets/home_selected.svg")),
          BottomNavigationBarItem(icon: SvgPicture.asset("assets/trending.svg"), label: "", activeIcon: SvgPicture.asset("assets/trending_selected.svg")),
          BottomNavigationBarItem(icon: SvgPicture.asset("assets/newspaper.svg"), label: "", activeIcon: SvgPicture.asset("assets/newspaper_selected.svg")),
          BottomNavigationBarItem(icon: SvgPicture.asset("assets/newsletter.svg"), label: "", activeIcon:  SvgPicture.asset("assets/newsletter_selected.svg")),
          BottomNavigationBarItem(icon: SvgPicture.asset("assets/more.svg"), label: "", activeIcon: SvgPicture.asset("assets/more_selected.svg"))
        ],
      ),
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _pageIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
