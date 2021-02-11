import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/screens/cricket/megaLeague/captainViceCaptainSelect.dart';
import 'package:winx/widgets/cricket/megaLeague/AR.dart';
import 'package:winx/widgets/cricket/megaLeague/BAT.dart';
import 'package:winx/widgets/cricket/megaLeague/BWL.dart';
import 'package:winx/widgets/cricket/megaLeague/WKT.dart';

import '../../../functions/cricket/megaleagues/widgetFunctions.dart';
import '../../../functions/widgetFunc.dart';
import '../../../functions/widgetFunc.dart';
import '../../../providers/cricketStates.dart';
import '../../../providers/cricketStates.dart';
import '../../../providers/cricketStates.dart';

class SelectPlayer extends StatefulWidget {
  SelectPlayer({Key key}) : super(key: key);

  @override
  _SelectPlayerState createState() => _SelectPlayerState();
}

class _SelectPlayerState extends State<SelectPlayer> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    final players = Provider.of<CricketStates>(context, listen: false);
    players.dummywkt.clear();
    for (int i = 0; i < 4; i++) {
      players.dummywkt.add({"id": i});
    }

    for (int i = 10; i < 17; i++) {
      players.dummybat.add({"id": i});
    }

    for (int i = 20; i < 29; i++) {
      players.dummybwl.add({"id": i});
    }

    for (int i = 30; i < 40; i++) {
      players.dummyar.add({"id": i});
    }
  }

  navigatedToSelectCaptainViceCaptain(bool value) {
    if (value) {
      Navigator.push(
          context, FadeNavigation(widget: SelectCaptainViceCaptain()));
    }
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final states = Provider.of<CricketStates>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        flexibleSpace: appBarGradientContainer(),
        title: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Choose Players",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              Text("IND vs AUS STARTS IN 03H : 12M : 56s",
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w300))
            ],
          ),
        ),
      ),
      body: SafeArea(
        bottom: Theme.of(context).platform == TargetPlatform.iOS ? false : true,
        child: Column(
          children: <Widget>[
            buildSizedBox(buildHeight(context), 0.02),
            Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 50),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffbe3e3e3)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  sections(
                      "WK",
                      states.currentPlaySection == SelectPlayerSections.wk,
                      context,
                      SelectPlayerSections.wk),
                  sections(
                      "BAT",
                      states.currentPlaySection == SelectPlayerSections.bat,
                      context,
                      SelectPlayerSections.bat),
                  sections(
                      "BWL",
                      states.currentPlaySection == SelectPlayerSections.bwl,
                      context,
                      SelectPlayerSections.bwl),
                  sections(
                      "AR",
                      states.currentPlaySection == SelectPlayerSections.ar,
                      context,
                      SelectPlayerSections.ar),
                ],
              ),
            ),
            buildSizedBox(buildHeight(context), 0.02),
            Expanded(
              child: ListView(
                children: <Widget>[
                  states.currentPlaySection == SelectPlayerSections.wk
                      ? WKT()
                      : states.currentPlaySection == SelectPlayerSections.bat
                          ? BAT()
                          : states.currentPlaySection ==
                                  SelectPlayerSections.bwl
                              ? BWL()
                              : AR(),
                ],
              ),
            ),
            Consumer<CricketStates>(
              builder: (con, player, _) => Container(
                height: 98,
                width: double.infinity,
                padding: EdgeInsets.only(left: 22, top: 18, right: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 6.0,
                        offset: Offset(10.0, 0.0))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "100 CR",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                              child: VerticalDivider(
                                color: const Color(0xffbb7777774D),
                              ),
                            ),
                            Text("${player.totalPlayers}/11",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold, fontSize: 15))
                          ],
                        ),
                        Text("Ind 3 | Aus 4",
                            style: GoogleFonts.poppins(
                                color: const Color(0xffbb333333),
                                fontWeight: FontWeight.bold,
                                fontSize: 12))
                      ],
                    ),
                    Container(
                      height: 48,
                      width: 150,
                      child: RaisedButton(
                        onPressed: () {
                          if (player.currentPlaySection ==
                              SelectPlayerSections.wk) {
                            if (player.wkt.length == 1) {
                              player
                                  .changeSelectPlayer(SelectPlayerSections.bat);
                              return;
                            }
                            navigatedToSelectCaptainViceCaptain(
                                player.totalAllowed == player.totalPlayers);
                            return;
                          }
                          if (player.currentPlaySection ==
                              SelectPlayerSections.bat) {
                            if (player.bat.length >= 3 &&
                                player.bat.length <= 5) {
                              player
                                  .changeSelectPlayer(SelectPlayerSections.bwl);
                              return;
                            }

                            navigatedToSelectCaptainViceCaptain(
                                player.totalAllowed == player.totalPlayers);

                            return;
                          }
                          if (player.currentPlaySection ==
                              SelectPlayerSections.bwl) {
                            if (player.bwl.length >= 3 &&
                                player.bwl.length <= 5) {
                              player
                                  .changeSelectPlayer(SelectPlayerSections.ar);
                              return;
                            }
                            navigatedToSelectCaptainViceCaptain(
                                player.totalAllowed == player.totalPlayers);
                            return;
                          }
                          if (player.currentPlaySection ==
                              SelectPlayerSections.ar) {
                            if (player.ar.length >= 3 &&
                                player.ar.length <= 5) {
                              // player
                              //     .changeSelectPlayer(SelectPlayerSections.ar);
                              // Navigate to captain vice captain..
                              Navigator.push(
                                  context,
                                  FadeNavigation(
                                      widget: SelectCaptainViceCaptain()));
                              return;
                            }
                            navigatedToSelectCaptainViceCaptain(
                                player.totalAllowed == player.totalPlayers);
                            return;
                          }
                        },
                        color: player.checkNext(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Text(
                          "NEXT",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget sections(String title, bool isActive, BuildContext context,
      SelectPlayerSections data) {
    return Consumer<CricketStates>(
      builder: (context, state, _) => Expanded(
        child: GestureDetector(
          onTap: () {
            state.changeSelectPlayer(data);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeIn,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                color: isActive ? Colors.white : const Color(0xffbe3e3e3),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              "$title",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: isActive ? AppColors.mainColor : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
