import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/functions/widgetFunc.dart';

class Teams extends StatefulWidget {
  Teams({Key key}) : super(key: key);

  @override
  _TeamsState createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: appBarGradientContainer(),
        title: Container(
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
          child: ListView.builder(
              itemCount: 2,
              itemBuilder: (con, i) {
                return Column(
                  children: <Widget>[
                    buildSizedBox(buildHeight(context), 0.02),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 196,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xffbbFE8664),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Team 1",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spacer(),
                                Text(
                                  "Ind (7)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Aus (4)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                captionshipBox("V Kholi", "VC"),
                                captionshipBox("V Kholi", "VC"),
                                captionshipBox("V Kholi", "VC")
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.grey[200],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "WK (1)",
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey, fontSize: 13),
                                ),
                                Text(
                                  "BAT (5)",
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey, fontSize: 13),
                                ),
                                Text(
                                  "BWL (3)",
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey, fontSize: 13),
                                ),
                                Text(
                                  "AR (2)",
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.grey[200],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  "PREVIEW",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xffbbFF4956),
                                      fontSize: 13),
                                ),
                                Text(
                                  "EDIT",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xffbbFF4956),
                                      fontSize: 13),
                                ),
                                Text(
                                  "CLONE",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xffbbFF4956),
                                      fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              })),
    );
  }

  Stack captionshipBox(String name, String posi) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          width: 73,
          height: 29,
          padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(20)),
              border: Border.all(
                color: const Color(0xffbbFF4956),
              )),
          child: Text(
            "$name",
            style: GoogleFonts.poppins(fontSize: 13),
          ),
        ),
        Positioned(
          left: 55,
          top: 3,
          child: Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            child: Text(
              "$posi",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11),
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: <Color>[
                      const Color(0xffbFE8664),
                      AppColors.mainColor
                    ])),
          ),
        ),
      ],
    );
  }
}
