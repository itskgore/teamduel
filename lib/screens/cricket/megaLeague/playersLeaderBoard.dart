import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/functions/widgetFunc.dart';

class PlayersLeaderBoard extends StatefulWidget {
  PlayersLeaderBoard({Key key}) : super(key: key);

  @override
  _PlayersLeaderBoardState createState() => _PlayersLeaderBoardState();
}

class _PlayersLeaderBoardState extends State<PlayersLeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: appBarGradientContainer(),
        title: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "IND vs AUS",
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              Text("STARTS IN 03H : 12M : 56s",
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w300))
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              buildSizedBox(buildHeight(context), 0.02),
              Text(
                "Choose Captain, Vice-Captain & Player of the Match",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: const Color(0xffbb808080),
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Captain will get 2x points, Vice-Captain will get 1.5x points & Player of the Match will get 50 points bonus",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: GoogleFonts.poppins(
                    color: const Color(0xffbb808080),
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Wicket Keeper",
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                      color: const Color(0xffbb323232),
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                  children: List.generate(1, (index) {
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    height: 78,
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 38,
                          alignment: Alignment.center,
                          height: 38,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: ExactAssetImage(
                                      "assets/images/coins.png"))),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "MS Dhoni",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xffbb323232),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "KXIP",
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xffbb808080),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Spacer(),
                        circleBoxCaptionShip("C", "10"),
                        SizedBox(
                          width: 10,
                        ),
                        circleBoxCaptionShip("VC", "16"),
                        SizedBox(
                          width: 10,
                        ),
                        circleBoxCaptionShip("C", "10", true),
                      ],
                    ),
                  ),
                );
              })),
              SizedBox(
                height: 19,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Batsmen",
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                      color: const Color(0xffbb323232),
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                  children: List.generate(4, (index) {
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    height: 78,
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 38,
                          alignment: Alignment.center,
                          height: 38,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: ExactAssetImage(
                                      "assets/images/coins.png"))),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "MS Dhoni",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xffbb323232),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "KXIP",
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xffbb808080),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Spacer(),
                        circleBoxCaptionShip("C", "10"),
                        SizedBox(
                          width: 10,
                        ),
                        circleBoxCaptionShip("VC", "16"),
                        SizedBox(
                          width: 10,
                        ),
                        circleBoxCaptionShip("C", "10", true),
                      ],
                    ),
                  ),
                );
              })),
              SizedBox(
                height: 19,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Bowler",
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                      color: const Color(0xffbb323232),
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                  children: List.generate(8, (index) {
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    height: 78,
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 38,
                          alignment: Alignment.center,
                          height: 38,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: ExactAssetImage(
                                      "assets/images/coins.png"))),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "MS Dhoni",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xffbb323232),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "KXIP",
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xffbb808080),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Spacer(),
                        circleBoxCaptionShip("C", "10"),
                        SizedBox(
                          width: 10,
                        ),
                        circleBoxCaptionShip("VC", "16"),
                        SizedBox(
                          width: 10,
                        ),
                        circleBoxCaptionShip("C", "10", true),
                      ],
                    ),
                  ),
                );
              }))
            ],
          ),
        ),
      )),
    );
  }

  Column circleBoxCaptionShip(String posi, String per, [bool start]) {
    return Column(
      children: <Widget>[
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xffbbE2E2E2),
            shape: BoxShape.circle,
          ),
          child: start == null
              ? Text(
                  "$posi",
                  style: GoogleFonts.poppins(fontSize: 11, color: Colors.white),
                )
              : Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 15,
                ),
        ),
        Text(
          "$per%",
          style: GoogleFonts.poppins(
              fontSize: 10, color: const Color(0xffbb808080)),
        ),
      ],
    );
  }
}
