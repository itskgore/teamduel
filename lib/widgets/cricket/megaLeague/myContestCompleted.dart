import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winx/config/colors.dart';

class MyContestCompleted extends StatelessWidget {
  const MyContestCompleted({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (con, i) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            width: double.infinity,
            height: 146,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
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
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Match 2$i",
                            style: GoogleFonts.poppins(
                                fontSize: 11, color: const Color(0xffbb777777)),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "COMPLETED",
                            style: GoogleFonts.poppins(
                                fontSize: 11, color: const Color(0xffbbFF4956)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 88,
                            height: 30,
                            child: RaisedButton(
                              onPressed: () {
                                // joinMatches();
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
                                    'WINNERS',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/rcb.png",
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
                                fontSize: 12, color: const Color(0xffbb333333)),
                          ),
                          SizedBox(
                            width: 17,
                          ),
                          Column(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/rcb.png",
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
                Divider(
                  thickness: 3,
                  color: AppColors.backgroundColor,
                ),
                // Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "#28",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Text(
                        "Team 1",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                      Text(
                        "282.5 pts",
                        style: GoogleFonts.poppins(
                            color: const Color(0xffbb777777),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "100 BP",
                            style: GoogleFonts.poppins(
                                color: const Color(0xffFF4956),
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 15,
                            color: const Color(0xffbb777777),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
