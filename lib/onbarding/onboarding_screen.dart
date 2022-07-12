import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:newsdx/app_constants/string_constant.dart';
import 'package:newsdx/screens/home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../preference/user_preference.dart';
import 'model/onboarding_pojo.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var size, height, width;
  var selectedindex = 0;
  late int count = -1;

  PageController controller = PageController();

  late Future<List<Data>> _fetchOnBoardingData;

  @override
  void initState() {
    _fetchOnBoardingData = fetchOnBoardingData();
    setState((){
      _fetchOnBoardingData.then((value) => (
          count = value.length
      ));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: FittedBox(
                      child: Row(
                        children: [
                          SizedBox(
                              width: 50,
                              height: 50,
                              child:
                                  SvgPicture.asset("assets/app_logo_new.svg")),
                          Column(
                            children: [
                              Text(
                                "Alpine",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "NEWS",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              )),
          Flexible(
            child: FutureBuilder<List<Data>>(
              future: _fetchOnBoardingData,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text('Loading....');
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else
                      // count = snapshot.data!.length;
                      return PageView.builder(
                        itemCount: snapshot.data!.length,
                        controller: controller,
                        onPageChanged: (int page){
                          setState((){
                            selectedindex = page;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: [
                                Card(
                                  margin: EdgeInsets.all(10),
                                  elevation: 2,
                                  child: Image.network(
                                    snapshot.data![index].imageUrl!, height: height/2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            textAlign: TextAlign.center,
                                            snapshot.data![index].title!,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                }
              },
            ),
            flex: 4,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: count,
                    effect: WormEffect(
                      dotHeight: 14,
                      dotWidth: 14,
                      type: WormType.thin,
                      // strokeWidth: 5,
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Container(
                            height: 50,
                            child: TextButton(
                              child: const Text(
                                'Skip',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                              ),
                              onPressed: () {
                                onNextEvent();
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Container(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              child: const Text(
                                'Next',
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: () {
                                onNextEvent();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }

  Future<List<Data>> fetchOnBoardingData() async {
    String? getAccessToken = MyConstant.propertyToken;

    var url = Uri.parse("https://api.newsdx.io/V1/onboarding");
    final response = await http.get(
      url,
      headers: {"Authorization": getAccessToken},
    );

    if (response.statusCode == 200) {
      final onBoarding = onboardingPojoFromJson(response.body);
      return onBoarding.data!;
    }
    return [];
  }

  void onNextEvent() async {
    Prefs.saveOnbording(true);
    Navigator.pop(context);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=> HomeScreen())
    );
  }
}
