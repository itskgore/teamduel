import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/horse.dart';
import 'package:winx/screens/raceMeets.dart';

class MyHorseGrandLeagueContest extends StatefulWidget {
  const MyHorseGrandLeagueContest({Key key}) : super(key: key);

  @override
  _MyHorseGrandLeagueContestState createState() =>
      _MyHorseGrandLeagueContestState();
}

class _MyHorseGrandLeagueContestState extends State<MyHorseGrandLeagueContest> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  Future<void> _joinMatches(String contestId) async {
    final joinMatch = Provider.of<HorseProvider>(context, listen: false);
    showSnack(context, 'Loading....', _scaffoldkey);
    final res = await joinMatch.jointMatch(contestId);
    _scaffoldkey.currentState.hideCurrentSnackBar();
    if (!res['status']) {
      showSnack(context, res['msg'], _scaffoldkey);
    } else {
      showSnack(context, res['msg'], _scaffoldkey);
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(context, DownSlideNavigation(widget: RaceMeets()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: buildAppBarHome(context, 'My Grand League Contest'),
      body: SafeArea(
          child: SafeArea(
              child: Consumer<HorseProvider>(
                  builder: (con, myContest, _) => myContest
                          .getMyWeeklyHorse.isEmpty
                      ? Center(
                          child:
                              Text('You have not joined to any contest yet!'),
                        )
                      : ListView.builder(
                          primary: false,
                          itemCount: myContest.getMyWeeklyHorse.length,
                          itemBuilder: (con, i) {
                            var items = myContest.getMyWeeklyHorse[i];
                            return Column(
                              children: <Widget>[
                                buildSizedBox(buildHeight(context), 0.02),
                                Container(
                                  height: buildHeight(context) * 0.30,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 5),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                      color: Colors.grey[200],
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      buildSizedBox(buildHeight(context), 0.01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '${items.contestName}',
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          // Spacer(),
                                          // GestureDetector(
                                          //   onTap: () {
                                          //     Navigator.push(
                                          //         context,
                                          //         FadeNavigation(
                                          //             widget: ContestInfo(
                                          //           items1: items.prizeBreakUp,
                                          //           items2: items.info,
                                          //         )));
                                          //   },
                                          //   child: Icon(
                                          //     FontAwesomeIcons.infoCircle,
                                          //     color: primaryColors,
                                          //   ),
                                          // )
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.black,
                                      ),
                                      buildSizedBox(buildHeight(context), 0.01),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    'Prize Money :',
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  buildSizedBoxWidth(
                                                      buildWidth(context),
                                                      0.01),
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .accentColor),
                                                    child: Text(
                                                      '${items.prizeBreakUp[0].prize} R to 1st',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              buildSizedBox(
                                                  buildHeight(context), 0.01),
                                              Row(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        '${items.prizeMoney}',
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .cashRegister,
                                                        size: 10,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        '${items.prizeCoins}',
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .cashRegister,
                                                          size: 10)
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              Text(
                                                'Winner',
                                                textAlign: TextAlign.center,
                                              ),
                                              buildSizedBox(
                                                  buildHeight(context), 0.01),
                                              Text(
                                                'Top ${items.noWinner}',
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      buildSizedBox(buildHeight(context), 0.02),
                                      Container(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Ends In: ',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            buildSizedBoxWidth(
                                                buildWidth(context), 0.01),
                                            CountdownTimer(
                                              endTime: int.parse(items.seconds),
                                              daysSymbol: "D :",
                                              hoursSymbol: "H :",
                                              minSymbol: "M :",
                                              secSymbol: "S",
                                              defaultDays: "**",
                                              defaultHours: "**",
                                              defaultMin: "**",
                                              defaultSec: "**",
                                              textStyle: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 15),
                                            )
                                          ],
                                        ),
                                      ),
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
                                                      //         widget:
                                                      //             LeaderBoradMegaContest(
                                                      //       appBarTitle:
                                                      //           'Racing Contest From 20-June to 25-July',
                                                      //     )));
                                                    },
                                                    child:
                                                        Text('LeaderBoard'))),
                                            Expanded(
                                                child: FlatButton(
                                                    onPressed: () {
                                                      _joinMatches(
                                                          items.contestId);
                                                      // _joinContest(items.id);
                                                    },
                                                    child:
                                                        Text('Join Matches'))),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            );
                          })))),
    );
  }
}
