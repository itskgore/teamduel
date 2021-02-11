import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/widgets/cricket/megaLeague/jointMatches.dart';
import 'package:winx/widgets/cricket/megaLeague/myContestCompleted.dart';
import 'package:winx/widgets/cricket/megaLeague/upcomingMatches.dart';

class MegaLeagueMatches extends StatefulWidget {
  MegaLeagueMatches({Key key}) : super(key: key);

  @override
  _MegaLeagueMatchesState createState() => _MegaLeagueMatchesState();
}

class _MegaLeagueMatchesState extends State<MegaLeagueMatches>
    with TickerProviderStateMixin {
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
        flexibleSpace: appBarGradientContainer(),
        title: appbarTitle("Mega League"),
        bottom: TabBar(
          unselectedLabelColor: Colors.white54,
          labelColor: Colors.white,
          tabs: [
            Tab(
                child: Text(
              "Upcoming",
              style: GoogleFonts.poppins(),
            )),
            Tab(
              child: Text(
                "Joined",
                style: GoogleFonts.poppins(),
              ),
            ),
            Tab(
              child: Text(
                "Completed",
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
          indicatorColor: Colors.white,
          controller: tabController,
        ),
      ),
      body: SafeArea(
          child: TabBarView(controller: tabController, children: [
        UpcomingMatches(),
        JointMatchesMegaLeagueScreen(),
        MyContestCompleted()
      ])),
    );
  }
}
