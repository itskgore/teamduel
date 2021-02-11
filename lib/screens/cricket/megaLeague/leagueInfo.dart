import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/widgets/cricket/megaLeague/matches.dart';
import 'package:winx/widgets/cricket/megaLeague/prizePool.dart';
import 'package:winx/widgets/cricket/megaLeague/rules.dart';

class LeagueInfo extends StatefulWidget {
  LeagueInfo({Key key}) : super(key: key);

  @override
  _LeagueInfoState createState() => _LeagueInfoState();
}

class _LeagueInfoState extends State<LeagueInfo> with TickerProviderStateMixin {
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
        title: appbarTitle("League Info"),
        flexibleSpace: appBarGradientContainer(),
        bottom: TabBar(
          unselectedLabelColor: Colors.white54,
          labelColor: Colors.white,
          tabs: [
            Tab(
                child: Text(
              "Prize Pool",
              style: GoogleFonts.poppins(),
            )),
            Tab(
              child: Text(
                "Matches",
                style: GoogleFonts.poppins(),
              ),
            ),
            Tab(
              child: Text(
                "Rules",
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
          indicatorColor: Colors.white,
          controller: tabController,
        ),
      ),
      body: SafeArea(
          child: TabBarView(
        controller: tabController,
        children: [PrizePool(), MatchesLeagueInfo(), RulesMegaLeague()],
      )),
    );
  }
}
