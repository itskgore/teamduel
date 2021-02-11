import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/user.dart';
import 'package:winx/screens/paymentVerification.dart';

class PaymentWithdraw extends StatefulWidget {
  final String chips;
  final Map<String, dynamic> data;
  PaymentWithdraw({Key key, this.chips, this.data}) : super(key: key);

  @override
  _PaymentWithdrawState createState() => _PaymentWithdrawState();
}

class _PaymentWithdrawState extends State<PaymentWithdraw> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> payment = {
    'user_id': '',
    'wallet_name': '',
    'withdraw_amount': '',
    'mobile_number': ''
  };
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  void setPayment(String paymentdata) {
    setState(() {
      payment['wallet_name'] = paymentdata;
    });
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    if (payment['wallet_name'].toString().isEmpty) {
      showSnack(
          context, 'Select the amount receiving payment wallet', _scaffoldkey);
      return;
    }
    _formKey.currentState.save();
    // print(payment);
    final user = Provider.of<User>(context, listen: false);
    setState(() => loading = true);
    final res = await user.paymentWithdraw(payment);
    setState(() => loading = false);

    if (!res['status']) {
      showSnack(context, res['msg'], _scaffoldkey);
      return;
    }
    showSnack(context, res['msg'], _scaffoldkey);
    Future.delayed(Duration(seconds: 1), () {
      Navigator.push(
          context,
          DownSlideNavigation(
              widget: PaymentVerification(
            data: res,
          )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: buildAppBarHome(context, 'Payment Withdraw'),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Consumer<User>(
              builder: (con, user, _) => Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: double.infinity,
                    // height: buildHeight(context) * 0.10,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'NOTE:',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('${widget.data['quation']}',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15))),
                        ],
                      ),
                    ),
                  ),
                  buildSizedBox(buildHeight(context), 0.01),
                  Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                          'Possible withdraw amount: ${widget.data['withDrawlAmount']}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15))),
                  buildSizedBox(buildHeight(context), 0.02),
                  user.userDetails[0].country.toLowerCase().contains('india')
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setPayment('GPay'),
                                child: AnimatedOpacity(
                                  duration: Duration(seconds: 1),
                                  opacity: payment['wallet_name'] == 'GPay'
                                      ? 1
                                      : 0.3,
                                  child: Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            color:
                                                payment['wallet_name'] == 'GPay'
                                                    ? Colors.green
                                                    : Colors.grey,
                                            width:
                                                payment['wallet_name'] == 'GPay'
                                                    ? 2
                                                    : 1),
                                      ),
                                      child: Text('Google Pay')),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setPayment('Paytm'),
                                child: AnimatedOpacity(
                                  duration: Duration(seconds: 1),
                                  opacity: payment['wallet_name'] == 'Paytm'
                                      ? 1
                                      : 0.3,
                                  child: Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            color: payment['wallet_name'] ==
                                                    'Paytm'
                                                ? Colors.green
                                                : Colors.grey,
                                            width: payment['wallet_name'] ==
                                                    'Paytm'
                                                ? 2
                                                : 1),
                                      ),
                                      child: Text('Paytm')),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setPayment('PhonePay'),
                                child: AnimatedOpacity(
                                  duration: Duration(seconds: 1),
                                  opacity: payment['wallet_name'] == 'PhonePay'
                                      ? 1
                                      : 0.3,
                                  child: Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            color: payment['wallet_name'] ==
                                                    'PhonePay'
                                                ? Colors.green
                                                : Colors.grey,
                                            width: payment['wallet_name'] ==
                                                    'PhonePay'
                                                ? 2
                                                : 1),
                                      ),
                                      child: Text('PhonePay')),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setPayment('Paypal '),
                                child: AnimatedOpacity(
                                  duration: Duration(seconds: 1),
                                  opacity: payment['wallet_name'] == 'Paypal '
                                      ? 1
                                      : 0.3,
                                  child: Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            color: payment['wallet_name'] ==
                                                    'Paypal '
                                                ? Colors.green
                                                : Colors.grey,
                                            width: payment['wallet_name'] ==
                                                    'Paypal '
                                                ? 2
                                                : 1),
                                      ),
                                      child: Text('Paypal ')),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setPayment('Payoneer'),
                                child: AnimatedOpacity(
                                  duration: Duration(seconds: 1),
                                  opacity: payment['wallet_name'] == 'Payoneer'
                                      ? 1
                                      : 0.3,
                                  child: Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            color: payment['wallet_name'] ==
                                                    'Payoneer'
                                                ? Colors.green
                                                : Colors.grey,
                                            width: payment['wallet_name'] ==
                                                    'Payoneer'
                                                ? 2
                                                : 1),
                                      ),
                                      child: Text('Payoneer')),
                                ),
                              ),
                            ),
                          ],
                        ),
                  buildSizedBox(buildHeight(context), 0.05),
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: user.userDetails[0].country
                                    .toLowerCase()
                                    .contains('india')
                                ? TextInputType.number
                                : TextInputType.emailAddress,
                            validator: (val) {
                              val = val.trim();
                              bool email;
                              if (val.isEmpty) {
                                var string;
                                user.userDetails[0].country
                                        .toLowerCase()
                                        .contains('india')
                                    ? string =
                                        'Please enter a valid mobile number'
                                    : string = 'Please enter a valid email-id';
                                return string;
                              }
                              if (int.parse(val) < 5) {
                                return ' Please enter a valid mobile number';
                              }
                              user.userDetails[0].country
                                      .toLowerCase()
                                      .contains('india')
                                  ? email = false
                                  : email = true;
                              if (email) {
                                bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val);
                                if (!emailValid) {
                                  return 'Invalid email!';
                                }
                              }
                            },
                            onSaved: (val) {
                              payment['mobile_number'] = val.trim();
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                prefixIcon: Icon(
                                  FontAwesomeIcons.moneyCheck,
                                  size: 20,
                                ),
                                labelText: user.userDetails[0].country
                                        .toLowerCase()
                                        .contains('india')
                                    ? 'Enter your ${payment['wallet_name']} mobile no.'
                                    : 'Enter your ${payment['wallet_name']} mail id',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1)),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                          buildSizedBox(buildHeight(context), 0.03),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 10, bottom: 8),
                            child: Text(
                              'Total Withdraw possible:${widget.data['withDrawlAmount']}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              val = val.trim();
                              if (val.isEmpty) {
                                return 'Please the amount';
                              }
                              if (double.parse(val) <
                                  double.parse(widget.data['minimumWithDrawl']
                                      .toString())) {
                                return 'Amount should be more then ${widget.data['minimumWithDrawl']}';
                              }
                            },
                            onSaved: (val) {
                              payment['withdraw_amount'] = val.trim();
                            },
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 18),
                                prefixIcon: Icon(
                                  FontAwesomeIcons.dollarSign,
                                  size: 20,
                                ),
                                labelText:
                                    'Withdraw amount more than ${widget.data['minimumWithDrawl']}',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1)),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                          buildSizedBox(buildHeight(context), 0.03),
                          loading
                              ? CircularProgressIndicator()
                              : Container(
                                  width: buildWidth(context) * 0.75,
                                  height: buildHeight(context) * 0.08,
                                  child: RaisedButton(
                                    onPressed: () {
                                      _submit(context);
                                    },
                                    color: Colors.blue,
                                    elevation: 4,
                                    animationDuration:
                                        Duration(milliseconds: 350),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Text(
                                      'Proceed',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
