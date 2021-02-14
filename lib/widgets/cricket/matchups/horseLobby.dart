import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/cricketStates.dart';
import 'package:winx/providers/matchUps.dart';

class HorseMatchUpLobby extends StatefulWidget {
  HorseMatchUpLobby({Key key}) : super(key: key);

  @override
  _HorseMatchUpLobbyState createState() => _HorseMatchUpLobbyState();
}

class _HorseMatchUpLobbyState extends State<HorseMatchUpLobby> {
  DateTime selectedDate = DateTime.now();

  // Future<void> selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       builder: (BuildContext context, Widget child) {
  //         return Theme(
  //           data: ThemeData.dark().copyWith(
  //             dialogBackgroundColor: Colors.black,
  //           ),
  //           child: child,
  //         );
  //       },
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   final states = Provider.of<CricketStates>(context, listen: false);
  //   states.chagneFilterHorse("");
  //   getHorseMatchups(f.format(selectedDate));
  // }

  final f = new DateFormat('dd-MM-yyyy');
  Future<void> getHorseMatchups([String date, String filter]) async {
    final matchups = Provider.of<MatchupsCrickets>(context, listen: false);
    matchups.cricketMatchupFetched = false;
    String dateIntial;
    if (date == null) {
      final f = new DateFormat('dd-MM-yyyy');
      dateIntial = f.format(DateTime.now());
    } else {
      dateIntial = date;
    }
    final res = await matchups.getCricketMatchups(dateIntial, "horse", filter);
  }

