import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/screens/raceMeets.dart';

class RaceContest extends StatefulWidget {
  String appBarTitle;
  RaceContest({Key key, this.appBarTitle}) : super(key: key);

  @override
  _RaceContestState createState() => _RaceContestState();
}

class _RaceContestState extends State<RaceContest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarHome(context, widget.appBarTitle),
      body: SafeArea(
          child: Container(
        child: ListView.builder(
            primary: false,
            itemCount: 2,
            itemBuilder: (con, i) => Column(
                  children: [
                    buildSizedBox(buildHeight(context), 0.03),
                    Container(
                      height: buildHeight(context) * 0.32,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: boxDecoration.copyWith(color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Race No. 1/25',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Icon(FontAwesomeIcons.infoCircle)
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          buildSizedBox(buildHeight(context), 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                maxRadius: 10,
                                backgroundImage: NetworkImage(
                                    'https://wallpapercave.com/wp/wp3400418.jpg'),
                              ),
                              buildSizedBoxWidth(buildWidth(context), 0.01),
                              Text(
                                'India - Hyderabad Race',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          buildSizedBox(buildHeight(context), 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Ends In: ',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              buildSizedBoxWidth(buildWidth(context), 0.01),
                              CountdownTimer(
                                endTime: 1594829147719,
                                daysSymbol: "D :",
                                hoursSymbol: "H :",
                                minSymbol: "M :",
                                secSymbol: "S",
                                defaultDays: "**",
                                defaultHours: "**",
                                defaultMin: "**",
                                defaultSec: "**",
                                textStyle:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              )
                            ],
                          ),
                          buildSizedBox(buildHeight(context), 0.01),
                          Container(
                            width: double.infinity,
                            child: Text(
                              'Entry Fee: 10 B',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          buildSizedBox(buildHeight(context), 0.01),
                          Container(
                            // width: double.infinity,
                            child: Text(
                              '200 Tickets Joined',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          buildSizedBox(buildHeight(context), 0.01),
                          Divider(),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    child: FlatButton(
                                        onPressed: () {
                                          // Navigator.push(
                                          //     context,
                                          //     FadeNavigation(
                                          //         widget: RaceMeets()));
                                        },
                                        child: Text('LeaderBoard'))),
                                Expanded(
                                    child: FlatButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              FadeNavigation(
                                                  widget: RaceMeets()));
                                        },
                                        child: Text('Join Matches'))),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
      )),
    );
  }
}
