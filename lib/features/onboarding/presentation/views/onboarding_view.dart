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

    Widget buildBoardingItem(Map<String, String> item) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.8, // Responsive width
                  height: height * 0.4, // Responsive height
                  child: Image(image: AssetImage(item['imgPath']!)),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Center(
                  child: Text(
                    item['title']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.06, // Responsive font size
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
              ],
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        actions: [
          TextButton(
            onPressed: () => null,
            child: Text(
              "Skip",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: sideColor,
              ),
            ),
          )
        ],
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == boarding.length - 1;
                });
              },
              controller: pageController,
              itemBuilder: (context, index) =>
                  buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(width * 0.02),
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.02,
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
                SizedBox(
                  height: height * 0.05,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            focalRadius: width * 0.00009,
            radius: width * 0.0039,
            colors: [
              backgroundColor,
              sideColor,
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                SizedBox(height: height * 0.3),
                Image.asset("assets/images/logo.png", height: height * 0.3),
                SizedBox(height: height * 0.2),
              ],
            ),
            // Scatter animation for text
            Positioned(
              bottom: height * 0.3,
              child: Text(
                'Welcome to SummaQuest',
                style: TextStyle(
                  fontSize: width * 0.05, // Responsive font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
