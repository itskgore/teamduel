import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/models/wallet.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
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
          color: secondaryColor,
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
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  user.userDetails[0].name,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Container(
                                  width: 120,
                                  child: Divider(
                                    color: primaryColors,
                                    thickness: 2,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  child: Text(user.userDetails[0].email,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13)),
                                ),
                                Container(
                                  width: 120,
                                  child: Text(user.userDetails[0].team_name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13)),
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
                              ListTile(
                                // contentPadding: EdgeInsets.symmetric(
                                //     vertical: 0, horizontal: 10),
                                leading: Icon(
                                  FontAwesomeIcons.userAlt,
                                  color: Color.fromRGBO(22, 69, 87, 1),
                                ),
                                dense: true,
                                title: Text(
                                  'My Profile',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(22, 69, 87, 1),
                                      fontWeight: FontWeight.w400),
                                ),
                                enabled: true,
                                onTap: () {
                                  Navigator.push(context,
                                      SlideNavigation(widget: Profile()));
                                },
                              ),
                              Divider(
                                height: 1,
                                color: Color.fromRGBO(22, 69, 87, 1),
                                indent: 50,
                              ),
                              Consumer<User>(
                                builder: (con, user, _) => ExpansionTile(
                                  // contentPadding: EdgeInsets.symmetric(
                                  //     vertical: 0, horizontal: 10),
                                  leading: Icon(
                                      FontAwesomeIcons.solidMoneyBillAlt,
                                      color: Color.fromRGBO(22, 69, 87, 1)),
                                  // dense: true,
                                  title: Text(
                                    'My Wallet',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(22, 69, 87, 1),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        Navigator.push(context,
                                            SlideNavigation(widget: MyCoins()));
                                      },
                                      // contentPadding:
                                      //     EdgeInsets.symmetric(horizontal: 30),
                                      title: Text('My Coins'),
                                      trailing: Text(user.getWalletData
                                          ? 'loading...'
                                          : Coins.total.isEmpty
                                              ? '0'
                                              : Coins.total),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.push(context,
                                            SlideNavigation(widget: MyChips()));
                                      },
                                      // contentPadding:
                                      //     EdgeInsets.symmetric(horizontal: 30),
                                      title: Text('My Chips'),
                                      trailing: Text(user.getWalletData
                                          ? 'loading...'
                                          : Chips.total.isEmpty
                                              ? '0'
                                              : Chips.total),
                                    )
                                  ],
                                  // enabled: true,
                                  // onTap: () {
                                  //   Navigator.push(context,
                                  //       SlideNavigation(widget: MyWallet()));
                                  // },
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: Color.fromRGBO(22, 69, 87, 1),
                                indent: 50,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                leading: Icon(
                                  FontAwesomeIcons.moneyBillWave,
                                  color: Color.fromRGBO(22, 69, 87, 1),
                                ),
                                dense: true,
                                title: Text(
                                  'My Transactions',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(22, 69, 87, 1),
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
                              Divider(
                                height: 1,
                                color: Color.fromRGBO(22, 69, 87, 1),
                                indent: 50,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                leading: Icon(
                                  FontAwesomeIcons.questionCircle,
                                  color: Color.fromRGBO(22, 69, 87, 1),
                                ),
                                dense: true,
                                title: Text(
                                  'How to play',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(22, 69, 87, 1),
                                      fontWeight: FontWeight.w400),
                                ),
                                enabled: true,
                                onTap: () {
                                  // Navigator.push(context,
                                  //     FadeNavigation(widget: HomeScreen2()));
                                },
                              ),
                              Divider(
                                height: 1,
                                color: Color.fromRGBO(22, 69, 87, 1),
                                indent: 50,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                leading: Icon(FontAwesomeIcons.coins,
                                    color: Color.fromRGBO(22, 69, 87, 1)),
                                dense: true,
                                title: Text(
                                  'Fantasy points System',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(22, 69, 87, 1),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                enabled: true,
                                onTap: () {
                                  // Navigator.push(context,
                                  //     FadeNavigation(widget: UserTripDetails()));
                                },
                              ),
                              Divider(
                                height: 1,
                                color: Color.fromRGBO(22, 69, 87, 1),
                                indent: 50,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                leading: Icon(FontAwesomeIcons.book,
                                    color: Color.fromRGBO(22, 69, 87, 1)),
                                dense: true,
                                title: Text(
                                  'Blog',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(22, 69, 87, 1),
                                      fontWeight: FontWeight.w400),
                                ),
                                enabled: true,
                                onTap: () {},
                              ),
                              Divider(
                                height: 1,
                                color: Color.fromRGBO(22, 69, 87, 1),
                                indent: 50,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                leading: Icon(FontAwesomeIcons.headset,
                                    color: Color.fromRGBO(22, 69, 87, 1)),
                                dense: true,
                                title: Text(
                                  'FAQ and Customer Support',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(22, 69, 87, 1),
                                      fontWeight: FontWeight.w400),
                                ),
                                enabled: true,
                                onTap: () {
                                  // Navigator.push(
                                  //     context, FadeNavigation(widget: UserInfo()));
                                },
                              ),
                              Divider(
                                height: 1,
                                color: Color.fromRGBO(22, 69, 87, 1),
                                indent: 50,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                leading: Icon(FontAwesomeIcons.gavel,
                                    color: Color.fromRGBO(22, 69, 87, 1)),
                                dense: true,
                                title: Text(
                                  'T&C, privacy policy',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(22, 69, 87, 1),
                                      fontWeight: FontWeight.w400),
                                ),
                                enabled: true,
                                onTap: () {
                                  // Navigator.push(
                                  //     context, FadeNavigation(widget: UserInfo()));
                                },
                              ),
                              Divider(
                                height: 1,
                                color: Color.fromRGBO(22, 69, 87, 1),
                                indent: 50,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                leading: Icon(FontAwesomeIcons.balanceScale,
                                    color: Color.fromRGBO(22, 69, 87, 1)),
                                dense: true,
                                title: Text(
                                  'Legalities',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(22, 69, 87, 1),
                                      fontWeight: FontWeight.w400),
                                ),
                                enabled: true,
                                onTap: () {
                                  // Navigator.push(
                                  //     context, FadeNavigation(widget: UserInfo()));
                                },
                              ),
                              Divider(
                                height: 1,
                                color: Color.fromRGBO(22, 69, 87, 1),
                                indent: 50,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                leading: Icon(FontAwesomeIcons.instagram,
                                    color: Color.fromRGBO(22, 69, 87, 1)),
                                dense: true,
                                title: Text(
                                  'Follow Us',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(22, 69, 87, 1),
                                      fontWeight: FontWeight.w400),
                                ),
                                enabled: true,
                                onTap: () {
                                  // Navigator.push(
                                  //     context, FadeNavigation(widget: UserInfo()));
                                },
                              ),
                              Divider(
                                height: 1,
                                color: Color.fromRGBO(22, 69, 87, 1),
                                indent: 50,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                leading: Icon(
                                  FontAwesomeIcons.powerOff,
                                  color: Color.fromRGBO(22, 69, 87, 1),
                                ),
                                dense: true,
                                title: Text(
                                  'Logout',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(22, 69, 87, 1),
                                      fontWeight: FontWeight.w400),
                                ),
                                enabled: true,
                                onTap: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.clear();
                                  final user =
                                      Provider.of<User>(context, listen: false);
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
                              ),
                              Divider(
                                height: 1,
                                color: Color.fromRGBO(22, 69, 87, 1),
                                indent: 50,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                flex: 1,
                child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 100,
                    child: Image.network(
                      'https://cdn.freebiesupply.com/images/large/2x/skype-logo-white-and-white.png',
                      fit: BoxFit.contain,
                    )),
              )
            ],
          ))),
    );
  }
}