  @override
  Widget build(BuildContext context) {
    final states = Provider.of<CricketStates>(context);
    return Consumer<MatchupsCrickets>(
      builder: (con, state, _) => FutureBuilder(
        future: state.cricketMatchupFetched ? null : getHorseMatchups(),
        builder: (con, snap) => snap.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          // SizedBox(
                          //   width: 19,
                          // ),
                          Text(
                            "Select  ( min 4 - Max 15) match-up to play",
                            style: GoogleFonts.poppins(
                                fontSize: 10, color: Colors.white),
                          ),
                          Consumer<MatchupsCrickets>(
                            builder: (con, filter, _) {
                              if (filter.getHorseMatchesLocation.isNotEmpty) {
                                if (states.selectedFilterHorse.isEmpty) {
                                  states.selectedFilterHorse = filter
                                      .getHorseMatchesLocation[0].locations;
                                } else {
                                  states.selectedFilterHorse =
                                      states.selectedFilterHorse;
                                }
                              }

                              return Expanded(
                                child: Container(
                                  height: 38,
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Dialog errorDialog = Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                12.0)), //this right here
                                        child: Container(
                                            height: 300.0,
                                            width: 300.0,
                                            child: ListView.builder(
                                                itemCount: filter
                                                    .horseMatchesLocation
                                                    .length,
                                                itemBuilder: (con, i) {
                                                  return Card(
                                                    elevation: 7,
                                                    margin: EdgeInsets.only(
                                                        top: 10,
                                                        right: 10,
                                                        left: 10),
                                                    child: ListTile(
                                                      onTap: () {
                                                        states.chagneFilterHorse(
                                                            "${filter.horseMatchesLocation[i].locations}");
                                                        getHorseMatchups(
                                                            f.format(
                                                                selectedDate),
                                                            filter
                                                                .getHorseMatchesLocation[
                                                                    i]
                                                                .locations
                                                                .toString());
                                                        Navigator.of(context)
                                                            .pop();
                                                        // print(states
                                                        //     .selectedFilterHorse);
                                                      },
                                                      title: Text(
                                                        "${filter.horseMatchesLocation[i].locations}",
                                                        style: GoogleFonts
                                                            .poppins(),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  );
                                                })),
                                      );
                                      states.selectedFilterHorse.isNotEmpty
                                          ? showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  errorDialog)
                                          : showAlertDialogNoFilter(context);
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/images/filter.png",
                                          width: 12,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${states.selectedFilterHorse.isEmpty ? "All" : states.selectedFilterHorse}",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          GestureDetector(
                            onTap: () {
                              getHorseMatchups();
                            },
                            child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: Color(0xffFCA031),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text("Refresh")),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children:
                          List.generate(state.horseMatchups.length, (index) {
                        var date = DateTime.fromMillisecondsSinceEpoch(
                            int.parse(state.horseMatchups[index]
                                    .utcMatchStartTimeStamp) *
                                1000);
                        print("---------------------");
                        print(date);
                        print("---------------------");
                        var remaining;
                        var time = 'min';
                        remaining = date.difference(DateTime.now()).inMinutes;
                        if (remaining.toString().contains("-")) {
                          remaining = '0';
                          time = 'ended';
                        } else {
                          if (remaining > 60) {
                            remaining = date.difference(DateTime.now()).inHours;
                            time = 'hr';
                          }
                        }
                        return Column(
                          children: <Widget>[
                            Container(
                              color: Color.fromRGBO(32, 49, 70, 0.91),
                              margin: EdgeInsets.only(bottom: 1),
                              child: ExpansionTile(
                                title: Row(
                                  children: <Widget>[
                                    Text(
                                      "${state.horseMatchups[index].raceName}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                    // buildSizedBoxWidth(buildWidth(context), 0.05),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "$remaining $time",
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    color: AppColors.mainColor,
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, bottom: 20),
                                    child: Column(
                                      children: List.generate(
                                          state.horseMatchups[index].matchups
                                              .length, (i) {
                                        var matchup1 = state
                                            .horseMatchups[index]
                                            .matchups[i]
                                            .matchupOne;
                                        var matchup2 = state
                                            .horseMatchups[index]
                                            .matchups[i]
                                            .matchupTwo;

                                        var data = states.horseMatchups.where(
                                            (element) =>
                                                element['matchup_id'] ==
                                                state.horseMatchups[index]
                                                    .matchups[i].matchupId
                                                    .toString());
                                        bool isLeft = false;
                                        if (!data.isEmpty) {
                                          if (data.toList()[0]['horseNumber'] ==
                                              matchup1.horseNo.toString()) {
                                            isLeft = true;
                                          } else {
                                            isLeft = false;
                                          }
                                        }
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    print(state
                                                        .horseMatchups[index]
                                                        .matchups[i]
                                                        .matchupId);
                                                    print("left");
                                                    states.addhorseMatchUps(
                                                        state
                                                            .horseMatchups[
                                                                index]
                                                            .matchups[i]
                                                            .matchupId
                                                            .toString(),
                                                        state
                                                            .horseMatchups[
                                                                index]
                                                            .raceId
                                                            .toString(),
                                                        "matchup_one",
                                                        matchup1.horseNo
                                                            .toString());
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              width: 2,
                                                              color: !data.isEmpty &&
                                                                      isLeft
                                                                  ? Colors.green
                                                                  : Colors
                                                                      .transparent)),
                                                      child: HorseMatchUp(
                                                        horseName:
                                                            matchup1.horseName,
                                                        horseNo:
                                                            matchup1.horseNo,
                                                        jockey: matchup1.jockey,
                                                        star: matchup1.star,
                                                        trainer:
                                                            matchup1.trainer,
                                                        isRight: false,
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 13,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: !data.isEmpty &&
                                                                  isLeft ||
                                                              !data.isEmpty &&
                                                                  !isLeft
                                                          ? Colors.green
                                                          : Colors.transparent,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Colors.grey),
                                                      shape: BoxShape.circle),
                                                  padding: EdgeInsets.all(6),
                                                  child: !data.isEmpty &&
                                                              isLeft ||
                                                          !data.isEmpty &&
                                                              !isLeft
                                                      ? Icon(
                                                          FontAwesomeIcons
                                                              .check,
                                                          color: Colors.white,
                                                          size: 12,
                                                        )
                                                      : Text(
                                                          "VS",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                ),
                                                SizedBox(
                                                  width: 13,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    print("right");
                                                    states.addhorseMatchUps(
                                                      state.horseMatchups[index]
                                                          .matchups[i].matchupId
                                                          .toString(),
                                                      state.horseMatchups[index]
                                                          .raceId
                                                          .toString(),
                                                      "matchup_two",
                                                      matchup2.horseNo
                                                          .toString(),
                                                    );
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              width: 2,
                                                              color: !data.isEmpty &&
                                                                      !isLeft
                                                                  ? Colors.green
                                                                  : Colors
                                                                      .transparent)),
                                                      child: HorseMatchUp(
                                                        horseName:
                                                            matchup2.horseName,
                                                        horseNo:
                                                            matchup2.horseNo,
                                                        jockey: matchup2.jockey,
                                                        star: matchup2.star,
                                                        trainer:
                                                            matchup2.trainer,
                                                        isRight: true,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            index == state.horseMatchups.length - 1
                                ? SizedBox(
                                    height: 100,
                                  )
                                : Container()
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
