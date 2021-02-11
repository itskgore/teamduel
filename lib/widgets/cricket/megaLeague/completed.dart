import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/screens/cricket/megaLeague/leagueInfo.dart';

class Completed extends StatelessWidget {
  const Completed({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 248,
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
            child: firstRow("assets/images/coins.png", "IPL SPL League",
                "24th Jul - 30th Jul", "5D : 12H : 55M : 26S", "27"),
          ),
          Divider(
            thickness: 3,
            color: AppColors.backgroundColor,
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
                        fontSize: 14, color: AppColors.mainColor),
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
                    onPressed: () {},
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
                          'VIEW WINNERS',
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
          Divider(
            thickness: 3,
            color: AppColors.backgroundColor,
          ),
          thirdRow("28", "1", "282.5"),
          Spacer(),
          Container(
            width: double.infinity,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    const Color(0xffbFE8664),
                    AppColors.mainColor
                  ]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "You won",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  "assets/images/coins.png",
                  width: 11,
                ),
                SizedBox(
                  width: 4,
                ),
                Text("2000",
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
