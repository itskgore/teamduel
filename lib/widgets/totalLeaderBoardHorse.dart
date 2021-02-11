import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/screens/totalLeaderBoardTeamScore.dart';

class TotalLeaderBoardHorse extends StatelessWidget {
  const TotalLeaderBoardHorse({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: <Widget>[
          buildSizedBox(buildHeight(context), 0.02),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: boxDecoration.copyWith(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Team Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rank',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Score',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Upcoming Score',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                primary: false,
                itemCount: 3,
                itemBuilder: (con, i) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            FadeNavigation(
                                widget: TotalLeaderBoardTeamScore(
                              appBarTitle: 'WinWinX6',
                            )));
                      },
                      child: Container(
                        decoration: boxDecoration.copyWith(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        width: double.infinity,
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              maxRadius: 15,
                              backgroundColor: Colors.blue[200],
                            ),
                            buildSizedBoxWidth(buildWidth(context), 0.02),
                            Column(
                              children: <Widget>[
                                Text('winwinx6'),
                                buildSizedBox(buildHeight(context), 0.02),
                                Text('Sriniwas K'),
                              ],
                            ),
                            Spacer(),
                            Icon(
                              FontAwesomeIcons.chevronCircleDown,
                              color: Colors.red,
                              size: 18,
                            ),
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
                    )),
          )
        ],
      ),
    );
  }
}
