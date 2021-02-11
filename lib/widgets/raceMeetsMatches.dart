import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/horse.dart';
import 'package:winx/providers/stateMangedHorseMegaLeague.dart';
import 'package:winx/widgets/joinTicketDialog.dart';

class Matches extends StatefulWidget {
  const Matches({
    Key key,
  }) : super(key: key);

  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildSizedBox(buildHeight(context), 0.02),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 20),
          child: Text(
            'Upcoming Races:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        buildSizedBox(buildHeight(context), 0.04),
        Consumer<HorseProvider>(
          builder: (con, myMatches, _) => myMatches.getMyMatch.isEmpty
              ? Center(
                  child: Text('No Matches available come back later!'),
                )
              : Expanded(
                  child: ListView.builder(
                      primary: false,
                      itemCount: myMatches.getMyMatch.length,
                      itemBuilder: (con, i) {
                        var items = myMatches.myMatches[i];
                        return Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              width: double.infinity,
                              height: buildHeight(context) * 0.28,
                              decoration: boxDecoration.copyWith(
                                  color: items.status.toLowerCase() == 'active'
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
                                                        items.seconds),
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
                                                '${items.userJoinedTicket}/ ${items.userAllowedTicket}',
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
                                                    if (items.isFirstFree ==
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
                                                                          .userAllowedTicket),
                                                                  matchId: items
                                                                      .matchesId));
                                                    } else {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  con) =>
                                                              JoinTicketMegaGrand(
                                                                  title: items
                                                                      .matchDestination,
                                                                  buttonText:
                                                                      'Join with cions',
                                                                  contestId: items
                                                                      .contestId,
                                                                  image: items
                                                                      .flag,
                                                                  limit: int
                                                                      .parse(items
                                                                          .userAllowedTicket),
                                                                  matchId: items
                                                                      .matchesId));
                                                    }
                                                  }
                                                },
                                                child: Text(
                                                    items.isFirstFree == '1'
                                                        ? 'Join 1st Ticket Free'
                                                        : 'Join More'))),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            buildSizedBox(buildHeight(context), 0.03)
                          ],
                        );
                      }),
                ),
        ),
      ],
    );
  }
}
