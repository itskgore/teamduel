import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/calcuFunc.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/auth.dart';
import 'package:winx/providers/user.dart';
import 'package:winx/screens/emailVeriScreen.dart';
import 'package:winx/screens/homeScreen.dart';
import 'package:winx/screens/signupScreen.dart';
import 'package:winx/widgets/forgotPassDialog.dart';

import 'socialLoginScreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _password = true;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  Map<String, String> _loginData = {'email': '', 'password': ''};
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  void showSnack(BuildContext context, stringList) {
    _scaffoldkey.currentState.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      content: Text(
        stringList,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.red),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.black87,
    ));
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final auth = Provider.of<Auth>(context, listen: false);
    setState(() => loading = true);
    final res = await auth.loginUser(_loginData);
    setState(() => loading = false);
    if (!res['status']) {
      var stringList = res['msg'].join("");

      showSnack(context, stringList);
      if (stringList == 'Please verify your account') {
        await auth.resendOTP(_loginData['email']);
        Navigator.push(
            context,
            FadeNavigation(
                widget: EmailVerify(
              userEmail: _loginData['email'],
            )));
      }
      return;
    }
    final user = Provider.of<User>(context, listen: false);
    // final data = await user.userData();
    await user.getWallet();
    print(user.token);
    Navigator.pushReplacement(
        context, DownSlideNavigation(widget: HomeScreen()));
  }

  Future buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => ForgotPasswordDialog());
  }

  @override
  Widget build(BuildContext context) {
    double height = buildHeight(context);
    double width = buildWidth(context);
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.grey[200],
      body: WillPopScope(
        onWillPop: () {
          SystemNavigator.pop();
        },
        child: SafeArea(
            child: Container(
          height: height,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildSizedBox(height, 0.07),
                Container(
                  alignment: Alignment.center,
                  height: height * 0.20,
                  width: double.infinity,
                  child: Text(
                    'LOGO',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 35),
                  ),
                ),
                buildSizedBox(height, 0.06),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          autocorrect: true,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          cursorRadius: Radius.circular(10),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 14),
                              prefixIcon: Icon(FontAwesomeIcons.user),
                              labelText: 'Email / Mobile No.',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.black)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.black))),
                          validator: (val) {
                            val = val.trim();
                            if (val.isEmpty || val.length < 5) {
                              return 'Please provide a valid email-id';
                            }
                          },
                          onSaved: (val) {
                            _loginData['email'] = val.trim();
                          },
                        ),
                        buildSizedBox(height, 0.03),
                        TextFormField(
                          obscureText: _password,
                          autocorrect: true,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          cursorRadius: Radius.circular(10),
                          validator: (val) {
                            val = val.trim();
                            if (val.isEmpty || val.length <= 3) {
                              return 'Please provide your password';
                            }
                          },
                          onSaved: (val) {
                            _loginData['password'] = val.trim();
                          },
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 14),
                              prefixIcon: IconButton(
                                icon: Icon(_password
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye),
                                onPressed: () {
                                  setState(() {
                                    _password = !_password;
                                  });
                                },
                              ),
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.black)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        buildSizedBox(height, 0.01),
                        Container(
                          width: width,
                          padding: EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              buildShowDialog(context);
                            },
                            child: Text(
                              'Forgot Password ?',
                              textAlign: TextAlign.right,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        buildSizedBox(height, 0.05),
                        loading
                            ? CircularProgressIndicator()
                            : Container(
                                width: width * 0.65,
                                height: height * 0.08,
                                child: RaisedButton(
                                  onPressed: () {
                                    _submit(context);
                                  },
                                  color: Colors.blue,
                                  elevation: 4,
                                  animationDuration:
                                      Duration(milliseconds: 350),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Text(
                          'Or connect using',
                          style: TextStyle(color: Colors.black),
                        ),
                        buildSizedBox(height, 0.01),
                        SocialLogin(),
                        buildSizedBox(height, 0.04),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: "Signup",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.push(
                                    context, FadeNavigation(widget: SingUp())),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))
                        ]))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
