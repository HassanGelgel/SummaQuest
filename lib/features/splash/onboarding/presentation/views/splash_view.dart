import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/constants.dart';
import 'package:testing/features/onboarding/presentation/views/onboarding_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _positions;
  late List<Animation<double>> _fadeAnimations;
  final String text = "SummaQuest";
  @override
  void initState() {
    super.initState();

    // Hide system UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    final random = Random();

    // Create a list of animations for each letter
    _positions = List.generate(text.length, (index) {
      return Tween<Offset>(
        begin: Offset(
          (random.nextDouble() * 50 - 1) * 3, // Random X position
          (random.nextDouble() * 50 - 1) * 3, // Random Y position
        ),
        end: Offset.zero, // Target position (center)
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
      );
    });

    _fadeAnimations = List.generate(text.length, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
      );
    });

    // Start animation
    _controller.forward();

    // Navigate to the next screen after the splash delay
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return OnboardingScreen();
          //: CurrentScreen(currentScreen: HomeScreen(colors:colors!,));
        }),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            focal: Alignment.center,
            focalRadius:0.005,
            radius: 0.6,
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
              bottom: height * 0.2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(text.length, (index) {
                  return SlideTransition(
                    position: _positions[index],
                    child: FadeTransition(
                      opacity: _fadeAnimations[index],
                      child: Text(
                        text[index],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 50 * width / height,
                          fontFamily: "orbitron",
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            // Positioned(
            //   bottom: 150,
            //   child: CircularProgressIndicator(
            //     value: null,
            //     strokeWidth: 4.0,
            //     backgroundColor: mainColor,
            //     valueColor: AlwaysStoppedAnimation<Color>(sideColor),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
