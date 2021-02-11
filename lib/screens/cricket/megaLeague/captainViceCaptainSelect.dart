import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/cricketStates.dart';
import 'package:winx/screens/cricket/megaLeague/teams.dart';

class SelectCaptainViceCaptain extends StatefulWidget {
  SelectCaptainViceCaptain({Key key}) : super(key: key);

  @override
  _SelectCaptainViceCaptainState createState() =>
      _SelectCaptainViceCaptainState();
}

class _SelectCaptainViceCaptainState extends State<SelectCaptainViceCaptain> {
  @override
  Widget build(BuildContext context) {
    final players = Provider.of<CricketStates>(context);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: appBarGradientContainer(),
        title: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Player Roles",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              Text("IND vs AUS 03H : 12M : 56s",
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w300))
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 98,
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Container(
                height: 48,
                child: OutlineButton(
                    child: Text(
                      "Preview",
                      style: GoogleFonts.poppins(
                          color: const Color(0xffbbFF4956),
                          fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    borderSide: BorderSide(color: const Color(0xffbbFF4956)),
                    onPressed: () {}),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 48,
                child: RaisedButton(
                  onPressed: () {
                    // joinMatches();
                    Navigator.push(
                        context, DownSlideNavigation(widget: Teams()));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: <Color>[
                            Color.fromRGBO(254, 134, 100, 1),
                            Color.fromRGBO(255, 73, 86, 1)
                          ]),
                      borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    ),
                    child: Container(
                      constraints: const BoxConstraints(
                          minWidth: 88.0,
                          minHeight: 36.0), // min sizes for Material buttons
                      alignment: Alignment.center,
                      child: Text(
                        'Create Team',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
          bottom: false,
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
                    String id = "07";
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
                            circleBoxCaptionShip("C", "10", id),
                            SizedBox(
                              width: 10,
                            ),
                            circleBoxCaptionShip("VC", "16", id),
                            SizedBox(
                              width: 10,
                            ),
                            circleBoxCaptionShip("manOfMatch", "10", id, true),
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
                    String id = "${index + 1 * 11}";
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
                            circleBoxCaptionShip("C", "10", id),
                            SizedBox(
                              width: 10,
                            ),
                            circleBoxCaptionShip("VC", "16", id),
                            SizedBox(
                              width: 10,
                            ),
                            circleBoxCaptionShip("manOfMatch", "10", id, true),
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
                    String id = "${index * 5}";

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
                            circleBoxCaptionShip("C", "10", id),
                            SizedBox(
                              width: 10,
                            ),
                            circleBoxCaptionShip("VC", "16", id),
                            SizedBox(
                              width: 10,
                            ),
                            circleBoxCaptionShip("manOfMatch", "10", id, true),
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

  Column circleBoxCaptionShip(String posi, String per, String id,
      [bool start]) {
    final players = Provider.of<CricketStates>(context);

    setCap(String id) {
      if (posi == "C") {
        players.setCaptain(id);
      } else if (posi == "VC") {
        players.setViceCaptain(id);
      } else {
        players.setManOfTheMatch(id);
      }
    }

    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setCap(id);
          },
          child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: players.positionColor(posi, id),
                shape: BoxShape.circle,
              ),
              child: Text(
                players.getCapText(posi, id),
                style: GoogleFonts.poppins(
                    fontSize: posi == "manOfMatch" ? 8 : 11,
                    color: Colors.white),
              )),
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
