import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/horse.dart';
import 'package:winx/providers/stateMangedHorseMegaLeague.dart';

class PickHorse extends StatefulWidget {
  String raceId;
  PickHorse({Key key, this.raceId}) : super(key: key);

  @override
  _PickHorseState createState() => _PickHorseState();
}

class _PickHorseState extends State<PickHorse> {
  int tickets = 10;
  int horse = 5;
  int horseCurrent = 1;
  int currentStable = 0;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  int stableId = 0;
  void stableChanged(int i) {
    setState(() => stableId = i);
  }

  void budget(int index) {
    final ticketStable =
        Provider.of<HorseMegaLeagueStates>(context, listen: false);
    ticketStable.setMaxBudget(index);
    ticketStable.clearData();
    ticketStable.keepCopy(
        ticketStable.horse.getPickHorse[0].tickets[index].ticketBudget);
  }

  @override
  void initState() {
    budget(1);
    super.initState();
  }

  Future<void> _submit(int stable) async {
    final ticketStable =
        Provider.of<HorseMegaLeagueStates>(context, listen: false);
    final horsePick = Provider.of<HorseProvider>(context, listen: false);
    Map<String, dynamic> body = {
      "user_id": '',
      "race_id": widget.raceId,
      "ticket": stable.toString(),
      "horses": ticketStable.horses
    };
    print(body);
    if (ticketStable.horses.isEmpty) {
      showSnack(context, 'Please pick a horse', _scaffoldkey);
      return;
    } else {
      ticketStable.setLoading(true);
      final res = await horsePick.submitStableHorse(body);
      ticketStable.setLoading(false);
      if (!res['status']) {
        showValidation(res['msg']);
      } else {
        showValidation(res['msg']);
      }
    }
  }

  void showValidation(String msg) {
    showSnack(context, msg, _scaffoldkey);
  }

  @override
  Widget build(BuildContext context) {
    final ticketStable =
        Provider.of<HorseMegaLeagueStates>(context, listen: false);
    final staticHorse = Provider.of<HorseProvider>(context, listen: false);
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(
              'Hyderabad - Race 1',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(icon: Icon(FontAwesomeIcons.infoCircle), onPressed: () {})
        ],
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Consumer<HorseMegaLeagueStates>(
          builder: (con, pickHorse, _) => pickHorse.horse.pickHorse.isEmpty
              ? Center(
                  child: Text(' No Horses Available Currently'),
                )
              : Column(
                  children: <Widget>[
                    buildSizedBox(buildHeight(context), 0.03),
                    Container(
                        width: double.infinity,
                        alignment: Alignment.bottomLeft,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: DropdownButtonFormField(
                                      onChanged: (val) {
                                        ticketStable.changeStable(val);
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.movie_creation),
                                        hintText: 'Stable 1',
                                        filled: true,
                                        fillColor: Colors.white,
                                        errorStyle:
                                            TextStyle(color: Colors.yellow),
                                      ),
                                      items: pickHorse
                                          .horse.pickHorse[0].tickets
                                          .map((map) {
                                        currentStable = ++currentStable;
                                        return DropdownMenuItem(
                                          child: Text('Stable ${map.ticketId}'),
                                          value: int.parse(map.ticketId),
                                        );
                                      }).toList())),
                              FlatButton(
                                  onPressed: () {
                                    ticketStable.clearData();
                                  },
                                  child: Text('Preview'))
                            ])),
                    buildSizedBox(buildHeight(context), 0.02),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.center,
                        child: Text(
                          'Ticket ${ticketStable.stable} Budget Left : ${pickHorse.horse.pickHorse[0].tickets[ticketStable.stableIndex].ticketBudget}',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        )),
                    buildSizedBox(buildHeight(context), 0.02),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: boxDecoration.copyWith(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            'H.No',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Sel by',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'PTS',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Credits',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Spent',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    buildSizedBox(buildHeight(context), 0.02),
                    Expanded(
                      flex: 8,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: boxDecoration.copyWith(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: ListView.builder(
                          primary: false,
                          itemCount: pickHorse.horse.pickHorse[0].horses.length,
                          itemBuilder: (con, ind) {
                            var items =
                                pickHorse.horse.pickHorse[0].horses[ind];
                            return Column(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  // height: buildHeight(context) * 0.18,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          width: double.infinity,
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                '${items.horseName}',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Spacer(),
                                              Text(
                                                '${items.playPoints} Cr',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          )),
                                      Divider(color: Colors.black),
                                      Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            child: Text(
                                              '${items.horseId}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            minRadius: 10,
                                          ),
                                          buildSizedBoxWidth(
                                              buildWidth(context), 0.03),
                                          Container(
                                            width: buildWidth(context) * 0.30,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  '${items.jockey}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                buildSizedBox(
                                                    buildHeight(context), 0.01),
                                                Text(
                                                  '${items.trainer}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          // buildSizedBoxWidth(
                                          //     buildWidth(context),
                                          //     0.05),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                '${items.playerPerformance}',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              buildSizedBox(
                                                  buildHeight(context), 0.01),
                                              Text(
                                                'PTS',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                          buildSizedBoxWidth(
                                              buildWidth(context), 0.05),
                                          Text('${items.selectedUserPer}%'),
                                          Spacer(),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      var limit = pickHorse
                                                          .horse
                                                          .pickHorse[0]
                                                          .tickets[ticketStable
                                                              .stableIndex]
                                                          .ticketBudget;

                                                      if (limit ==
                                                          pickHorse.maxBudget) {
                                                        showValidation(
                                                            "You can't exceed above ${pickHorse.maxBudget}");
                                                        return;
                                                      }
                                                      ticketStable.removeHorse(
                                                          items.horseId,
                                                          int.parse(
                                                              items.playPoints),
                                                          ticketStable
                                                              .stableIndex);
                                                    },
                                                    child: Icon(
                                                      FontAwesomeIcons.minus,
                                                      color: Colors.red,
                                                      size: 20,
                                                    )),
                                                buildSizedBox(
                                                    buildHeight(context), 0.01),
                                                Text(
                                                  '1',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                buildSizedBox(
                                                    buildHeight(context), 0.01),
                                                GestureDetector(
                                                    onTap: () {
                                                      var limit = pickHorse
                                                          .horse
                                                          .pickHorse[0]
                                                          .tickets[ticketStable
                                                              .stableIndex]
                                                          .ticketBudget;
                                                      print(limit);
                                                      if (limit == "0") {
                                                        showValidation(
                                                            "You have reached to the bottom line");
                                                        return;
                                                      }
                                                      ticketStable.addHorse(
                                                          items.horseId,
                                                          int.parse(
                                                              items.playPoints),
                                                          ticketStable
                                                              .stableIndex);
                                                    },
                                                    // quantity(true, widget.price, widget.id),
                                                    child: Icon(
                                                      FontAwesomeIcons.plus,
                                                      size: 20,
                                                      color: Colors.green,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.black,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                                color: Colors.green[100],
                                onPressed: () {
                                  print(ticketStable.horses.isNotEmpty);
                                  if (ticketStable.horses.isNotEmpty) {
                                    _submit(ticketStable.stable);
                                  } else {
                                    showValidation('Please pick a horse first');
                                  }
                                },
                                child: Text(
                                    'Submit Ticket ${ticketStable.stable}')),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      )),
    );
  }
}
