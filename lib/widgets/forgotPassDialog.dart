import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/auth.dart';
import 'package:winx/screens/changePassScreen.dart';

class ForgotPasswordDialog extends StatefulWidget {
  static const double padding = 20.0;

  ForgotPasswordDialog({Key key}) : super(key: key);

  @override
  _ForgotPasswordDialogState createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  Map<String, String> _authData = {
    'email': '',
  };
  bool _isLoading = false;
  bool error = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final auth = Provider.of<Auth>(context, listen: false);
    setState(() => _isLoading = true);
    final res = await auth.forgotPassword(_authData['email']);
    setState(() => _isLoading = false);
    if (res['status']) {
      Navigator.push(
          context,
          FadeNavigation(
              widget: ChangePassword(
            email: _authData['email'],
            user_id: res['id'].toString(),
          )));
    } else {
      setState(() => error = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ForgotPasswordDialog.padding),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(ForgotPasswordDialog.padding),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius:
                    BorderRadius.circular(ForgotPasswordDialog.padding),
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
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'LOGO',
                          style: TextStyle(fontSize: 28),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email-id / Mobile No.',
                          prefixIcon: Icon(FontAwesomeIcons.envelopeOpen),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2)),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          value = value.trim();
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Invalid email!';
                          }
                          if (!emailValid) {
                            return 'Invalid email!';
                          }
                        },
                        onSaved: (value) {
                          _authData['email'] = value.trim();
                        },
                      ),
                      SizedBox(height: 2),
                      error
                          ? Text(
                              'Username is not registered with us',
                              style: TextStyle(color: Colors.red),
                            )
                          : Container(),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _isLoading
                              ? CircularProgressIndicator()
                              : RaisedButton(
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 10),
                                    child: _isLoading
                                        ? CircularProgressIndicator(
                                            backgroundColor: Colors.white)
                                        : Text(
                                            'Verify',
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                  onPressed: () async {
                                    _submit(context);
                                    // Navigator.of(context)
                                    //     .pop();
                                    // _submitForgotPassword();
                                    // Navigator.of(context).pushNamed(
                                    //     ForgotPass.routeName,
                                    //     arguments: {
                                    //       'email': 'karangore518@gmail.com'
                                    //     });
                                  },
                                ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
