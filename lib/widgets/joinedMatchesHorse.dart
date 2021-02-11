import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/horse.dart';
import 'package:winx/providers/stateMangedHorseMegaLeague.dart';
import 'package:winx/widgets/joinTicketDialog.dart';

class JoinedMatches extends StatefulWidget {
  TabController tabController;
  JoinedMatches(
    this.tabController, {
    Key key,
  }) : super(key: key);

  @override
  _JoinedMatchesState createState() => _JoinedMatchesState();
}

class _JoinedMatchesState extends State<JoinedMatches> {
  Future<void> refreshJointMatches() async {
    print('asd');
    final jointMatches = Provider.of<HorseProvider>(context, listen: false);
    jointMatches.getMyJointMatch.clear();
    final res =
        await jointMatches.myJointMatched(jointMatches.getMyMatch[0].contestId);
    if (res['status']) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(res['msg'])));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(res['msg'])));
    }
  }

  Future<void> getJointMatches() async {
    final jointMatches = Provider.of<HorseProvider>(context, listen: false);
    final res =
        await jointMatches.myJointMatched(jointMatches.getMyMatch[0].contestId);
    if (!res['status']) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(res['msg'])));
    }
  }

  Future<void> _raceList(String conId, String matchId) async {
    final jointMatches = Provider.of<HorseProvider>(context, listen: false);
    final res = await jointMatches.getMegaRaceList(conId, matchId);
    if (!res['status']) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(res['msg']),
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(res['msg']),
        behavior: SnackBarBehavior.floating,
      ));
      widget.tabController.animateTo(2, duration: Duration(seconds: 2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshJointMatches,
      child: FutureBuilder(
        future: getJointMatches(),
        builder: (con, snap) => snap.connectionState == ConnectionState.waiting
            ? Center(
                child: CupertinoActivityIndicator(
                radius: 30,
              ))
            : Consumer<HorseProvider>(
                builder: (con, myMatches, _) => myMatches
                        .getMyJointMatch.isEmpty
                    ? Center(
                        child:
                            Text('You have not registered to any match yet!'))
                    : ListView.builder(
                        primary: false,
                        itemCount: myMatches.getMyJointMatch.length,
                        itemBuilder: (con, i) {
                          var items = myMatches.getMyJointMatch[i];
                          return Column(
                            children: <Widget>[
                              buildSizedBox(buildHeight(context), 0.03),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                width: double.infinity,
                                height: buildHeight(context) * 0.28,
                                decoration: boxDecoration.copyWith(
                                    color:
                                        items.status.toLowerCase() == 'active'
                                            ? Colors.white
                                            : Colors.red[200]),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text(
                                          'Track Meet : ${items.matchTitle}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Icon(
                                          FontAwesomeIcons.infoCircle,
                                        )
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    buildSizedBox(buildHeight(context), 0.01),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            buildSizedBoxWidth(
                                                buildWidth(context), 0.05),
                                            CircleAvatar(
                                              maxRadius: 30,
                                              backgroundImage:
                                                  NetworkImage('${items.flag}'),
                                            ),
                                            buildSizedBoxWidth(
                                                buildWidth(context), 0.10),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  '${items.matchDestination}',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                buildSizedBox(
                                                    buildHeight(context), 0.01),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Ends In: ',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    buildSizedBoxWidth(
                                                        buildWidth(context),
                                                        0.01),
                                                    CountdownTimer(
                                                      endTime: int.parse(
                                                          items.startTime),
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
                                                buildSizedBox(
                                                    buildHeight(context), 0.01),
                                                Container(
                                                  // width: double.infinity,
                                                  child: Text(
                                                    'Entry Fee: ${items.pricePerTicket} C',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                if (items.status
                                                        .toLowerCase() ==
                                                    'active') {
                                                  _raceList(items.contestId,
                                                      items.matchId);
                                                }
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                maxRadius: 20,
                                                child: Icon(
                                                  FontAwesomeIcons
                                                      .chevronCircleRight,
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            alignment: Alignment.topRight,
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Icon(Icons.card_membership,
                                                    size: 15,
                                                    color: Theme.of(context)
                                                        .accentColor),
                                                buildSizedBoxWidth(
                                                    buildWidth(context), 0.02),
                                                Text(
                                                  '${items.userJointTickets}/ ${items.userAllowedTickets}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                    Divider(),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: FlatButton(
                                                  onPressed: () {},
                                                  child: Text('LeaderBoard'))),
                                          Expanded(
                                              child: FlatButton(
                                                  onPressed: () {
                                                    if (items.status
                                                            .toLowerCase() ==
                                                        'active') {
                                                      if (items.ifFirstFree ==
                                                          '1') {
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    con) =>
                                                                JoinTicketMegaGrand(
                                                                    title: items
                                                                        .matchDestination,
                                                                    buttonText:
                                                                        'Join',
                                                                    contestId: items
                                                                        .contestId,
                                                                    image: items
                                                                        .flag,
                                                                    limit: int
                                                                        .parse(items
                                                                            .userAllowedTickets),
                                                                    matchId: items
                                                                        .matchId));
                                                      } else {
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext con) => JoinTicketMegaGrand(
                                                                title: items
                                                                    .matchDestination,
                                                                buttonText:
                                                                    'Join with cions',
                                                                contestId: items
                                                                    .contestId,
                                                                image:
                                                                    items.flag,
                                                                limit: int
                                                                    .parse(items
                                                                        .userAllowedTickets),
                                                                matchId: items
                                                                    .matchId));
                                                      }
                                                    }
                                                  },
                                                  child: Text(items.status
                                                              .toLowerCase() ==
                                                          'active'
                                                      ? 'Join More'
                                                      : 'Race Not available'))),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              buildSizedBox(buildHeight(context), 0.01)
                            ],
                          );
                        }),
              ),
      ),
    );
  }
}
