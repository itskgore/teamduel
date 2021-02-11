import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';

import 'choosePlayer.dart';

class CreateTeam extends StatelessWidget {
  const CreateTeam({Key key}) : super(key: key);

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
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "You have not created any team yet",
              style: GoogleFonts.poppins(
                  fontSize: 14, color: const Color(0xffbb808080)),
            ),
            SizedBox(
              height: 41,
            ),
            Container(
              width: 268,
              height: 48,
              child: RaisedButton(
                onPressed: () {
                  // joinMatches();
                  Navigator.push(
                      context, DownSlideNavigation(widget: SelectPlayer()));
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
          ],
        ),
      )),
    );
  }
}
