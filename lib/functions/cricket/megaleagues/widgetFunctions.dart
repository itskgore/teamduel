import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/cricketStates.dart';
import 'package:winx/screens/cricket/matchups/matchUpsHome.dart';
import 'package:winx/screens/homeScreen.dart';
import 'package:winx/widgets/cricket/matchups/matchupsPaymentWidgets.dart';

Column prizeRow(String amt, String title) {
  return Column(
    children: <Widget>[
      Text(
        "$title",
        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
      ),
      Row(
        children: <Widget>[
          title != "Winners"
              ? Image.asset(
                  "assets/images/coins.png",
                  width: 15,
                )
              : Container(),
          SizedBox(
            width: 5,
          ),
          Text(
            "$amt",
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.black),
          )
        ],
      )
    ],
  );
}

Row firstRow(
    String image, String title, String date, String timmer, String matches) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(right: 10),
        child: Image.asset(
          image,
          width: 38,
          fit: BoxFit.cover,
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "$title",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              "$date",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
            ),
            Row(
              children: <Widget>[
                Text(
                  "Ends in",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey),
                ),
                Expanded(
                  child: Text(
                    "  $timmer",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: AppColors.mainColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Column(
        children: <Widget>[
          Container(
            width: 81,
            height: 25,
            alignment: Alignment.center,
            // padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffbffebf9),
            ),
            child: Text(
              "$matches Matches",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 10, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 22,
                height: 22,
                child: Text(
                  "C",
                  style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey)),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                alignment: Alignment.center,
                width: 22,
                height: 22,
                child: Text(
                  "S",
                  style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey)),
              ),
            ],
          )
        ],
      )
    ],
  );
}

void showAlertDialogNoFilter(BuildContext context, [String text]) {
  showDialog(
      context: context,
      child: CupertinoAlertDialog(
        title: Text(text.isEmpty ? "No Filter Avaible!" : text),
      ));
}

Text appbarTitle(String title) {
  return Text("$title", style: GoogleFonts.poppins(color: Colors.white));
}

Container appBarGradientContainer() {
  return Container(
    decoration: BoxDecoration(color: AppColors.mainColor),
  );
}

Container thirdRow(String rank, String teams, String pts) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    alignment: Alignment.center,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "#$rank",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        SizedBox(
          width: 2,
        ),
        Icon(
          Icons.arrow_upward,
          color: const Color(
            0xffbb00E209,
          ),
          size: 13,
        ),
        SizedBox(
          width: 34,
        ),
        Text(
          "Team $teams",
          style: GoogleFonts.poppins(fontSize: 12),
        ),
        Spacer(),
        Text(
          "$pts pts",
          style: GoogleFonts.poppins(
              fontSize: 12, color: const Color(0xffbb777777)),
        ),
      ],
    ),
  );
}

Widget matchesBox(
    {String matchNo,
    String live,
    String imageurl1,
    String team1,
    String imageurl2,
    String team2}) {
  return Card(
    elevation: 2,
    margin: EdgeInsets.only(bottom: 13),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Container(
      width: double.infinity,
      height: 98,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Match $matchNo",
                style: GoogleFonts.poppins(
                    color: const Color(0xffbb777777), fontSize: 11),
              ),
              Text(
                "$live",
                style: GoogleFonts.poppins(
                    color: const Color(0xffbbFF4956), fontSize: 11),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "$imageurl1",
                    width: 44,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "$team1",
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: const Color(0xffbb333333)),
                  )
                ],
              ),
              SizedBox(
                width: 17,
              ),
              Text(
                "VS",
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    fontSize: 12, color: const Color(0xffbb333333)),
              ),
              SizedBox(
                width: 17,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "$imageurl2",
                    width: 44,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "$team2",
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: const Color(0xffbb333333)),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Column jointMatchesprizes(String title, String amt) {
  return Column(
    children: <Widget>[
      Text(
        "$title",
        style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey),
      ),
      Row(
        children: <Widget>[
          Image.asset(
            "assets/images/coins.png",
            width: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "$amt",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),
          )
        ],
      )
    ],
  );
}

showDialogBox(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 250,
            width: 300,
            // margin: EdgeInsets.symmetric(horizontal: 24, vertical: 21),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, FadeNavigation(widget: HomeScreen()));
                    },
                    child: Card(
                      elevation: 2,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 21),
                        width: double.infinity,
                        height: 64,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/images/coins.png",
                              width: 24,
                            ),
                            SizedBox(
                              width: 17,
                            ),
                            Text(
                              "Mega Leagues",
                              style: GoogleFonts.poppins(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, FadeNavigation(widget: MatchUpHome()));
                    },
                    child: Card(
                      elevation: 2,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 21),
                        width: double.infinity,
                        height: 64,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/images/coins.png",
                              width: 24,
                            ),
                            SizedBox(
                              width: 17,
                            ),
                            Text(
                              "MatchUps",
                              style: GoogleFonts.poppins(),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}

