import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/models/wallet.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/user.dart';
import 'package:winx/screens/paymentWithdraw.dart';
import 'package:winx/screens/uploadDoc.dart';

class MyChips extends StatefulWidget {
  MyChips({Key key}) : super(key: key);

  @override
  _MyChipsState createState() => _MyChipsState();
}

class _MyChipsState extends State<MyChips> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  Future<void> getCoins(BuildContext context) async {
    final chips = Provider.of<User>(context, listen: false);
    await chips.getWallet();
  }

  Future<void> checkKYC(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final res = await user.getKycStatus();
    if (!res['status']) {
      showSnack(context, res['msg'], _scaffoldkey);
      Future.delayed(Duration(seconds: 1), () {
        Navigator.push(context, FadeNavigation(widget: UploadDoc()));
      });
    } else {
      showSnack(context, res['msg'], _scaffoldkey);
      final response = await user.getPaymentWithdrawQuation();

      print(response);
      if (!response['status']) {
        showSnack(context, res['msg'], _scaffoldkey);
        return;
      }
      Future.delayed(Duration(seconds: 1), () {
        Navigator.push(
            context,
            FadeNavigation(
                widget: PaymentWithdraw(
              chips: Chips.total,
              data: response,
            )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        // appBar: buildAppBarHome(context, 'My Coins'),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            checkKYC(context);
          },
          elevation: 4,
          label: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Withdraw'),
          ),
          icon: Icon(FontAwesomeIcons.moneyBill),
        ),
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
                    title: Text("My Chips",
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
                          Text('MyChips IMAGE'),
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
                                    : Chips.total.isEmpty ? '0' : Chips.total,
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
            onRefresh: () => getCoins(context),
            child: ListView(
              primary: false,
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
                                user.getChips.length,
                                (i) => user.getChips.isEmpty
                                    ? Center(
                                        child: Text(
                                          'No Chips Available',
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
                                                          user.getChips[i]
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
                                                    user.getChips[i].type,
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
                                                        .getChips[i]
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
                                                    user.getChips[i].message,
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
