import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/cricketStates.dart';

class BWL extends StatelessWidget {
  const BWL({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final players = Provider.of<CricketStates>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          buildSizedBox(buildHeight(context), 0.02),
          players.bwl.isEmpty
              ? Text("Add 3 to 5 Batsmen")
              : Column(
                  children: List.generate(
                      players.bwl.length,
                      (index) => Container(
                            margin: EdgeInsets.only(bottom: 8),
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.mainColor, width: 1),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white),
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                CircleAvatar(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                      "assets/images/coins.png",
                                      width: 38,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "MS Dhoni",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "India, WK Bat",
                                      style: GoogleFonts.poppins(
                                          color: const Color(0xffbb808080),
                                          fontSize: 11),
                                    ),
                                    Text(
                                      "360 pts | 56% selected",
                                      style: GoogleFonts.poppins(
                                          color: const Color(0xffbb808080),
                                          fontSize: 11),
                                    ),
                                  ],
                                ),
                                Text(
                                  "8.5 CR",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print(index);
                                    print(players.bwl[index]['id']);
                                    players.toggleBWL(
                                        players.bwl[index]['id'], true);
                                  },
                                  child: Icon(
                                    Icons.minimize,
                                    size: 24,
                                    color: const Color(0xffbbFF4956),
                                  ),
                                )
                              ],
                            ),
                          ))),
          buildSizedBox(buildHeight(context), 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Wicket Keeper",
                style: GoogleFonts.poppins(
                    fontSize: 13, color: const Color(0xffbb545454)),
              ),
              Icon(FontAwesomeIcons.adjust)
            ],
          ),
          buildSizedBox(buildHeight(context), 0.02),
          Column(
              children: List.generate(players.dummybwl.length, (index) {
            return Container(
              margin: EdgeInsets.only(bottom: 8),
              height: 98,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CircleAvatar(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/images/coins.png",
                        width: 38,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "MS Dhoni",
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "India, WK Bat",
                        style: GoogleFonts.poppins(
                            color: const Color(0xffbb808080), fontSize: 11),
                      ),
                      Text(
                        "360 pts | 56% selected",
                        style: GoogleFonts.poppins(
                            color: const Color(0xffbb808080), fontSize: 11),
                      ),
                    ],
                  ),
                  Text(
                    "8.5 CR",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {
                      players.toggleBWL(players.dummybwl[index]['id'], false);
                    },
                    child: Icon(
                      Icons.add,
                      size: 24,
                      color: const Color(0xffbbFF4956),
                    ),
                  )
                ],
              ),
            );
          }))
        ],
      ),
    );
  }
}
