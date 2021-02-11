import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/functions/widgetFunc.dart';

class MatchesLeagueInfo extends StatelessWidget {
  const MatchesLeagueInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildSizedBox(buildHeight(context), 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "12 Matches left",
                  style: GoogleFonts.poppins(fontSize: 12),
                ),
                Text(
                  "28 Matches",
                  style: GoogleFonts.poppins(
                      fontSize: 10, color: const Color(0xffbb777777)),
                )
              ],
            ),
            buildSizedBox(buildHeight(context), 0.01),
            LinearPercentIndicator(
              // width: double.infinity,
              animation: true,
              lineHeight: 8.0,
              animationDuration: 2000,
              percent: 0.9,
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: AppColors.mainColor,
            ),
            buildSizedBox(buildHeight(context), 0.05),
            Text(
              "Live",
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                  color: const Color(0xffbb777777), fontSize: 12),
            ),
            buildSizedBox(buildHeight(context), 0.02),
            matchesBox(
                imageurl1: "assets/images/rcb.png",
                imageurl2: "assets/images/rcb.png",
                live: "LIVE",
                matchNo: "22",
                team1: "KXIP",
                team2: "RCB"),
            buildSizedBox(buildHeight(context), 0.05),
            Text(
              "Upcoming",
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(color: const Color(0xffbb777777)),
            ),
            buildSizedBox(buildHeight(context), 0.02),
            Column(
                children: List.generate(5, (index) {
              return matchesBox(
                  imageurl1: "assets/images/coins.png",
                  imageurl2: "assets/images/coins.png",
                  live: "03h : 12m : 56s",
                  matchNo: "22",
                  team1: "KXIP",
                  team2: "RCB");
            }))
          ],
        ),
      ),
    );
  }
}
