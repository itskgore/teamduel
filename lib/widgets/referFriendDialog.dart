import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winx/providers/user.dart';

class CustomDialog extends StatefulWidget {
  final String title, buttonText;
  final Image image;

  CustomDialog({
    @required this.title,
    @required this.buttonText,
    this.image,
  });

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  Map<String, String> refer = {
    'email': '',
    'user_id': '',
  };
  String error = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  void showSnack(BuildContext context, stringList) {
    Scaffold.of(context).showSnackBar(SnackBar(
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
    _formKey.currentState.save();
    final user = Provider.of<User>(context, listen: false);
    setState(() => loading = true);
    final res = await user.referFriend(refer);
    print(res);
    setState(() => loading = false);
    if (!res['status']) {
      this.error = res['msg'].join("");
      // showSnack(context, res['msg']);
      return;
    }
    this.error = 'Refer Code sent to your friend';
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  String gender;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: Consts.avatarRadius + Consts.padding,
              bottom: Consts.padding,
              left: Consts.padding,
              right: Consts.padding,
            ),
            margin: EdgeInsets.only(top: Consts.avatarRadius),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Consts.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                Form(
                  key: _formKey,
                  child: TextFormField(
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
                      refer['email'] = value;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        prefixIcon: Icon(FontAwesomeIcons.user),
                        labelText: 'Share via Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white))),
                  ),
                ),
                SizedBox(height: 10.0),
                Text('OR'),
                SizedBox(height: 10.0),
                RaisedButton(
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: ListTile(
                      title: Text(
                        'Whats App Share',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing:
                          Icon(FontAwesomeIcons.whatsapp, color: Colors.green),
                    ),
                    onPressed: () {}),
                SizedBox(height: 14.0),
                AnimatedOpacity(
                    duration: Duration(seconds: 1),
                    opacity: error.isEmpty ? 0 : 1,
                    child: Text(
                      error.isEmpty ? '' : error,
                      style: TextStyle(
                          color: error == 'Refer Code sent to your friend'
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    onPressed: () {
                      _submit(context);
                      // Navigator.of(context).pop(); // To close the dialog
                    },
                    child: loading
                        ? CircularProgressIndicator()
                        : Text(widget.buttonText),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: Consts.avatarRadius,
          ),
        ),
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
