import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/user.dart';
import 'package:winx/screens/myProfile.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({Key key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool _password = true;
  bool _oldpassword = false;
  bool _confirmPassword = true;
  String confirmPass = '';
  Map<String, String> userData = {
    'id': '',
    'oldPassword': '',
    'password': '',
  };

  Future<void> submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    if (userData['password'] != confirmPass) {
      showSnack(
          context, 'Password and Confirm password did not match', _scaffoldkey);
      return;
    }
    final user = Provider.of<User>(context, listen: false);
    setState(() => loading = true);
    final res = await user.resetPassword(userData);
    setState(() => loading = false);
    if (!res['status']) {
      print(res['msg']);
      showSnack(context, res['msg'].join(""), _scaffoldkey);
      return;
    }
    showSnack(
        context, '${res['msg']} Redirecting to your Profile', _scaffoldkey);
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(context, FadeNavigation(widget: Profile()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: buildAppBarHome(context, 'Reset Password'),
      body: SafeArea(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.black12,
                height: buildHeight(context) * 0.30,
                alignment: Alignment.center,
                child: Text('Reset Password Image',
                    style: TextStyle(fontSize: 28)),
              ),
              buildSizedBox(buildHeight(context), 0.05),
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        obscureText: _oldpassword,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black,
                        cursorRadius: Radius.circular(10),
                        validator: (val) {
                          val = val.trim();
                          if (val.isEmpty) {
                            return 'Please enter your old password!';
                          }
                        },
                        onSaved: (val) {
                          userData['oldPassword'] = val.trim();
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            prefixIcon: IconButton(
                                onPressed: () => setState(() {
                                      _oldpassword = !_oldpassword;
                                    }),
                                icon: Icon(_oldpassword
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye)),
                            labelText: 'Old Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.black)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                      buildSizedBox(buildHeight(context), 0.03),
                      TextFormField(
                        obscureText: _password,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black,
                        cursorRadius: Radius.circular(10),
                        validator: (val) {
                          val = val.trim();
                          if (val.isEmpty || val.length <= 6) {
                            return 'Password should have more than 6 characters';
                          }
                        },
                        onSaved: (val) {
                          userData['password'] = val.trim();
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            prefixIcon: IconButton(
                                onPressed: () => setState(() {
                                      _password = !_password;
                                    }),
                                icon: Icon(_password
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye)),
                            labelText: 'New Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.black)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                      buildSizedBox(buildHeight(context), 0.03),
                      TextFormField(
                        obscureText: _confirmPassword,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black,
                        cursorRadius: Radius.circular(10),
                        validator: (val) {
                          val = val.trim();
                          if (val.isEmpty || val.length <= 6) {
                            return 'Password should have more than 6 characters';
                          }
                        },
                        onSaved: (val) {
                          confirmPass = val.trim();
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            prefixIcon: IconButton(
                                onPressed: () => setState(() {
                                      _confirmPassword = !_confirmPassword;
                                    }),
                                icon: Icon(_confirmPassword
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye)),
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.black)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                      buildSizedBox(buildHeight(context), 0.03),
                      loading
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            )
                          : Container(
                              width: buildWidth(context) * 0.55,
                              height: buildHeight(context) * 0.08,
                              child: RaisedButton(
                                onPressed: () {
                                  submit(context);
                                },
                                color: Colors.blue,
                                elevation: 4,
                                animationDuration: Duration(milliseconds: 350),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Text(
                                  'Reset Password',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
