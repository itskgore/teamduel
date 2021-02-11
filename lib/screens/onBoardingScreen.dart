import 'package:flutter/material.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';

import 'loginScreen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController pageController = new PageController(initialPage: 0);
  Widget pageIndexIndicator(bool isCuurent) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      margin: EdgeInsets.symmetric(horizontal: 3),
      height: isCuurent ? 20.0 : 12.0,
      width: isCuurent ? 20.0 : 12.0,
      decoration: BoxDecoration(
          border: Border.all(
              width: 2, color: Colors.white, style: BorderStyle.solid),
          color: isCuurent ? Colors.red[500] : Colors.grey[400],
          borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              child: PageView(
                controller: pageController,
                onPageChanged: (val) {
                  setState(() {
                    currentIndex = val;
                  });
                },
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage('assets/images/paytm.png'),
                            fit: BoxFit.contain)),
                  ),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage('assets/images/paytm.png'),
                            fit: BoxFit.contain)),
                  ),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage('assets/images/paytm.png'),
                            fit: BoxFit.contain)),
                  ),
                ],
              ),
            ),
            Container(
                alignment: Alignment.topRight,
                child: Container(
                    padding: EdgeInsets.only(top: 20, right: 20),
                    child: GestureDetector(
                      onTap: () {
                        pageController.animateToPage(2,
                            duration: Duration(milliseconds: 600),
                            curve: Curves.linearToEaseOut);
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ))),
            Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      currentIndex == 0
                          ? Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: AnimatedOpacity(
                                opacity: currentIndex == 0 ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 500),
                                child: Text(
                                  'Introduction Text \nwould here\n for three lines',
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      height: 1.5,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : currentIndex == 1
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: AnimatedOpacity(
                                    opacity: currentIndex == 1 ? 1.0 : 0.0,
                                    duration: Duration(milliseconds: 500),
                                    child: Text(
                                      'Introduction Text \nwould here\n for three lines2',
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          height: 1.5,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: AnimatedOpacity(
                                    opacity: currentIndex == 2 ? 1.0 : 0.0,
                                    duration: Duration(milliseconds: 500),
                                    child: SizedBox(
                                      height: 50,
                                      width: 200,
                                      child: OutlineButton(
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    30.0)),
                                        color: Colors.transparent,
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.white),
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              FadeNavigation(
                                                  widget: LoginScreen()));
                                        },
                                        child: Text(
                                          'Get Started',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 0; i < 3; i++)
                            currentIndex == i
                                ? pageIndexIndicator(true)
                                : pageIndexIndicator(false)
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 2,
                        endIndent: 40,
                        indent: 40,
                      ),
                      Text('Powered By Winx'),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
