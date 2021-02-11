import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winx/functions/widgetFunc.dart';

class PrizePool extends StatelessWidget {
  const PrizePool({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              prizePoolPrizes("Total Chips", "100,000"),
              prizePoolPrizes("Total Coins", "100,000"),
              prizePoolPrizes("Winners", "5000"),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 28,
          color: const Color(0xffbbFE8664),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "2432",
                style: GoogleFonts.poppins(
                    color: const Color(0xffbbFF4956),
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "players joined",
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 5,
              itemBuilder: (con, i) {
                return Column(
                  children: <Widget>[
                    buildSizedBox(buildHeight(context), 0.01),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      height: 64,
                      width: double.infinity,
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: <Widget>[
                              Text("$i - 0",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold)),
                              Spacer(),
                              Image.asset(
                                "assets/images/coins.png",
                                width: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("$i,000",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        )
      ],
    );
  }

  Column prizePoolPrizes(String title, String count) {
    return Column(
      children: <Widget>[
        Text(
          "$title",
          style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey),
        ),
        Row(
          children: <Widget>[
            Image.asset(
              "assets/images/coins.png",
              width: 18,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "$count",
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            )
          ],
        )
      ],
    );
  }
}
