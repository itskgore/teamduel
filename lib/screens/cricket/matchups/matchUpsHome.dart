import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/models/wallet.dart';
import 'package:winx/providers/cricketStates.dart';
import 'package:winx/providers/matchUps.dart';
import 'package:winx/providers/user.dart';
import 'package:winx/widgets/bottomSheet.dart';
import 'package:winx/widgets/homeDrawer.dart';

import 'package:winx/widgets/cricket/matchups/cricketMatchups.dart';
import 'package:winx/widgets/cricket/matchups/horseMatchups.dart';
import 'package:winx/widgets/cricket/matchups/matchupsJoined.dart';
import 'package:winx/widgets/cricket/matchups/matchupsLobby.dart';

class MatchUpHome extends StatefulWidget {
  MatchUpHome({Key key}) : super(key: key);

  @override
  _MatchUpHomeState createState() => _MatchUpHomeState();
}

void _modalBottomSheetMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0),
                )),
            alignment: Alignment.center,
            child: Text(
              "Summary",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "I bet",
                            style: GoogleFonts.poppins(),
                          ),
                          Row(
                            children: <Widget>[
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
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "-",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(color: AppColors.mainColor),
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
                              Text("10",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
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
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "+",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(color: AppColors.mainColor),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "To win",
                            style: GoogleFonts.poppins(),
                          ),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/coins.png",
                                width: 14,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("10",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: List.generate(10, (index) {
                      return Container(
                        padding:
                            EdgeInsets.only(left: 3, right: 15, bottom: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MatchUp(),
                            SizedBox(
                              width: 13,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  shape: BoxShape.circle),
                              padding: EdgeInsets.all(6),
                              child: Text(
                                "VS",
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            MatchUp(),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                // color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(20)),
            child: RaisedButton(
              onPressed: () {},
              color: AppColors.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "Confirm and Submit",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    ),
  );
  ;
}

class _MatchUpHomeState extends State<MatchUpHome>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TabController tabController;

  @override
  void initState() {
    super.initState();
    getUserData();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Coins coin;
  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              dialogBackgroundColor: Colors.black,
            ),
            child: child,
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    final states = Provider.of<CricketStates>(context, listen: false);
    states.chagneFilterCricket("");
    getCricketMatchups(f.format(selectedDate));
  }

  final f = new DateFormat('EEEE,MMM yy');

  Future<void> getCricketMatchups([String date, String filter]) async {
    final matchups = Provider.of<MatchupsCrickets>(context, listen: false);
    final states = Provider.of<CricketStates>(context, listen: false);
    matchups.cricketMatchupFetched = false;
    String dateIntial;
    if (date == null) {
      final f = new DateFormat('dd-MM-yyyy');
      dateIntial = f.format(DateTime.now());
    } else {
      dateIntial = date;
    }
    // date = "2020-10-20";
    if (states.selectionScreen == 2) {
      final res =
          await matchups.getCricketMatchups(dateIntial, "cricket", filter);
    } else {
      final res =
          await matchups.getCricketMatchups(dateIntial, "horse", filter);
    }
  }

  Future<void> submitMatchups() async {
    final matchups = Provider.of<MatchupsCrickets>(context, listen: false);
    final states = Provider.of<CricketStates>(context, listen: false);
    int type = 0;
    if (states.cricketMatchups.isEmpty) {
      type = 1;
    } else {
      type = 2;
    }
    print(type);
    if (!states.cricketMatchups.isEmpty && !states.horseMatchups.isEmpty) {
      type = 3;
    }
    states.cricketMatchups.forEach((element) {
      element.removeWhere((key, value) => key == "playerNumber");
    });
    states.horseMatchups.forEach((element) {
      element.removeWhere((key, value) => key == "horseNumber");
    });
    var matchupsData = states.cricketMatchups + states.horseMatchups;
    var data = {
      "user_id": "",
      "matchups": matchupsData,
      "bet_coins": states.invest.toString(),
      "matchup_type": type,
      "return_type": states.investType == InvestType.coins ? "coins" : "chips",
    } as Map<String, dynamic>;
    int count = data['matchups'].length;
    matchups.isSubmitLoading(true);
    final success = await matchups.postMatchups(data);
    matchups.isSubmitLoading(false);
    if (!success['status']) {
      // showSnack(context, success['msg'], _scaffoldkey);
      showCupertinoPop(success, context);
    } else {
      // showSnackSuccess(context, success['msg'], _scaffoldkey);
      showCupertinoPop(success, context);
      states.clearData();
      print("CLEAR");
    }
  }

  Future<void> getUserData() async {
    final user = Provider.of<User>(context, listen: false);
    if (user.userDetails.isEmpty) {
      print('getUSER');
      await getMatchupDateTime();
      await user.userData();
    }
    if (user.getCoins.isEmpty) {
      print('in wallet');
      await user.getWallet();
    }
  }

  Future<void> getMatchupDateTime() async {
    final matchup = Provider.of<MatchupsCrickets>(context, listen: false);
    final res = await matchup.getMatchupDateTime();
    if (!res['status']) {
      showCupertinoPop(res, context);
    }
  }

  void showDatesBottomSheet(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final matchupDate = Provider.of<MatchupsCrickets>(context, listen: false);

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
                children:
                    List.generate(matchupDate.matchupDates[0].data.length, (i) {
              var date = DateTime.fromMillisecondsSinceEpoch(
                      matchupDate.matchupDates[0].data[i] * 1000,
                      isUtc: true)
                  .toLocal();

              final dateToCheck = DateTime.fromMillisecondsSinceEpoch(
                      matchupDate.matchupDates[0].data[i] * 1000,
                      isUtc: true)
                  .toLocal();
              String todayTomm = "";
              final aDate = DateTime(
                  dateToCheck.year, dateToCheck.month, dateToCheck.day);
              if (aDate == today) {
                todayTomm = "Today";
              } else if (aDate == tomorrow) {
                todayTomm = "Tomorrow";
              }
              return Container(
                color: AppColors.mainColor,
                child: ListTile(
                  leading: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                  ),
                  title: todayTomm.isEmpty
                      ? Text(
                          "${formatter.format(date)}",
                          style: GoogleFonts.poppins(color: Colors.white),
                        )
                      : Text(
                          "$todayTomm",
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                  onTap: () {
                    matchupDate.changeSelectedDate(
                        todayTomm.isEmpty ? formatter.format(date) : todayTomm);
                    Navigator.of(context).pop();
                    getCricketMatchups(formatter.format(date));
                  },
                ),
              );
            })),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final states = Provider.of<CricketStates>(context);
    final matchups = Provider.of<MatchupsCrickets>(context);
    return Scaffold(
        backgroundColor: AppColors.mainColor,
        key: _scaffoldkey,
        drawer: HomeDrawer(),
        appBar: states.isAppbar
            ? AppBar(
                flexibleSpace: appBarGradientContainer(),
                backgroundColor: Colors.blue,
                leading: Consumer<User>(
                  builder: (con, user, _) => user.getUser
                      ? Icon(
                          FontAwesomeIcons.stopwatch20,
                        )
                      : user.userDetails[0].img == 'null'
                          ? Icon(FontAwesomeIcons.stopwatch20)
                          : GestureDetector(
                              onTap: () =>
                                  _scaffoldkey.currentState.openDrawer(),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                child: Icon(
                                  FontAwesomeIcons.bars,
                                ),
                              ),
                            ),
                ),
                // bottom: TabBar(
                //   unselectedLabelColor: Colors.white54,
                //   labelColor: Colors.white,
                //   tabs: [
                //     Tab(
                //         child: Text(
                //       "Cricket",
                //       style: GoogleFonts.poppins(),
                //     )),
                //     Tab(
                //       child: Text(
                //         "Horse Racing",
                //         style: GoogleFonts.poppins(),
                //       ),
                //     ),
                //   ],
                //   indicatorColor: Color(0xFFC1282D),
                //   indicatorWeight: 3,
                //   controller: tabController,
                // ),
                actions: [
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  //   margin: EdgeInsets.symmetric(vertical: 12),
                  //   height: 29,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: Colors.white),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: <Widget>[
                  //       Image.asset(
                  //         'assets/images/coins.png',
                  //         width: 15,
                  //         height: 15,
                  //       ),
                  //       SizedBox(
                  //         width: 4,
                  //       ),
                  //       Text(
                  //         Coins.total == null ? '0' : Coins.total,
                  //         overflow: TextOverflow.ellipsis,
                  //         style: GoogleFonts.poppins(
                  //             color: Colors.black, fontSize: 12),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // buildSizedBoxWidth(buildWidth(context), 0.06),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    margin: EdgeInsets.symmetric(vertical: 12),
                    height: 29,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/toppng.png',
                          width: 15,
                          height: 15,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          Coins.total == null ? '0' : Coins.total,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 9),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          FontAwesomeIcons.chevronDown,
                          color: Colors.white,
                          size: 8,
                        )
                      ],
                    ),
                  ),
                  // Spacer(),
                  SizedBox(
                    width: 12,
                  ),
                  Consumer<CricketStates>(
                    builder: (con, state, _) => GestureDetector(
                        onTap: () {
                          if (states.matchupSection ==
                              MatchupSections.joinedmatchups) {
                            state.changeMatchUpSection(
                                MatchupSections.lobbymatchup);
                            state.showHideAppBar(true);
                          } else {
                            state.changeMatchUpSection(
                                MatchupSections.joinedmatchups);
                            state.showHideAppBar(false);
                          }
                        },
                        child: Icon(
                          FontAwesomeIcons.plusCircle,
                          size: 15,
                          color: Color.fromRGBO(16, 119, 194, 1),
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    // margin: EdgeInsets.only(right: 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/Vector.png",
                          width: 20,
                        ),
                        Positioned(
                          right: -00,
                          top: 8,
                          child: Container(
                            width: 15,
                            height: 15,
                            alignment: Alignment.topRight,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(173, 28, 10, 0.9),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        // showDialogBox(context);
                      },
                      child: Row(
                        children: <Widget>[
                          // Text(
                          //   "Match Ups",
                          //   style: GoogleFonts.poppins(
                          //       fontWeight: FontWeight.bold, fontSize: 13),
                          // ),
                          Image.asset(
                            "assets/images/teamduel.png",
                            width: 100,
                          )
                          // SizedBox(
                          //   width: 3,
                          // ),
                          // // Icon(
                          // //   Icons.arrow_drop_down,
                          // //   size: 18,
                          // //   color: Color(0xFFC1282D),
                          // // )
                        ],
                      ),
                    ),
                    // buildSizedBoxWidth(buildWidth(context), 0.10),
                    Spacer(),
                  ],
                ),
              )
            : AppBar(
                flexibleSpace: appBarGradientContainer(),
                backgroundColor: Colors.blue,
                leading: Consumer<User>(
                  builder: (con, user, _) => user.getUser
                      ? Icon(FontAwesomeIcons.stopwatch20)
                      : user.userDetails[0].img == 'null'
                          ? Icon(FontAwesomeIcons.stopwatch20)
                          : GestureDetector(
                              onTap: () =>
                                  _scaffoldkey.currentState.openDrawer(),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                child: Icon(FontAwesomeIcons.bars),
                              ),
                            ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        showDialogBox(context);
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Match Ups",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 18,
                          )
                        ],
                      ),
                    ),
                    buildSizedBoxWidth(buildWidth(context), 0.10),
                    Text(
                      "MYTEAM ",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      "DUEL",
                      style: TextStyle(
                          color: Color.fromRGBO(249, 223, 65, 1), fontSize: 10),
                    ),
                    Spacer(),
                    Consumer<CricketStates>(
                      builder: (con, state, _) => GestureDetector(
                        onTap: () {
                          if (states.matchupSection ==
                              MatchupSections.joinedmatchups) {
                            state.changeMatchUpSection(
                                MatchupSections.lobbymatchup);
                            state.showHideAppBar(true);
                          } else {
                            state.changeMatchUpSection(
                                MatchupSections.joinedmatchups);
                            state.showHideAppBar(false);
                          }
                        },
                        child: Text(
                          states.matchupSection ==
                                  MatchupSections.joinedmatchups
                              ? "Lobby"
                              : "Jointed (0)",
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
        bottomSheet: states.matchupSection == MatchupSections.lobbymatchup
            ? Container(
                height: 75,
                width: double.infinity,
                color: Colors.grey[200],
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Total Selected",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            // Image.asset(
                            //   "assets/images/coins.png",
                            //   width: 15,
                            // ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${states.cricketMatchups.toList().length + states.horseMatchups.toList().length}",
                              style: GoogleFonts.poppins(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    buildSizedBoxWidth(buildWidth(context), 0.10),
                    Consumer<MatchupsCrickets>(
                      builder: (con, matchup, _) => matchup.submitLoading
                          ? Expanded(
                              child: Container(
                                  // width: 200,
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator()),
                            )
                          : Expanded(
                              // width: 200,
                              child: RaisedButton(
                                color: AppColors.mainColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                onPressed: () {
                                  // _modalBottomSheetMenu(context);
                                  // submitMatchups();
                                  showDialogSubmitDialog(
                                      context, submitMatchups);
                                },
                                child: Text("Submit",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                    )
                  ],
                ),
              )
            : Container(
                height: 0,
              ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              states.isAppbar
                  ? Column(
                      children: <Widget>[
                        //Select Date
                        Container(
                          color: AppColors.mainColor,
                          width: double.infinity,
                          height: buildHeight(context) * 0.08,
                          alignment: Alignment.center,
                          child: matchups.matchupDateLoading
                              ? CircularProgressIndicator()
                              : Row(
                                  children: <Widget>[
                                    Container(
                                      color: AppColors.mainColor,
                                      margin: EdgeInsets.only(
                                          left: buildWidth(context) * 0.3),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (matchups.getMatchupDates[0].data
                                              .isEmpty) {
                                            showAlertDialogNoFilter(
                                                context, "No Dates Available");
                                          } else {
                                            showDatesBottomSheet(context);
                                          }
                                          // selectDate(context);
                                        },
                                        child:
                                            //Select date code
                                            Container(
                                          alignment: Alignment.center,

                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  32, 49, 70, 0.91),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Color.fromRGBO(
                                                      32, 49, 70, 0.91),
                                                  width: 1)),
                                          width: 128,
                                          height: 38,
                                          // padding: EdgeInsets.only(
                                          //     left: 10, top: 10, bottom: 10, right: 10),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      32, 49, 70, 0.91),
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    FontAwesomeIcons
                                                        .calendarAlt,
                                                    color: Colors.white,
                                                    size: 13,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin:
                                                    EdgeInsets.only(left: 2),
                                                child: Text(
                                                  "${matchups.selectedDate}",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  FontAwesomeIcons.chevronDown,
                                                  color: Colors.white,
                                                  size: 13,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      FontAwesomeIcons.exclamationCircle,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "How to play",
                                      style: GoogleFonts.poppins(
                                          fontSize: 13, color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                        ),

                        // buildSizedBox(buildHeight(context), 0.02),

                        // Screen Selector
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.grey))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                                states.getSelectedScreenLength(), (i) {
                              var data = states.selectedScreen[i];
                              bool isSelected = data['isSelected'] == true;
                              return GestureDetector(
                                onTap: () {
                                  states.switchMatchUpScreens(
                                      data['screen'], true);
                                },
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          data['icon'],
                                          size: 16,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          data['title'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.grey,
                                              fontWeight: isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 83,
                                      height: 2,
                                      color: isSelected
                                          ? Colors.lightBlue
                                          : Colors.transparent,
                                    )
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                        buildSizedBox(buildHeight(context), 0.02),
                        //Addmob
                        Container(
                          width: double.infinity,
                          height: buildHeight(context) * 0.09,
                          color: Colors.black,
                          child: Center(
                            child: Text(
                              "Admob",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          // child: ,
                        ),
                        buildSizedBox(buildHeight(context), 0.02),
                      ],
                    )
                  : Container(),
              states.isAppbar
                  ? states.selectionScreen == 2
                      ? CricketMatchups()
                      : HorseMatchups(states: states)
                  : MatchUpJoined()
            ],
          ),
        ));
  }

  // Container(
  //         child: states.isAppbar
  //             ? TabBarView(
  //                 controller: tabController,
  //                 children: <Widget>[
  //                   CricketMatchups(),
  //                   HorseMatchups(states: states),
  //                 ],
  //               )
  //             : MatchUpJoined()),

  Widget sections(
      String title, bool isActive, BuildContext context, MatchupSections data) {
    return Consumer<CricketStates>(
      builder: (context, state, _) => Expanded(
        child: GestureDetector(
          onTap: () {
            state.changeMatchUpSection(data);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeIn,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                color: isActive ? Colors.white : const Color(0xffbe3e3e3),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              "$title",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: isActive ? AppColors.mainColor : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
