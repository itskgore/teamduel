import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/user.dart';

class TransactionHistory extends StatefulWidget {
  TransactionHistory({Key key}) : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  Future<void> getTransactions(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final res = await user.getTransactions();
    if (!res['status']) {
      showSnack(context, res['msg'], _scaffoldkey);
    }
  }

  Future<void> refreshGetTransactions(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final res = await user.getTransactions();
    if (!res['status']) {
      showSnack(context, res['msg'], _scaffoldkey);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: buildAppBarHome(context, 'Transaction History'),
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () => refreshGetTransactions(context),
        child: FutureBuilder(
          future: getTransactions(context),
          builder: (con, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Consumer<User>(
                builder: (con, user, _) => user.transaction.isEmpty
                    ? Center(
                        child: Text('You have no transactions done yet!'),
                      )
                    : ListView.builder(
                        primary: false,
                        itemCount: user.transaction.length,
                        itemBuilder: (con, i) => Column(
                          children: [
                            ListTile(
                              title: Text(
                                'Amount: ${user.transaction[i].withdrawAmount}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' ${user.transaction[i].mobileNumber}  (${user.transaction[i].paymentStatus})',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(user
                                              .transaction[i].walletName.isEmpty
                                          ? 'assets/images/googlepay.png'
                                          : user.transaction[i].walletName ==
                                                  'GPay'
                                              ? 'assets/images/googlepay.png'
                                              : user.transaction[i].walletName ==
                                                      'PhonePay'
                                                  ? 'assets/images/phonepay.png'
                                                  : user.transaction[i]
                                                              .walletName ==
                                                          'Paytm'
                                                      ? 'assets/images/paytm.png'
                                                      : user.transaction[i]
                                                                  .walletName ==
                                                              'Paypal'
                                                          ? 'assets/images/paypal.png'
                                                          : user.transaction[i]
                                                                      .walletName ==
                                                                  'Payoneer '
                                                              ? 'assets/images/razorpay.png'
                                                              : 'assets/images/googlepay.png')),
                                  Text(
                                    DateFormat('yyyy-MM-dd').format(
                                        DateTime.parse(
                                            user.transaction[i].createdAt)),
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              endIndent: 30,
                              indent: 30,
                            )
                          ],
                        ),
                      ),
              );
            }
          },
        ),
      )),
    );
  }
}
