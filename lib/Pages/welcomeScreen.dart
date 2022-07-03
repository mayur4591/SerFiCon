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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
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
              color: Colors.teal.withOpacity(0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 25),
                          child: Text(
                            'Search',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        child: Center(
                            child: Text(
                          'You can explore the whole city in which you are living without steping outside your door and SerFiCon will bring best for you...',
                          style: TextStyle(fontSize: 18),
                        )),
                      ),
                    ],
                  ),
                  Center(child: Lottie.asset('assets/lottie/search.json')),
                ],
              ),
            ),
            Container(
              color: Colors.teal.withOpacity(0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 25),
                          child: Text(
                            'Find',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        child: Text(
                          'You can find your requirement easily and SerFiCon will help you to give all information about your requirement...',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  Center(child: Lottie.asset('assets/lottie/find.json')),
                ],
              ),
            ),
            Container(
              color: Colors.teal.withOpacity(0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //SizedBox(height: 100,),
                      Container(
                          margin: EdgeInsets.only(left: 25),
                          child: Text(
                            'Connect',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        child: Text(
                          'SerFiCon will help you to connect with right people as per your requirement and you can connect with them...',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
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
                    Navigator.pushReplacement(
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
