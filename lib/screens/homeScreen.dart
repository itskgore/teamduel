import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/cricket/megaleagues/widgetFunctions.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/models/wallet.dart';
import 'package:winx/providers/user.dart';
import 'package:winx/screens/weeklyScreen.dart';
import 'package:winx/widgets/cricketGrandLeague.dart';
import 'package:winx/widgets/homeDrawer.dart';
import 'package:winx/widgets/referFriendDialog.dart';
import './cricket/megaLeague/cricketHomeScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _value = 'two';
  bool loading = false;
  Coins coin;
  TabController tabController;
  Future<void> getUserData() async {
    // setState(() {
    //   loading = true;
    // });
    final user = Provider.of<User>(context, listen: false);
    if (user.userDetails.isEmpty) {
      print('getUSER');
      await user.userData();
    }
    if (user.getCoins.isEmpty) {
      print('in wallet');
      await user.getWallet();
    }
    // setState(() {
    //   loading = false;
    // });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    getUserData();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      key: _scaffoldkey,
      drawer: HomeDrawer(),
      appBar: AppBar(
        flexibleSpace: appBarGradientContainer(),
        backgroundColor: Colors.blue,
        bottom: TabBar(
          unselectedLabelColor: Colors.white54,
          labelColor: Colors.white,
          tabs: [
            Tab(
                child: Text(
              "Cricket",
              style: GoogleFonts.poppins(),
            )),
            Tab(
              child: Text(
                "Horse Racing",
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
          indicatorColor: Colors.white,
          controller: tabController,
        ),
        leading: Consumer<User>(
          builder: (con, user, _) => user.getUser
              ? Icon(FontAwesomeIcons.stopwatch20)
              : user.userDetails[0].img == 'null'
                  ? Icon(FontAwesomeIcons.stopwatch20)
                  : GestureDetector(
                      onTap: () => _scaffoldkey.currentState.openDrawer(),
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: Icon(FontAwesomeIcons.bars),
                      ),
                    ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            margin: EdgeInsets.symmetric(vertical: 12),
            height: 29,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/images/coins.png',
                  width: 15,
                  height: 15,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  Coins.total == null ? '0' : Coins.total,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          ),
          buildSizedBoxWidth(buildWidth(context), 0.06),
        ],
        title: GestureDetector(
          onTap: () {
            showDialogBox(context);
          },
          child: Row(
            children: <Widget>[
              Text(
                "Mega Leagues",
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
      ),
      body: SafeArea(
          child: TabBarView(
        controller: tabController,
        children: [
          _value == 'one'
              ? Container(
                  child: Text("Horse racing"),
                )
              : Container(
                  child: CricketHomeScreen(),
                ),
          _value == 'one'
              ? Center(child: Text('Comming Soon Cricket'))
              : Center(child: Text('Comming Soon Horse Racing'))
        ],
      )),
    );
  }
}
