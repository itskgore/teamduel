import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/stateMangedHorseMegaLeague.dart';
import 'package:winx/widgets/raceList.dart';
import 'package:winx/widgets/raceMeetsMatches.dart';

import '../widgets/joinedMatchesHorse.dart';

class RaceMeets extends StatefulWidget {
  RaceMeets({Key key}) : super(key: key);

  @override
  _RaceMeetsState createState() => _RaceMeetsState();
}

class _RaceMeetsState extends State<RaceMeets> with TickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mega League Races'),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, buildHeight(context) * 0.08),
          child: Container(
            color: Colors.white,
            child: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Matches",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Tab(
                  child: Text(
                    "Joined Matches",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Tab(
                  child: Text(
                    "Race List",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              controller: tabController,
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: TabBarView(
        controller: tabController,
        children: <Widget>[
          Matches(),
          JoinedMatches(tabController),
          RaceList(),
        ],
      )),
    );
  }
}
