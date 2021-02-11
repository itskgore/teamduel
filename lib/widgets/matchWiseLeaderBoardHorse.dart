import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/screens/matchWiseTicketDetail.dart';

class MatchWiseLeaderBoardHorse extends StatefulWidget {
  MatchWiseLeaderBoardHorse({
    Key key,
  }) : super(key: key);

  @override
  _MatchWiseLeaderBoardHorseState createState() =>
      _MatchWiseLeaderBoardHorseState();
}

class _MatchWiseLeaderBoardHorseState extends State<MatchWiseLeaderBoardHorse> {
  final List<Map<String, String>> listUserType = [
    {
      'name': 'Ticket 1',
      'budget': '15000',
    },
    {
      'name': 'Ticket 2',
      'budget': '15000',
    },
    {
      'name': 'Ticket 3',
      'budget': '15000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          buildSizedBox(buildHeight(context), 0.02),
          Container(
              width: double.infinity,
              alignment: Alignment.topCenter,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        flex: 1,
                        child: DropdownButtonFormField(
                            onChanged: (val) {},
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.movie_creation),
                              hintText: 'Stable 1',
                              filled: true,
                              fillColor: Colors.white,
                              errorStyle: TextStyle(color: Colors.yellow),
                            ),
                            items: listUserType.map((map) {
                              return DropdownMenuItem(
                                child: Text(map['name']),
                                value: map['name'],
                              );
                            }).toList())),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'India- Hyderabad Race\nStatus: Completed',
                          textAlign: TextAlign.center,
                          style: TextStyle(height: 1.5, fontSize: 15),
                        ))
                  ])),
          buildSizedBox(buildHeight(context), 0.02),
          Expanded(
            child: ListView.builder(
                primary: false,
                itemCount: 3,
                itemBuilder: (con, i) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            FadeNavigation(
                                widget: MatchWiseTicketDetail(
                              appbarTitle: 'WinWinX6',
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
