import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winx/functions/widgetFunc.dart';

class UpcomingRaceMegaLeague extends StatelessWidget {
  const UpcomingRaceMegaLeague({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buildHeight(context) * 0.30,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6.0,
            ),
          ],
          color: Colors.grey[200],
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          buildSizedBox(buildHeight(context), 0.02),
          Row(
            children: [
              Text(
                'Racing Contest From 20-June to 25-July',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(FontAwesomeIcons.infoCircle)
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          buildSizedBox(buildHeight(context), 0.01),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    'Price (1st rank: 2000)',
                    textAlign: TextAlign.left,
                  ),
                  buildSizedBox(buildHeight(context), 0.02),
                  Text(
                    '5000 R & 5000 B',
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    'Winner',
                    textAlign: TextAlign.center,
                  ),
                  buildSizedBox(buildHeight(context), 0.01),
                  Text(
                    'Top 2500',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          buildSizedBox(buildHeight(context), 0.02),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ends In: ',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                buildSizedBoxWidth(buildWidth(context), 0.01),
                CountdownTimer(
                  endTime: 1594829147719,
                  daysSymbol: "D :",
                  hoursSymbol: "H :",
                  minSymbol: "M :",
                  secSymbol: "S",
                  defaultDays: "**",
                  defaultHours: "**",
                  defaultMin: "**",
                  defaultSec: "**",
                  textStyle: TextStyle(color: Colors.red, fontSize: 15),
                )
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: FlatButton(
                        onPressed: () {}, child: Text('LeaderBoard'))),
                Expanded(
                    child: FlatButton(
                        onPressed: () {}, child: Text('Join Contest'))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
