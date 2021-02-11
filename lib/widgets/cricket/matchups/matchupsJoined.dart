import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/models/cricketMatchups.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/matchUps.dart';
import 'package:winx/screens/cricket/matchups/myMatchUps.dart';

class MatchUpJoined extends StatefulWidget {
  MatchUpJoined({Key key}) : super(key: key);

  @override
  _MatchUpJoinedState createState() => _MatchUpJoinedState();
}

class _MatchUpJoinedState extends State<MatchUpJoined> {
  Future<void> getUserMatchups() async {
    final matchups = Provider.of<MatchupsCrickets>(context, listen: false);
    final res = await matchups.getUserMatchups();
    if (!res['status']) {
      showCupertinoPop(res, context);
    } else {
      // showCupertinoPop(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserMatchups(),
      builder: (con, snap) => snap.connectionState == ConnectionState.waiting
          ? Center(
              child: CupertinoActivityIndicator(
                radius: 20,
              ),
            )
          : SingleChildScrollView(
              child: Consumer<MatchupsCrickets>(
              builder: (con, jointed, _) => jointed.joinedMatchups.isEmpty
                  ? Center(
                      child: Text("No Matchups Available"),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: List.generate(
                          jointed.joinedMatchups.length,
                          (index) {
                            var data = jointed.joinedMatchups[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    SlideNavigation(
                                        widget: MyMatchUps(
                                      matchupId: data.matchupId.toString(),
                                    )));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: 20, right: 16, left: 16),
                                // padding: EdgeInsets.only(right: 28, left: 22, top: 19),
                                width: double.infinity,
                                height: 172,
                                decoration: BoxDecoration(
                                    color: AppColors.appdarkGray,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: 28, left: 22, top: 19),
                                      child: Row(
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "#${data.registerId}",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${data.matchupDate}",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              Text(
                                                "${data.matchupStatus}",
                                                style: GoogleFonts.poppins(
                                                    color: AppColors.mainColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Container(
                                            height: 25,
                                            width: 93,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(32)),
                                            child: Text(
                                              "${data.scoreStaus}",
                                              style: GoogleFonts.poppins(
                                                fontSize: 11,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      thickness: 2,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "Invested",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Image.asset(
                                                  "assets/images/coins.png",
                                                  width: 18,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${data.returnPayout}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "Max payout",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Image.asset(
                                                  "assets/images/coins.png",
                                                  width: 18,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${data.betAmount}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "Matchups",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Text(
                                              "${data.matchupCount}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            )),
    );
  }
}
