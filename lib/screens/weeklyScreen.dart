import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/horse.dart';
import 'package:winx/providers/stateMangedHorseMegaLeague.dart';
import 'package:winx/screens/contestInfo.dart';
import 'package:winx/widgets/myContest.dart';
import '../styles/colors.dart';
import 'myHorseGrandLeagueContest.dart';
import 'leaderBoradMegaContest.dart';

class HorseGrandLeague extends StatefulWidget {
  HorseGrandLeague({Key key}) : super(key: key);

  @override
  _HorseGrandLeagueState createState() => _HorseGrandLeagueState();
}

class _HorseGrandLeagueState extends State<HorseGrandLeague> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  Future<void> _getweeklyhorse() async {
    final weeklyHorse = Provider.of<HorseProvider>(context, listen: false);
    await weeklyHorse.getMyContest();
    if (weeklyHorse.getWeeklyHorse.isEmpty) {
      final res = await weeklyHorse.getWeeklyHorseData();
      if (!res['status']) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(res['msg'])));
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(res['msg'])));
      }
    }
  }

  Future<void> _joinContest(String contestId) async {
    final weeklyHorse = Provider.of<HorseProvider>(context, listen: false);
    final res = await weeklyHorse.joinContest(contestId);
    if (!res['status']) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(res['msg'])));
    } else {
      final res = await weeklyHorse.getMyContest();
      if (!res['status']) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(res['msg'])));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildSizedBox(buildHeight(context), 0.02),
        Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            // margin: EdgeInsets.only(left: 15, bottom: 15),
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Up Coming ',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Consumer<HorseProvider>(
                      builder: (con, myleague, _) => myleague
                              .getMyWeeklyHorse.isEmpty
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    FadeNavigation(
                                        widget: MyHorseGrandLeagueContest()));
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Joined Leagues:',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.grey[200],
                                      child: Text(
                                          '(${myleague.getMyWeeklyHorse.length})'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ],
            )),
        Expanded(
          child: FutureBuilder(
            future: _getweeklyhorse(),
            builder: (con, snap) => snap.connectionState ==
                    ConnectionState.waiting
                ? Center(
                    child: CupertinoActivityIndicator(
                    radius: 20,
                  ))
                : Consumer<HorseProvider>(
                    builder: (con, horse, _) => ListView.builder(
                        primary: false,
                        itemCount: horse.getWeeklyHorse.length,
                        itemBuilder: (con, i) {
                          var items = horse.getWeeklyHorse[i];
                          return Column(
                            children: <Widget>[
                              Container(
                                height: buildHeight(context) * 0.27,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
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
                                        Text(
                                          '${items.contestName}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[400]),
                                            child: Text('Info'))
                                      ],
                                    ),
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
                                            endTime: items.duration,
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
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    buildSizedBox(buildHeight(context), 0.01),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text('Total Cash'),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                    '${items.totalWinningChips}'),
                                                Image.asset(
                                                  'assets/images/Moneymdpi.png',
                                                  width: 12,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text('Total Coins'),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                    '${items.totalWinningCoins}'),
                                                Image.asset(
                                                  'assets/images/Chipsmdpi.png',
                                                  width: 12,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text('Winners'),
                                            Text('${items.noWinning}')
                                          ],
                                        ),
                                      ],
                                    ),
                                    buildSizedBox(buildHeight(context), 0.02),
                                    // Container(
                                    //   width: double.infinity,
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.center,
                                    //     children: [
                                    //       Text(
                                    //         'Ends In: ',
                                    //         style: TextStyle(
                                    //             color: Colors.red,
                                    //             fontSize: 15,
                                    //             fontWeight: FontWeight.bold),
                                    //       ),
                                    //       buildSizedBoxWidth(
                                    //           buildWidth(context), 0.01),
                                    //       CountdownTimer(
                                    //         endTime: items.duration,
                                    //         daysSymbol: "D :",
                                    //         hoursSymbol: "H :",
                                    //         minSymbol: "M :",
                                    //         secSymbol: "S",
                                    //         defaultDays: "**",
                                    //         defaultHours: "**",
                                    //         defaultMin: "**",
                                    //         defaultSec: "**",
                                    //         textStyle: TextStyle(
                                    //             color: Colors.red,
                                    //             fontSize: 15),
                                    //       )
                                    //     ],
                                    //   ),
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[400]),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                    '${items.prizeBreakUp[0].prize} '),
                                                Image.asset(
                                                  'assets/images/Chipsmdpi.png',
                                                  width: 12,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(' to 1st')
                                              ],
                                            )),
                                        buildSizedBoxWidth(
                                            buildWidth(context), 0.20),
                                        Expanded(
                                          child: FlatButton(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 25),
                                              color: Colors.blue,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              onPressed: () {
                                                _joinContest(items.id);
                                              },
                                              child: Text(
                                                'Join Contest',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        }),
                  ),
          ),
        ),
      ],
    );
  }
}
