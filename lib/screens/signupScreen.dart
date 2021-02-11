import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
      key: _scaffoldkey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
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
                      child: Text(
                        "Let's Get Started!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 33, fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildSizedBox(buildHeight(context), 0.05),
                    TextFormField(
                      autocorrect: true,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
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
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                          prefixIcon: Icon(FontAwesomeIcons.user),
                          labelText: 'Your Name',
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
                      autocorrect: true,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
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
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                          prefixIcon: Icon(FontAwesomeIcons.envelope),
                          labelText: 'Your Email',
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
                            Expanded(child: Text(country.name)),
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
                          prefixIcon: Icon(FontAwesomeIcons.birthdayCake),
                          labelText: 'Date of birth',
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
                        if (val.isEmpty || val.length <= 3) {
                          return 'Password should have more than 3 characters';
                        }
                      },
                      onSaved: (val) {
                        userData['password'] = val.trim();
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                          prefixIcon: IconButton(
                              onPressed: () => setState(() {
                                    _password = !_password;
                                  }),
                              icon: Icon(_password
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye)),
                          labelText: 'Password',
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
                        if (val.isEmpty || val.length <= 3) {
                          return 'Password should have more than 3 characters';
                        }
                      },
                      onSaved: (val) {
                        confirmPass = val.trim();
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
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
                    buildSizedBox(buildHeight(context), 0.03),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          referCode = !referCode;
                        });
                      },
                      child: Text(
                        'Apply Refer Code ?',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    buildSizedBox(buildHeight(context), 0.02),
                    loading
                        ? CircularProgressIndicator()
                        : Container(
                            width: buildWidth(context) * 0.65,
                            height: buildHeight(context) * 0.08,
                            child: RaisedButton(
                              onPressed: () {
                                _submit(context);
                              },
                              color: Colors.blue,
                              elevation: 4,
                              animationDuration: Duration(milliseconds: 350),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                'SIGNUP',
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
}
