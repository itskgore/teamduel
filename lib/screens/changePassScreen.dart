import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/auth.dart';
import 'package:winx/screens/loginScreen.dart';

class ChangePassword extends StatefulWidget {
  final String email;
  final String user_id;
  ChangePassword({Key key, this.email, this.user_id}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  String thisText = "";
  int pinLength = 4;
  bool hasError = false;
  String errorMessage;
  final _formKey = GlobalKey<FormState>();
  bool _password = true;
  bool _confirmPassword = true;
  String confirmPass = '';
  bool loading = false;
  TextEditingController controller = TextEditingController(text: "");
  Map<String, String> userData = {
    'user_id': '',
    'verification_code': '',
    'password': '',
  };
  // Future<void> resendOTP(BuildContext context) async {
  //   final auth = Provider.of<Auth>(context, listen: false);
  //   final res = await auth.resendOTP(widget.email);
  //   print(res);
  //   if (!res['status']) {
  //     showSnack(context, res['msg'], _scaffoldkey);
  //   } else {
  //     showSnack(context, "Otp resent successfully", _scaffoldkey);
  //   }
  // }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    userData['verification_code'] = controller.text;
    userData['user_id'] = widget.user_id;
    if (userData['password'] != confirmPass) {
      showSnack(
          context, 'Password and Confirm password did not match', _scaffoldkey);
      return;
    }
    final auth = Provider.of<Auth>(context, listen: false);
    setState(() => loading = true);
    print(userData);
    final res = await auth.changePassword(userData);
    setState(() => loading = false);

    var stringList = '';
    if (!res['status']) {
      // print(res);
      stringList = res['msg'].join("");
      showSnack(context, stringList, _scaffoldkey);
      return;
    }
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == 4) {
        timer.cancel();
        Navigator.pushReplacement(
            context, FadeNavigation(widget: LoginScreen()));
      }
    });
    stringList = res['msg'];
    showDialog(
        barrierDismissible: false,
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
                          alignment: Alignment.center,
                          child: Text(
                            'Image',
                            textAlign: TextAlign.center,
                          ),
                          height: buildHeight(context) * 0.15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black12),
                        ),
                        buildSizedBox(buildHeight(context), 0.02),
                        Text(
                          'Password changed successfully',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.green, fontSize: 18),
                        ),
                        buildSizedBox(buildHeight(context), 0.02),
                        Text(
                          'You will be redirected to the login screen now',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        buildSizedBox(buildHeight(context), 0.02),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      key: _scaffoldkey,
      appBar: buildAppBar(context, 'Change Password'),
      body: SafeArea(
          child: Container(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildSizedBox(buildHeight(context), 0.01),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 34),
                      width: double.infinity,
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Enter the OTP sent on ${widget.email}',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                    buildSizedBox(buildHeight(context), 0.03),
                    PinCodeTextField(
                      autofocus: true,
                      controller: controller,
                      highlight: true,
                      highlightColor: AppColors.mainColorLight,
                      defaultBorderColor: AppColors.mainColorLight,
                      hasTextBorderColor: AppColors.mainColorLight,
                      isCupertino: true,
                      pinBoxRadius: 5,
                      maxLength: pinLength,
                      hasError: hasError,
                      onTextChanged: (text) {
                        setState(() {
                          hasError = false;
                        });
                      },
                      onDone: (text) {
                        print("DONE $text");
                        print("DONE CONTROLLER ${controller.text}");
                      },
                      wrapAlignment: WrapAlignment.spaceAround,
                      pinBoxDecoration:
                          ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                      pinTextStyle:
                          TextStyle(fontSize: 30.0, color: Colors.white),
                      pinTextAnimatedSwitcherTransition:
                          ProvidedPinBoxTextAnimation.scalingTransition,
                      pinBoxColor: AppColors.mainColorLight,
                      pinTextAnimatedSwitcherDuration:
                          Duration(milliseconds: 300),
                      highlightAnimation: true,
                      highlightAnimationBeginColor: AppColors.mainColorLight,
                      highlightAnimationEndColor: AppColors.mainColorLight,
                      keyboardType: TextInputType.number,
                    ),
                    buildSizedBox(buildHeight(context), 0.03),
                    Form(
                      key: _formKey,
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        height: controller.text.length == 4 ? null : 0,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            TextFormField(
                              obscureText: _password,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.white,
                              cursorRadius: Radius.circular(10),
                              validator: (val) {
                                val = val.trim();
                                if (val.isEmpty || val.length <= 3) {
                                  return 'Password should have more than 3 characters';
                                }
                                return null;
                              },
                              onSaved: (val) {
                                userData['password'] = val.trim();
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                fillColor: AppColors.mainColorLight,
                                filled: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 15),
                                prefixIcon: IconButton(
                                    onPressed: () => setState(() {
                                          _password = !_password;
                                        }),
                                    icon: Icon(
                                      _password
                                          ? FontAwesomeIcons.lock
                                          : FontAwesomeIcons.lockOpen,
                                      color: Colors.white,
                                    )),
                                hintText: 'Password',
                                hintStyle: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 12),
                                focusedBorder: buildOutlineInputBorder(),
                                border: buildOutlineInputBorder(),
                              ),
                            ),
                            buildSizedBox(buildHeight(context), 0.03),
                            TextFormField(
                              obscureText: _confirmPassword,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              cursorRadius: Radius.circular(10),
                              validator: (val) {
                                val = val.trim();
                                if (val.isEmpty || val.length <= 3) {
                                  return 'Password should have more than 3 characters';
                                }
                              },
                              onSaved: (val) {
                                confirmPass = val.trim();
                              },
                              decoration: InputDecoration(
                                fillColor: AppColors.mainColorLight,
                                filled: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 15),
                                prefixIcon: IconButton(
                                    onPressed: () => setState(() {
                                          _confirmPassword = !_confirmPassword;
                                        }),
                                    icon: Icon(
                                      _confirmPassword
                                          ? FontAwesomeIcons.lock
                                          : FontAwesomeIcons.lockOpen,
                                      color: Colors.white,
                                    )),
                                hintText: 'Confirm Password',
                                hintStyle: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 12),
                                focusedBorder: buildOutlineInputBorder(),
                                border: buildOutlineInputBorder(),
                              ),
                            ),
                            buildSizedBox(buildHeight(context), 0.03),
                            Container(
                              width: buildWidth(context) * 0.90,
                              height: 40,
                              child: RaisedButton(
                                onPressed: () {
                                  _submit(context);
                                },
                                color: Color.fromRGBO(16, 119, 194, 1),
                                elevation: 4,
                                animationDuration: Duration(milliseconds: 350),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                                child: loading
                                    ? CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                      )
                                    : Text(
                                        'Change Password',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // buildSizedBox(buildHeight(context), 0.01),
                    // GestureDetector(
                    //   onTap: () {
                    //     resendOTP(context);
                    //   },
                    //   child: Text('Resend OTP',
                    //       style: TextStyle(color: Colors.grey, fontSize: 18)),
                    // ),
                  ],
                ),
              ))),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(color: AppColors.mainColorLight));
  }
}
