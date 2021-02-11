import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:winx/functions/widgetFunc.dart';

class CricketGrandLeague extends StatelessWidget {
  const CricketGrandLeague({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        primary: false,
        children: [
          buildSizedBox(buildHeight(context), 0.05),
          Container(
            height: buildHeight(context) * 0.25,
            // padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 6.0,
                  ),
                ],
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text('🏁'),
                                      Text(
                                        ' INDIA ',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('🏁')
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    endIndent: 20,
                                    indent: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 10,
                                        backgroundImage: NetworkImage(
                                            'https://wallpapercave.com/wp/wp3400418.jpg'),
                                      ),
                                      buildSizedBoxWidth(
                                          buildWidth(context), 0.01),
                                      Text(
                                        'Hyderabad Race',
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  buildSizedBox(buildHeight(context), 0.02),
                                  SlideCountdownClock(
                                    duration: Duration(days: 2),
                                    slideDirection: SlideDirection.Up,
                                    separator: ":",
                                    tightLabel: true,
                                    textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    shouldShowDays: true,
                                    onDone: () {
                                      // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Clock 1 finished')));
                                    },
                                  ),
                                  Text(
                                    'dd   :   hh   :   mm   :   ss',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  )
                                ],
                              ))),
                    ],
                  ),
                ),
                Divider(),
                Container(
                    margin: EdgeInsets.only(bottom: 5, left: 5),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.bullhorn,
                          size: 15,
                          color: Colors.black,
                        ),
                        buildSizedBoxWidth(buildWidth(context), 0.05),
                        Text('Updates will be displayed here....',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            )),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
