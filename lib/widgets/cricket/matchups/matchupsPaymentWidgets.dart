import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/cricketStates.dart';

class MatchUpsPayment extends StatefulWidget {
  MatchUpsPayment({Key key}) : super(key: key);

  @override
  _MatchUpsPaymentState createState() => _MatchUpsPaymentState();
}

class _MatchUpsPaymentState extends State<MatchUpsPayment> {
  @override
  Widget build(BuildContext context) {
    final states = Provider.of<CricketStates>(context);
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Text("Invest"),
            Container(
                width: 180,
                height: 36,
                alignment: Alignment.center,
                color: AppColors.lightPink,
                padding: EdgeInsets.only(left: 20, top: 4, bottom: 4),
                child: Row(
                  children: <Widget>[
                    // Text(
                    //   "I bet",
                    //   style: GoogleFonts.poppins(fontSize: 12),
                    // ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.backgroundColor,
                      ),
                      alignment: Alignment.center,
                      child: RaisedButton(
                        color: AppColors.backgroundColor,
                        onPressed: () {
                          states.increDecreInvest(false);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "-",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.mainColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Image.asset(
                      "assets/images/coins.png",
                      width: 14,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("${states.invest}",
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.backgroundColor,
                      ),
                      alignment: Alignment.center,
                      child: RaisedButton(
                        color: AppColors.backgroundColor,
                        onPressed: () {
                          states.increDecreInvest(true);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "+",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.mainColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                )),
          ],
        ),
        buildSizedBoxWidth(buildWidth(context), 0.10),
        Column(
          children: <Widget>[
            Text("Payout type"),
            GestureDetector(
              onTap: () {
                states.changeInvestType();
              },
              child: Card(
                elevation: 2,
                child: Container(
                  width: 120,
                  height: 34,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/coins.png",
                        width: 15,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        states.investType == InvestType.coins
                            ? "Coins"
                            : "Chips",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        "assets/images/refresh.png",
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
