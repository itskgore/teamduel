import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/horse.dart';
import 'package:winx/providers/stateMangedHorseMegaLeague.dart';
import 'package:winx/screens/pickHorseScreen.dart';

class RaceList extends StatefulWidget {
  RaceList({Key key}) : super(key: key);

  @override
  _RaceListState createState() => _RaceListState();
}

class _RaceListState extends State<RaceList> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  Future<void> pickHorse(String raceId) async {
    final horses = Provider.of<HorseProvider>(context, listen: false);
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Loading...')));
    final res = await horses.getHorses(raceId);
    Scaffold.of(context).hideCurrentSnackBar();
    if (!res['status']) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(res['msg'])));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(res['msg'])));
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
            context,
            FadeNavigation(
                widget: PickHorse(
              raceId: raceId,
            )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HorseProvider>(
      builder: (con, raceList, _) => raceList.getMyRaceList.isEmpty
          ? Center(
              child: Text('No race available yet'),
            )
          : ListView.builder(
              primary: false,
              itemCount: raceList.getMyRaceList.length,
              itemBuilder: (con, i) {
                var items = raceList.getMyRaceList[i];
                return Column(
                  children: <Widget>[
                    buildSizedBox(buildHeight(context), 0.03),
                    Container(
                      width: double.infinity,
                      decoration: boxDecoration.copyWith(
                          borderRadius: BorderRadius.circular(10),
                          color: items.pickStatus == 'true'
                              ? Colors.white
                              : Colors.green[100]),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      height: buildHeight(context) * 0.20,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            child: Text(
                              '${items.raceName}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          Row(
                            children: [
                              CountdownTimer(
                                endTime: int.parse(items.seconds),
                                daysSymbol: "D :",
                                hoursSymbol: "H :",
                                minSymbol: "M :",
                                secSymbol: "S",
                                defaultDays: "**",
                                defaultHours: "**",
                                defaultMin: "**",
                                defaultSec: "**",
                                textStyle:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              ),
                              Spacer(),
                              FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                          color: Colors.black, width: 1)),
                                  onPressed: () {
                                    if (items.pickStatus == 'true') {
                                      pickHorse(items.raceId);
                                      return;
                                    }
                                    pickHorse(items.raceId);
                                  },
                                  child: Text(items.pickStatus == 'true'
                                      ? 'Pick Horse'
                                      : 'Preview'))
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Expanded(
                            child: Text('Results: ${items.result}'),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
