import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/auth.dart';
import 'package:winx/screens/loginScreen.dart';

class EmailVerify extends StatefulWidget {
  final userEmail;
  EmailVerify({Key key, this.userEmail}) : super(key: key);

  @override
  _EmailVerifyState createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  Map<String, String> userMail = {
    "verification_id": '',
    "email": '',
  };
  String thisText = "";
  int pinLength = 4;
  bool hasError = false;
  String errorMessage;
  String confirmPass = '';
  bool loading = false;
  bool resendLoading = false;
  TextEditingController controller = TextEditingController(text: "");
  void showSnack(BuildContext context, stringList) {
    _scaffoldkey.currentState.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Text(
        stringList,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: AppColors.mainColorLight,
    ));
  }

  Future<void> _submit(BuildContext context) async {
    setState(() {
      loading = true;
      userMail['email'] = widget.userEmail;
      userMail['verification_id'] = controller.text;
    });
    final auth = Provider.of<Auth>(context, listen: false);
    final res = await auth.emailVerify(userMail);
    setState(() => loading = false);
    if (!res['status']) {
      var stringList = res['msg'];

      showSnack(context, stringList);
      return;
    }
    showSnack(context, res['msg'] + 'You can login now!');
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, FadeNavigation(widget: LoginScreen()));
    });
  }

  Future<void> resendOtp(BuildContext context) async {
    final auth = Provider.of<Auth>(context, listen: false);
    setState(() => resendLoading = true);
    final res = await auth.resendOTP(widget.userEmail);
    setState(() => resendLoading = false);
    if (!res['status']) {
      showSnack(context, res['msg']);
      return;
    }
    showSnack(context, res['msg']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      key: _scaffoldkey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSizedBox(buildHeight(context), 0.02),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 34),
                width: double.infinity,
                child: Text(
                  'Enter the OTP sent on ${widget.userEmail}',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
              buildSizedBox(buildHeight(context), 0.04),
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
                pinTextStyle: TextStyle(fontSize: 30.0, color: Colors.white),
                pinTextAnimatedSwitcherTransition:
                    ProvidedPinBoxTextAnimation.scalingTransition,
                pinBoxColor: AppColors.mainColorLight,
                pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
                highlightAnimation: true,
                highlightAnimationBeginColor: AppColors.mainColorLight,
                highlightAnimationEndColor: AppColors.mainColorLight,
                keyboardType: TextInputType.number,
              ),
              buildSizedBox(buildHeight(context), 0.05),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                height: controller.text.length == 4 ? null : 0,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
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
                                'Verify',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              buildSizedBox(buildHeight(context), 0.02),
              GestureDetector(
                onTap: () {
                  resendOtp(context);
                },
                child: Text('Resend OTP',
                    style: TextStyle(color: Colors.grey, fontSize: 18)),
              )
            ],
          ),
        ),
      )),
    );
  }
}
