import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/screens/cricket/megaLeague/choosePlayer.dart';
import 'package:winx/screens/cricket/megaLeague/createTeam.dart';

import '../../../navigatorAnimation/bouncinganagivation.dart';

class UpcomingMatches extends StatefulWidget {
  UpcomingMatches({Key key}) : super(key: key);

  @override
  _UpcomingMatchesState createState() => _UpcomingMatchesState();
}

class _UpcomingMatchesState extends State<UpcomingMatches> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (con, i) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 233,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    // padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Match 2$i",
                                    style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: const Color(0xffbb777777)),
                                  ),
                                  Text(
                                    "03h : 12m : 56s",
                                    style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: const Color(0xffbbFF4956)),
                                  ),
                                  Text(
                                    "Playing XI Announced",
                                    style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: AppColors.greenColor),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/coins.png",
                                        width: 40,
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "KXIP",
                                        style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            color: const Color(0xffbb333333)),
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
                                        fontSize: 12,
                                        color: const Color(0xffbb333333)),
                                  ),
                                  SizedBox(
                                    width: 17,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/coins.png",
                                        width: 40,
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "KXIP",
                                        style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            color: const Color(0xffbb333333)),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              jointMatchesprizes("Entry", "100"),
                              jointMatchesprizes("Joined Teams", "25,000"),
                              jointMatchesprizes("Winners", "5,000")
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 2,
                          color: const Color(0xffbbF8F8F8),
                        ),
                        Spacer(),
                        Container(
                          margin:
                              EdgeInsets.only(bottom: 5, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                  child: OutlineButton(
                                child: Text(
                                  "My Teams ($i)",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: AppColors.mainColor),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                onPressed: () {
                                  // Navigator.push(
                                  //     context, FadeNavigation(widget: LeagueInfo()));
                                },
                                borderSide:
                                    BorderSide(color: AppColors.mainColor),
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: RaisedButton(
                                  onPressed: () {
                                    // joinMatches();
                                    Navigator.push(
                                        context,
                                        DownSlideNavigation(
                                            widget: CreateTeam()));
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(80.0)),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(80.0)),
                                    ),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                          minWidth: 88.0,
                                          minHeight:
                                              36.0), // min sizes for Material buttons
                                      alignment: Alignment.center,
                                      child: Text(
                                        'JOIN 1ST TEAM FREE',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
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
                  )
                ],
              ),
            ),
          );
        });
  }
}
