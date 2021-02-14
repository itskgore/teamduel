import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'dart:convert';
import 'package:winx/providers/auth.dart';
import 'package:winx/providers/user.dart';
import 'package:winx/screens/editUser.dart';
import 'package:winx/screens/myProfile.dart';

import 'homeScreen.dart';

class SocialLogin extends StatefulWidget {
  const SocialLogin({
    Key key,
  }) : super(key: key);

  @override
  _SocialLoginState createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  Future<void> googleLogin(BuildContext context) async {
    setState(() => loading = true);
    final auth = Provider.of<Auth>(context, listen: false);
    final res = await auth.googleLogin();
    setState(() => loading = false);
    if (!res['status']) {
      var stringList = res['msg'];
      showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
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
                      child: ListView(
                        primary: false,
                        shrinkWrap: true,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: buildHeight(context) * 0.10,
                            child: Text(
                              stringList,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
      return;
    }
    final user = Provider.of<User>(context, listen: false);
    final data = await user.userData();
    await user.getWallet();
    await user.getKycStatus();

    print(user.token);
    setState(() => loading = false);
    Navigator.pushReplacement(context, DownSlideNavigation(widget: Profile()));
  }

  Future<void> loginFacebook(BuildContext context) async {
    final auth = Provider.of<Auth>(context, listen: false);
    final res = await auth.loginFacebook();
    setState(() => loading = false);
    if (!res['status']) {
      var stringList = res['msg'];
      showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
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
                      child: ListView(
                        primary: false,
                        shrinkWrap: true,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: buildHeight(context) * 0.10,
                            child: Text(
                              stringList,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red, fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
      setState(() => loading = false);

      return;
    }
    final user = Provider.of<User>(context, listen: false);
    final data = await user.userData();
    await user.getWallet();

    print(user.token);
    setState(() => loading = false);
    Navigator.pushReplacement(context, DownSlideNavigation(widget: Profile()));
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  icon: Icon(FontAwesomeIcons.google, color: Colors.white),
                  onPressed: () {
                    googleLogin(context);
                  }),
              IconButton(
                  icon: Icon(FontAwesomeIcons.facebook,
                      size: 30, color: Color.fromRGBO(16, 119, 194, 1)),
                  onPressed: () {
                    loginFacebook(context);
                  }),
            ],
          );
  }
}
