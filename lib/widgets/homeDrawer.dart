import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/models/wallet.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/cricketStates.dart';
import 'package:winx/providers/user.dart';
import 'package:winx/screens/chips.dart';
import 'package:winx/screens/coins.dart';
import 'package:winx/screens/getTransactionHistory.dart';
import 'package:winx/screens/loginScreen.dart';
import 'package:winx/screens/myProfile.dart';
import 'package:winx/widgets/kycStatus.dart';
import '../models/wallet.dart';
import '../styles/colors.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Container(
          height: double.infinity,
          width: double.infinity,
          color: AppColors.mainColorLight,
          child: SafeArea(
              child: Column(
            children: <Widget>[
              Consumer<User>(
                builder: (con, user, _) => user.getUser
                    ? CircularProgressIndicator()
                    : Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  FractionalTranslation(
                                    translation: Offset(0.0, -0.1),
                                    child: Align(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 20.0, left: 2),
                                            child: Stack(
                                                fit: StackFit.loose,
                                                children: <Widget>[
                                                  Row(
                                                    // crossAxisAlignment:
                                                    //     CrossAxisAlignment.center,
                                                    // mainAxisAlignment:
                                                    //     MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      InkWell(
                                                        onTap: () {
                                                          // Navigator.push(
                                                          //     context,
                                                          //     FadeNavigation(
                                                          //         widget: UserInfo()));
                                                        },
                                                        child: Container(
                                                          child: Container(
                                                            width: 90.0,
                                                            height: 85.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .white),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              child:
                                                                  Image.network(
                                                                user
                                                                    .userDetails[
                                                                        0]
                                                                    .img,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Tooltip(
                                                    message: 'KYC Status',
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 55.0,
                                                                left: 69.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.green,
                                                              radius: 10.0,
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                ]),
                                          )
                                        ],
                                      ),
                                      alignment: FractionalOffset(0.5, 0.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 120,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        user.userDetails[0].name,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                // Spacer(),
                                SizedBox(
                                  height: 10,
                                ),
                                // Container(
                                //   width: 120,
                                //   child: Text(user.userDetails[0].email,
                                //       overflow: TextOverflow.ellipsis,
                                //       maxLines: 1,
                                //       style: TextStyle(
                                //           color: Colors.white, fontSize: 13)),
                                // ),
                                Container(
                                  width: 120,
                                  child: Text(user.userDetails[0].team_name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                KycStatus(),
                              ],
                            )
                          ],
                        ),
                      ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Expanded(
                  flex: 7,
                  child: Container(
                    decoration: buildBoxDecoration2(),
                    child: ListView(
                      primary: false,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.mainColorLight),
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: <Widget>[
                                    Consumer<CricketStates>(
                                      builder: (con, state, _) => ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10),
                                        leading: leadingImage(
                                            "assets/images/jointHistory.png"),
                                        dense: true,
                                        title: Text(
                                          'Joined History',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        enabled: true,
                                        onTap: () {
                                          if (state.matchupSection ==
                                              MatchupSections.joinedmatchups) {
                                            state.changeMatchUpSection(
                                                MatchupSections.lobbymatchup);
                                            state.showHideAppBar(true);
                                          } else {
                                            state.changeMatchUpSection(
                                                MatchupSections.joinedmatchups);
                                            state.showHideAppBar(false);
                                          }
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      leading: leadingImage(
                                          "assets/images/transHistory.png"),
                                      dense: true,
                                      title: Text(
                                        'Transactions History',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      enabled: true,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            FadeNavigation(
                                                widget: TransactionHistory()));
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              // Divider(
                              //   height: 1,
                              //   color: Color.fromRGBO(22, 69, 87, 1),
                              //   indent: 50,
                              // ),
                              // Consumer<User>(
                              //   builder: (con, user, _) => ExpansionTile(
                              //     // contentPadding: EdgeInsets.symmetric(
                              //     //     vertical: 0, horizontal: 10),
                              //     leading: Icon(
                              //         FontAwesomeIcons.solidMoneyBillAlt,
                              //         color: Color.fromRGBO(22, 69, 87, 1)),
                              //     // dense: true,
                              //     title: Text(
                              //       'My Wallet',
                              //       style: TextStyle(
                              //         fontSize: 18,
                              //         color: Color.fromRGBO(22, 69, 87, 1),
                              //         fontWeight: FontWeight.w400,
                              //       ),
                              //     ),
                              //     children: [
                              //       ListTile(
                              //         onTap: () {
                              //           Navigator.push(context,
                              //               SlideNavigation(widget: MyCoins()));
                              //         },
                              //         // contentPadding:
                              //         //     EdgeInsets.symmetric(horizontal: 30),
                              //         title: Text('My Coins'),
                              //         trailing: Text(user.getWalletData
                              //             ? 'loading...'
                              //             : Coins.total.isEmpty
                              //                 ? '0'
                              //                 : Coins.total),
                              //       ),
                              //       ListTile(
                              //         onTap: () {
                              //           Navigator.push(context,
                              //               SlideNavigation(widget: MyChips()));
                              //         },
                              //         // contentPadding:
                              //         //     EdgeInsets.symmetric(horizontal: 30),
                              //         title: Text('My Chips'),
                              //         trailing: Text(user.getWalletData
                              //             ? 'loading...'
                              //             : Chips.total.isEmpty
                              //                 ? '0'
                              //                 : Chips.total),
                              //       )
                              //     ],
                              //     // enabled: true,
                              //     // onTap: () {
                              //     //   Navigator.push(context,
                              //     //       SlideNavigation(widget: MyWallet()));
                              //     // },
                              //   ),
                              // ),
                              // Divider(
                              //   height: 1,
                              //   color: Color.fromRGBO(22, 69, 87, 1),
                              //   indent: 50,
                              // ),

                              // Divider(
                              //   height: 1,
                              //   color: Color.fromRGBO(22, 69, 87, 1),
                              //   indent: 50,
                              // )
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.mainColorLight),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      leading: Icon(
                                        FontAwesomeIcons.userCircle,
                                        color:
                                            Color.fromRGBO(186, 196, 208, 0.91),
                                        size: 20,
                                      ),
                                      dense: true,
                                      title: Text(
                                        'Personal Information',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      enabled: true,
                                      onTap: () {
                                        Navigator.push(context,
                                            SlideNavigation(widget: Profile()));
                                        // Navigator.push(context,
                                        //     FadeNavigation(widget: HomeScreen2()));
                                      },
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      leading: leadingImage(
                                          "assets/images/fantasy.png"),
                                      dense: true,
                                      title: Text(
                                        'Fantasy points System',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      enabled: true,
                                      onTap: () {
                                        // Navigator.push(context,
                                        //     FadeNavigation(widget: UserTripDetails()));
                                      },
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      leading: Icon(
                                          FontAwesomeIcons.questionCircle,
                                          size: 20,
                                          color: Color.fromRGBO(
                                              186, 196, 208, 0.91)),
                                      dense: true,
                                      title: Text(
                                        'How to Play',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      enabled: true,
                                      onTap: () {},
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      leading: leadingImage(
                                          "assets/images/support.png"),
                                      dense: true,
                                      title: Text(
                                        'Support',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      enabled: true,
                                      onTap: () {
                                        // Navigator.push(
                                        //     context, FadeNavigation(widget: UserInfo()));
                                      },
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      leading: leadingImage(
                                          "assets/images/liability.png"),
                                      dense: true,
                                      title: Text(
                                        'Legalities',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      enabled: true,
                                      onTap: () {
                                        // Navigator.push(
                                        //     context, FadeNavigation(widget: UserInfo()));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 27),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Follow us",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Color.fromRGBO(
                                              186, 196, 208, 0.91),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.twitter,
                                          size: 30,
                                          color:
                                              Color.fromRGBO(85, 172, 238, 1),
                                        ),
                                        Icon(
                                          FontAwesomeIcons.facebookF,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.instagramSquare,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.youtube,
                                          size: 30,
                                          color: Color.fromRGBO(255, 0, 0, 1),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text("Version 1.0.0",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    color: Color.fromRGBO(
                                                        186, 196, 208, 0.91))),
                                            Text("App Upto Date",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    color: Color.fromRGBO(
                                                        186, 196, 208, 0.91)))
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text("UPDATE",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    color: Color.fromRGBO(
                                                        186, 196, 208, 0.91))),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.clear();
                                        final user = Provider.of<User>(context,
                                            listen: false);
                                        user.getChips.clear();
                                        user.getCoins.clear();
                                        user.transaction.clear();
                                        user.userDetails.clear();
                                        user.kyc.clear();

                                        Navigator.pushReplacement(
                                            context,
                                            BouncingNavigation(
                                                widget: LoginScreen()));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.powerOff,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Logout",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              // Expanded(
              //   flex: 1,
              //   child: Container(
              //       color: Colors.white,
              //       width: double.infinity,
              //       height: 100,
              //       child: Image.network(
              //         'https://cdn.freebiesupply.com/images/large/2x/skype-logo-white-and-white.png',
              //         fit: BoxFit.contain,
              //       )),
              // )
            ],
          ))),
    );
  }

  Image leadingImage(String img) {
    return Image.asset(
      "$img",
      width: 20,
    );
  }
}
