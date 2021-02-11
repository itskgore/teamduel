import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/screens/userAllTicketInfo.dart';

class TotalLeaderBoardTeamScore extends StatefulWidget {
  String appBarTitle;
  TotalLeaderBoardTeamScore({Key key, this.appBarTitle}) : super(key: key);

  @override
  _TotalLeaderBoardTeamScoreState createState() =>
      _TotalLeaderBoardTeamScoreState();
}

class _TotalLeaderBoardTeamScoreState extends State<TotalLeaderBoardTeamScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarHome(context, widget.appBarTitle),
      body: SafeArea(
          child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          primary: false,
          itemCount: 10,
          itemBuilder: (con, i) => GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  FadeNavigation(
                      widget: UserAllTicketInfo(
                    appBarTitle: 'RaceMeet 5 30th June',
                  )));
            },
            child: Container(
              decoration: boxDecoration.copyWith(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 15,
                    backgroundColor: Colors.transparent,
                    child: Text(
                      '$i',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  buildSizedBoxWidth(buildWidth(context), 0.02),
                  Text('30th June'),
                  Spacer(),
                  Text('Ticket_$i'),
                  buildSizedBoxWidth(buildWidth(context), 0.03),
                  Column(
                    children: <Widget>[
                      Text('$i'),
                      buildSizedBox(buildHeight(context), 0.01),
                      Text('Rank'),
                    ],
                  ),
                  buildSizedBoxWidth(buildWidth(context), 0.01),
                  Container(
                    height: buildHeight(context) * 0.05,
                    child: VerticalDivider(
                      color: Colors.black,
                    ),
                  ),
                  buildSizedBoxWidth(buildWidth(context), 0.01),
                  Column(
                    children: <Widget>[
                      Text('${i}12'),
                      buildSizedBox(buildHeight(context), 0.01),
                      Text('PTS'),
                    ],
                  ),
                  buildSizedBoxWidth(buildWidth(context), 0.01),
                  Container(
                    height: buildHeight(context) * 0.05,
                    child: VerticalDivider(
                      color: Colors.black,
                    ),
                  ),
                  buildSizedBoxWidth(buildWidth(context), 0.01),
                  Column(
                    children: <Widget>[
                      Text('${i}22'),
                      buildSizedBox(buildHeight(context), 0.01),
                      Text('PTS'),
                    ],
                  ),
                  buildSizedBoxWidth(buildWidth(context), 0.01),
                  Container(
                    height: buildHeight(context) * 0.05,
                    child: VerticalDivider(
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
