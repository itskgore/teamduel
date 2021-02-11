import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/models/wallet.dart';
import 'package:winx/providers/user.dart';

class MyCoins extends StatefulWidget {
  MyCoins({Key key}) : super(key: key);

  @override
  _MyCoinsState createState() => _MyCoinsState();
}

Future<void> getMyCoins(BuildContext context) async {
  final coins = Provider.of<User>(context, listen: false);
  await coins.getWallet();
}

Future<void> getaddpoints(BuildContext context) async {
  final coins = Provider.of<User>(context, listen: false);
  final res = await coins.getAdsPerUser();
  print(res);
  showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10.0,
                          offset: const Offset(0.0, 10.0),
                        ),
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      buildSizedBox(buildHeight(context), 0.07),
                      ListTile(
                        title: Text('Video Coins'),
                        trailing: CircleAvatar(
                          child: Text(res['video_coins'].toString()),
                        ),
                      ),
                      ListTile(
                        title: Text('Offer Wall Coins'),
                        trailing: CircleAvatar(
                          child: Text(res['offerwall_coins'].toString()),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    left: 95,
                    bottom: 140,
                    child: CircleAvatar(
                      maxRadius: 50,
                      backgroundImage: NetworkImage(coins.userDetails[0].img),
                    ))
              ],
            ),
          ));
}

class _MyCoinsState extends State<MyCoins> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            getaddpoints(context);
          },
          label: Text('Add Coins'),
          elevation: 4,
          icon: Icon(FontAwesomeIcons.plusCircle),
        ),
        // appBar: buildAppBarHome(context, 'My MyCoins'),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 250.0,
                pinned: true,
                floating: true,
                snap: true,
                automaticallyImplyLeading: true,
                flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    centerTitle: true,
                    title: Text("My Coins",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        )),
                    background: Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://image.freepik.com/free-vector/transparent-background-with-golden-confetti_52683-21101.jpg'),
                              fit: BoxFit.cover)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('COINS IMAGE'),
                          buildSizedBox(buildHeight(context), 0.05),
                          Text('Balance',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300)),
                          buildSizedBox(buildHeight(context), 0.01),
                          Consumer<User>(
                            builder: (con, user, _) => Text(
                                user.getWalletData
                                    ? 'Loading..'
                                    : Coins.total.isEmpty ? '0' : Coins.total,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    )),
              ),
            ];
          },
          body: RefreshIndicator(
            onRefresh: () => getMyCoins(context),
            child: ListView(
              children: [
                // buildSizedBox(buildHeight(context), 0.06),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Date',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'Type',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'Amount',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                Container(
                    alignment: Alignment.center,
                    height: 20,
                    child: Divider(color: Colors.black)),
                Consumer<User>(
                  builder: (con, user, _) => user.getWalletData
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SafeArea(
                          child: Column(
                            children: List.generate(
                                user.getCoins.length,
                                (i) => user.getCoins.isEmpty
                                    ? Center(
                                        child: Text(
                                          'No Coins Available',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          ExpansionTile(
                                            trailing: Container(
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              child: Container(
                                                  width: 50,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          user.getCoins[i]
                                                              .amount,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          )),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        FontAwesomeIcons.coins,
                                                        size: 10,
                                                        color: Colors.green,
                                                      )
                                                    ],
                                                  )),
                                            ),
                                            title: Container(
                                                width: double.infinity,
                                                margin:
                                                    EdgeInsets.only(left: 30),
                                                child: Text(
                                                    user.getCoins[i].type,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ))),
                                            leading: Text(
                                                DateFormat('dd-MM-yyyy').format(
                                                    DateTime.parse(user
                                                        .getCoins[i]
                                                        .createdAt))),
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10),
                                                child: Text(
                                                  'Description:',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
                                                  child: Text(
                                                    user.getCoins[i].message,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14),
                                                  ))
                                            ],
                                          ),
                                          Divider()
                                        ],
                                      )),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}
