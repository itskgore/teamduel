import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/cricketStates.dart';
import 'package:winx/providers/matchUps.dart';

import 'matchupsJoined.dart';
import 'matchupsLobby.dart';
import 'matchupsPaymentWidgets.dart';

class CricketMatchups extends StatelessWidget {
  const CricketMatchups({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final states = Provider.of<CricketStates>(context);
    // final states = Provider.of<MatchupsCrickets>(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // MatchUpsPayment(),
          // buildSizedBox(buildHeight(context), 0.03),
          // states.matchupSection == MatchupSections.joinedmatchups
          //     ? MatchUpJoined()
          //     :
          MatchUpLobby()
        ],
      ),
    );
  }
}
