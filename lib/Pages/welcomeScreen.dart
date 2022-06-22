import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:serficon/Pages/StartingPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final contoller = PageController();
  bool isLastPage = false;
  String string = 'Next';
  @override
  void dispose() {
    contoller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: contoller,
          onPageChanged: (index) {
            setState(() {
              if (index == 2) {
                isLastPage = true;
                string = 'Get Started';
              } else {
                isLastPage = false;
                string = 'Next';
              }
            });
          },
          children: [
            Container(
              color: Colors.blueAccent.withOpacity(0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Lottie.asset('assets/lottie/search.json')),

                ],
              ),
            ),
            Container(
              color: Colors.blueAccent.withOpacity(0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Lottie.asset('assets/lottie/find.json')),

                ],
              ),
            ),
            Container(
              color: Colors.blueAccent.withOpacity(0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Lottie.asset('assets/lottie/connect.json')),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  contoller.jumpToPage(2);
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(fontSize: 18),
                )),
            Center(
              child: SmoothPageIndicator(
                onDotClicked: (index) {
                  contoller.animateToPage(index,
                      duration: const Duration(microseconds: 500),
                      curve: Curves.easeIn);
                },
                controller: contoller,
                count: 3,
                effect: const WormEffect(
                    spacing: 16,
                    dotColor: Colors.black26,
                    activeDotColor: Colors.orangeAccent),
              ),
            ),
            TextButton(
                onPressed: () {
                  if (string == 'Get Started') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StartingPage()));
                  } else {
                    contoller.nextPage(
                        duration: const Duration(microseconds: 500),
                        curve: Curves.easeInOut);
                  }
                },
                child: Text(
                  string,
                  style: const TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
