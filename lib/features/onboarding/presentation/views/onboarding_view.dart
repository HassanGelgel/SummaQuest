import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:testing/constants.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List boarding = const [
    {
      "imgPath": "assets/images/onboarding1.png",
      "title": "If you are confused ?!!"
    },
    {
      "imgPath": "assets/images/onboarding2.jpeg",
      "title": "Welcome to SummaQuest,a great friend to help you"
    },
    {
      "imgPath": "assets/images/onboarding3.png",
      "title": "SummaQuest will be ready to help & make you happy"
    }
  ];
  bool isLastPage = false;

  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    Widget buildBoardingItem(Map<String, String> item) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image(image: AssetImage(item['imgPath']!)),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                item['title']!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          actions: [
            TextButton(
                onPressed: () => null,
                child: Text("Skip",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: sideColor,
                    )))
          ],
        ),
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {});
                  if (index == 2) {
                    isLastPage = true;
                  } else {
                    isLastPage = false;
                  }
                },
                controller: pageController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  SmoothPageIndicator(
                    effect: JumpingDotEffect(
                      paintStyle: PaintingStyle.stroke,
                      activeDotColor: mainColor,
                      dotColor: sideColor,
                    ),
                    controller: pageController,
                    count: boarding.length,
                  ),
                  Spacer(),
                  FloatingActionButton(
                    foregroundColor: mainColor,
                    shape: CircleBorder(),
                    backgroundColor: sideColor,
                    onPressed: () async {
                      // print(isLastPage);
                      if (isLastPage) {
                        // final SharedPreferences pref =
                        //     await SharedPreferences.getInstance();
                        // pref.setBool("onBoarding", false);
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => LoginScreen()),
                        //     (route) => false);
                      } else {
                        pageController.nextPage(
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.easeInOutSine,
                        );
                      }
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
