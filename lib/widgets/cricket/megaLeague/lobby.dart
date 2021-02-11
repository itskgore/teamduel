import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/cricketStates.dart';
import 'package:winx/screens/cricket/megaLeague/leagueInfo.dart';

class Lobby extends StatefulWidget {
  const Lobby({
    Key key,
  }) : super(key: key);

  @override
  _LobbyState createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  Future<void> joinMatches() async {
    final states = Provider.of<CricketStates>(context, listen: false);

    states.changeSection(Sections.joined);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (con, i) => Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            i == 1
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 73, 86, 1),
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/rcb.png",
                                  width: 60,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 17,
                            ),
                            Text(
                              "VS",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xffbb333333)),
                            ),
                            SizedBox(
                              width: 17,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/rcb.png",
                                  width: 60,
                                ),
                              ],
                            ),
                          ],
                        ),
                        RaisedButton(
                          color: Colors.white,
                          child: Text(
                            "PLAY NOW",
                            style: GoogleFonts.poppins(
                                fontSize: 11, color: AppColors.mainColor),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          onPressed: () {},
                        )
                      ],
                    ),
                  )
                : Container(
                    height: 0,
                  ),
            i == 4 - 1
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: double.infinity,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 80,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                          height: 72,
                                          width: 72,
                                          child: Image.asset(
                                            "assets/images/rcb.png",
                                            fit: BoxFit.contain,
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Refer a friend & EARN",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "50 coins",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(
                                                      0xffbbFF4956)),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                          height: 38,
                                          width: 38,
                                          child: Image.asset(
                                            "assets/images/coins.png",
                                            fit: BoxFit.contain,
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "EARN MORE COINS",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  )
                : Container(),
            Container(
              height: 230,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 19,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: firstRow("assets/images/punj.png", "IPL SPL League",
                        "24th Jul - 30th Jul", "5D : 12H : 55M : 26S", "27"),
                  ),
                  Divider(
                    thickness: 3,
                    color: AppColors.backgroundColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      prizeRow("10,000", "Cash Prize"),
                      prizeRow("10,000", "First Prize"),
                      prizeRow("250", "Winners")
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                            child: OutlineButton(
                          child: Text(
                            "League Info",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: AppColors.mainColor),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () {
                            Navigator.push(
                                context, FadeNavigation(widget: LeagueInfo()));
                          },
                          borderSide: BorderSide(color: AppColors.mainColor),
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: RaisedButton(
                            onPressed: () {
                              joinMatches();
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80.0)),
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                    minWidth: 88.0,
                                    minHeight:
                                        36.0), // min sizes for Material buttons
                                alignment: Alignment.center,
                                child: Text(
                                  'JOIN FREE',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
