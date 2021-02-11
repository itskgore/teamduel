import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winx/config/colors.dart';

class MyPlayerInfo extends StatefulWidget {
  MyPlayerInfo({Key key}) : super(key: key);

  @override
  _MyPlayerInfoState createState() => _MyPlayerInfoState();
}

class _MyPlayerInfoState extends State<MyPlayerInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Player Info",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              Text("IND vs AUS  03H : 12M : 56s",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300)),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                color: Colors.white,
                height: 96,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset("assets/images/dhoni.png"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "MS Dhoni",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text("184 PTS",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w300)),
                      ],
                    )
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                titleContainer("Batting"),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  // height: 207,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      rowcontent("Runs Scored (54)", "54 PTS"),
                      divider(),
                      rowcontent("Boundaries (3)", "3 PTS"),
                      divider(),
                      rowcontent("Over-Boundaries (1 x 2)", "2 PTS"),
                      divider(),
                      rowcontent("Total Batting", "59 PTS", true),
                      // divider(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                titleContainer("Bowling"),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  // height: 207,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      rowcontent("Wickets (2 x 10)", "24 PTS"),
                      divider(),
                      rowcontent("Economy Score (3)", "3 PTS"),
                      divider(),
                      rowcontent("Economy Score (1)", "2 PTS"),
                      divider(),
                      rowcontent("Total Bowling", "25 PTS", true),
                      // divider(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                titleContainer("Fielding"),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  // height: 207,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      rowcontent("Catches (1 x 10)", "20 PTS"),
                      divider(),
                      rowcontent("Run Out (1 x 10)", "10 PTS"),

                      divider(),
                      rowcontent("Total Fielding", "30 PTS", true),
                      // divider(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                titleContainer("Bonus"),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  // height: 207,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      rowcontent("Part of Playing XI", "5 PTS"),
                      divider(),
                      rowcontent("Part of Winning Teaming", "15 PTS"),
                      divider(),
                      rowcontent("Player of the Match", "50 PTS"),
                      divider(),
                      rowcontent("Total Bonus", "70 PTS", true),
                      // divider(),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }

  Container titleContainer(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text("$title",
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
    );
  }

  Column divider() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Divider(
          color: AppColors.textGrayColor,
          // indent: 10,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Row rowcontent(String text1, String text2, [bool isLast]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "$text1",
          style: GoogleFonts.poppins(
              color: AppColors.textGrayColor,
              fontSize: 14,
              fontWeight: isLast != null ? FontWeight.w600 : FontWeight.normal),
        ),
        Text(
          "$text2",
          style: GoogleFonts.poppins(
              color: AppColors.textGrayColor,
              fontSize: 14,
              fontWeight: isLast != null ? FontWeight.w600 : FontWeight.normal),
        ),
      ],
    );
  }
}