showDialogSubmitDialog(BuildContext context, Function sub) {
  // final states = Provider.of<CricketStates>(context, listen: false);

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Consumer<CricketStates>(
            builder: (context, states, _) => Container(
              height: buildHeight(context) * 0.55,
              width: buildWidth(context) * 0.90,
              // margin: EdgeInsets.symmetric(horizontal: 24, vertical: 21),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Available balance",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$100",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          color: AppColors.gradientColor2),
                    ),
                    buildSizedBox(buildHeight(context), 0.02),
                    Text(
                      "Total matchups selected: ${states.cricketMatchups.toList().length + states.horseMatchups.toList().length}",
                      style: GoogleFonts.poppins(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    buildSizedBox(buildHeight(context), 0.04),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          "Invest",
                          style: GoogleFonts.poppins(),
                          textAlign: TextAlign.center,
                        )),
                        Expanded(
                            child: Text(
                          "Payout type",
                          style: GoogleFonts.poppins(),
                          textAlign: TextAlign.center,
                        )),
                      ],
                    ),
                    buildSizedBox(buildHeight(context), 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                // Text(
                                //   "I bet",
                                //   style: GoogleFonts.poppins(fontSize: 12),
                                // ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.backgroundColor,
                                  ),
                                  alignment: Alignment.center,
                                  child: RaisedButton(
                                    color: AppColors.backgroundColor,
                                    onPressed: () {
                                      states.increDecreInvest(false);
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "-",
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(color: AppColors.mainColor),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Image.asset(
                                  "assets/images/coins.png",
                                  width: 14,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("${states.invest}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.backgroundColor,
                                  ),
                                  alignment: Alignment.center,
                                  child: RaisedButton(
                                    color: AppColors.backgroundColor,
                                    onPressed: () {
                                      states.increDecreInvest(true);
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "+",
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(color: AppColors.mainColor),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                states.changeInvestType();
                              },
                              child: Card(
                                elevation: 2,
                                child: Container(
                                  width: 100,
                                  height: 34,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/coins.png",
                                        width: 15,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        states.investType == InvestType.coins
                                            ? "Coins"
                                            : "Chips",
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Image.asset(
                                        "assets/images/refresh.png",
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    buildSizedBox(buildHeight(context), 0.03),
                    Text(
                      "Payout possible: 0",
                      style: GoogleFonts.poppins(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    buildSizedBox(buildHeight(context), 0.02),
                    RaisedButton(
                      color: AppColors.mainColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        // _modalBottomSheetMenu(context);
                        // submitMatchups();
                        // showDialogSubmitDialog(context);
                        sub();
                        Navigator.of(context).pop();
                      },
                      child: Text("Pay \$100",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white,
                          )),
                    ),
                    // buildSizedBox(buildHeight(context), 0.03),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        // _modalBottomSheetMenu(context);
                        // submitMatchups();
                        // showDialogSubmitDialog(context);
                      },
                      child: Text("Clear Matchups",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.black,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

class MatchUp extends StatelessWidget {
  final String playerName;
  final String jersey;
  final String teamName;
  final String playerRole;
  final bool star;
  final isLeft;
  const MatchUp(
      {Key key,
      this.playerName,
      this.jersey,
      this.teamName,
      this.playerRole,
      this.star,
      this.isLeft})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
          width: 150,
          height: 80,
          padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: jersey != "null"
                        ? Image.network(
                            "$jersey",
                            width: 20,
                          )
                        : isLeft
                            ? Image.asset(
                                "assets/images/playerPlaceholderLeft.jpeg",
                                width: 20,
                              )
                            : Image.asset(
                                "assets/images/playerPlaceholderRight.jpeg",
                                width: 20,
                              ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "$playerName",
                                  maxLines: 2,
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              star
                                  ? Image.asset(
                                      "assets/images/star.png",
                                      width: 10,
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              // Row(
              //   children: <Widget>[
              //     Text(
              //       "IND vs AUS",
              //       style: GoogleFonts.poppins(
              //         fontSize: 10,
              //       ),
              //     ),
              //     Spacer(),
              //     Text(
              //       "03h : 12m : 56s",
              //       style: GoogleFonts.poppins(
              //           fontSize: 10, color: AppColors.mainColor),
              //     ),
              //   ],
              // )
              Row(
                children: <Widget>[
                  Text(
                    "${teamName} | ",
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "$playerRole",
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

class HorseMatchUp extends StatelessWidget {
  String horseNo;
  String horseName;
  String jockey;
  String trainer;
  bool star;
  bool isRight;
  HorseMatchUp(
      {Key key,
      this.horseName,
      this.horseNo,
      this.jockey,
      this.star,
      this.isRight,
      this.trainer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.mainColorLight,
      elevation: 2,
      child: Container(
          width: 150,
          height: 90,
          padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isRight ? Colors.white : Colors.red,
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "$horseNo",
                        style: GoogleFonts.poppins(
                            color: isRight ? Colors.black : Colors.white,
                            fontSize: 12),
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: 150 / 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "$horseName",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            star
                                ? Image.asset(
                                    "assets/images/star.png",
                                    width: 10,
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "T : $trainer",
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Spacer(),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  "J : $jockey",
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
