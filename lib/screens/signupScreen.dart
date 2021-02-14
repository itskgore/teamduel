import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/auth.dart';
import 'package:winx/screens/emailVeriScreen.dart';
import 'package:winx/screens/socialLoginScreen.dart';

class SingUp extends StatefulWidget {
  SingUp({Key key}) : super(key: key);

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final _formKey = GlobalKey<FormState>();
  bool _password = false;
  bool _confirmPassword = false;
  bool referCode = false;
  DateTime _selectedDate;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  Map<String, String> userData = {
    'name': '',
    'email': '',
    'country': 'India',
    'dob': '',
    'password': '',
    'refer_id': '',
  };
  String confirmPass = '';
  bool loading = false;
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
      duration: Duration(seconds: 2),
      backgroundColor: Colors.black87,
    ));
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    if (userData['password'] != confirmPass) {
      showSnack(context, 'Password and Confirm password did not match');

      return;
    }
    _formKey.currentState.save();

    final auth = Provider.of<Auth>(context, listen: false);
    setState(() {
      loading = true;
    });
    final res = await auth.signupUser(userData);
    setState(() {
      loading = false;
    });
    var stringList = '';
    if (!res['status']) {
      stringList = res['msg'].join("");

      showSnack(context, stringList);
      return;
    }
    stringList = res['msg'];
    showSnack(context, stringList);
    Navigator.push(
        context,
        SlideNavigation(
            widget: EmailVerify(
          userEmail: userData['email'],
        )));
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  Future buildShowDialog(BuildContext context) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: SafeArea(
          child: Container(
        height: buildHeight(context),
        child: ListView(
          primary: false,
          children: [
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildSizedBox(buildHeight(context), 0.02),
                    Container(
                        width: double.infinity,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/images/Chipsmdpi.png",
                              width: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "100 Welcome Bonus for New User",
                              style: GoogleFonts.poppins(
                                  color: Color.fromRGBO(255, 255, 255, 0.7),
                                  fontSize: 18),
                            )
                          ],
                        )),
                    buildSizedBox(buildHeight(context), 0.05),
                    TextFormField(
                      autocorrect: true,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.white,
                      cursorRadius: Radius.circular(10),
                      validator: (val) {
                        val = val.trim();
                        if (val.isEmpty || val.length <= 2) {
                          return 'Please tell us your name';
                        }
                      },
                      onSaved: (val) {
                        userData['name'] = val.trim();
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: AppColors.mainColorLight,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                        prefixIcon: Icon(
                          FontAwesomeIcons.user,
                          color: Colors.white,
                        ),
                        hintText: 'Your Name',
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 12),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide:
                                BorderSide(color: AppColors.mainColorLight)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide:
                                BorderSide(color: AppColors.mainColorLight)),
                      ),
                    ),
                    buildSizedBox(buildHeight(context), 0.03),
                    TextFormField(
                      autocorrect: true,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      cursorRadius: Radius.circular(10),
                      validator: (value) {
                        value = value.trim();
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);

                        if (value.isEmpty) {
                          return 'Email id is requried!';
                        }
                        if (!emailValid) {
                          return 'Invalid email!';
                        }
                      },
                      onSaved: (value) {
                        userData['email'] = value;
                      },
                      decoration: InputDecoration(
                        fillColor: AppColors.mainColorLight,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        prefixIcon: Icon(
                          FontAwesomeIcons.envelope,
                          color: Colors.white,
                        ),
                        hintText: 'Email / Mobile No.',
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 12),
                        focusedBorder: buildOutlineInputBorder(),
                        border: buildOutlineInputBorder(),
                      ),
                    ),
                    buildSizedBox(buildHeight(context), 0.02),
                    CountryPickerDropdown(
                      initialValue: 'IN',
                      underline: Container(
                        height: 2,
                      ),
                      onTap: () =>
                          FocusScope.of(context).requestFocus(FocusNode()),
                      onValuePicked: (Country country) {
                        print(country.name);
                        userData['country'] = country.name;
                        // _textController.text = '+' + country.phoneCode.toString();
                        // paypal['countryName'] = country.isoCode;
                        // print(paypal['countryName'].toString());
                      },
                      itemBuilder: (Country country) {
                        return Row(
                          children: <Widget>[
                            SizedBox(width: 8.0),
                            CountryPickerUtils.getDefaultFlagImage(country),
                            SizedBox(width: 8.0),
                            Expanded(
                                child: Text(
                              country.name,
                              style: GoogleFonts.poppins(color: Colors.grey),
                            )),
                          ],
                        );
                      },
                      itemHeight: null,
                      isExpanded: true,
                      //initialValue: 'TR',
                      icon: Icon(Icons.arrow_downward),
                    ),
                    buildSizedBox(buildHeight(context), 0.03),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      onTap: _presentDatePicker,
                      validator: (val) {
                        val = val.trim();
                        if (val.isEmpty) {
                          return 'Please tell us your birth date';
                        }
                      },
                      onSaved: (val) {
                        userData['dob'] = val.trim();
                      },
                      showCursor: false,
                      readOnly: true,
                      controller: TextEditingController(
                          text: _selectedDate == null
                              ? ''
                              : DateFormat('yyyy-MM-dd').format(_selectedDate)),
                      cursorRadius: Radius.circular(10),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        prefixIcon: Icon(
                          FontAwesomeIcons.birthdayCake,
                          color: Colors.white,
                        ),
                        hintText: 'Date of birth',
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 12),
                        fillColor: AppColors.mainColorLight,
                        filled: true,
                        focusedBorder: buildOutlineInputBorder(),
                        border: buildOutlineInputBorder(),
                      ),
                    ),
                    buildSizedBox(buildHeight(context), 0.03),
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
                      },
                      onSaved: (val) {
                        userData['password'] = val.trim();
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: AppColors.mainColorLight,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        prefixIcon: IconButton(
                            onPressed: () => setState(() {
                                  _password = !_password;
                                }),
                            icon: Icon(
                              _password
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
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
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        prefixIcon: IconButton(
                            onPressed: () => setState(() {
                                  _confirmPassword = !_confirmPassword;
                                }),
                            icon: Icon(
                              _confirmPassword
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
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
                      height: referCode ? null : 0,
                      child: AnimatedOpacity(
                        opacity: referCode ? 1 : 0,
                        duration: Duration(seconds: 1),
                        child: TextFormField(
                          autocorrect: true,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          cursorRadius: Radius.circular(10),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 15),
                              prefixIcon: Icon(FontAwesomeIcons.code),
                              labelText: 'Refer Code',
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
                      ),
                    ),
                    // if (referCode) buildSizedBox(buildHeight(context), 0.02),
                    buildSizedBox(buildHeight(context), 0.02),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            referCode = !referCode;
                          });
                        },
                        child: Text(
                          'Apply Refer Code ?',
                          style: TextStyle(
                              color: Color.fromRGBO(16, 119, 194, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    buildSizedBox(buildHeight(context), 0.03),
                    loading
                        ? CircularProgressIndicator()
                        : Container(
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
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                    buildSizedBox(buildHeight(context), 0.01),
                    SocialLogin(),
                    buildSizedBox(buildHeight(context), 0.03),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(color: AppColors.mainColorLight));
  }
}
