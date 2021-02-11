import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/horse.dart';
import 'package:winx/providers/user.dart';

class JoinTicketMegaGrand extends StatefulWidget {
  final String title, buttonText;
  final String image;
  final String contestId;
  final String matchId;
  final int limit;

  JoinTicketMegaGrand({
    @required this.title,
    @required this.buttonText,
    this.image,
    this.contestId,
    this.matchId,
    this.limit,
  });

  @override
  _JoinTicketMegaGrandState createState() => _JoinTicketMegaGrandState();
}

class _JoinTicketMegaGrandState extends State<JoinTicketMegaGrand> {
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

  Map<String, String> rigesterMatch = {
    'userid': '',
    'contestid': '',
    'matchid': '',
    'tickets': '',
  };
  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    rigesterMatch['contestid'] = widget.contestId;
    rigesterMatch['matchid'] = widget.matchId;

    final jointMatch = Provider.of<HorseProvider>(context, listen: false);
    setState(() => loading = true);
    final res = await jointMatch.registerMegaMatch(
        contestId: int.parse(widget.contestId),
        tickets: int.parse(rigesterMatch['tickets']),
        matchid: int.parse(widget.matchId));

    // print(res);
    if (!res['status']) {
      setState(() => loading = false);

      this.error = '${res['msg']}';
      return;
    }
    final res2 = await jointMatch.jointMatch(widget.contestId);
    setState(() => loading = false);

    if (!res2['status']) {
      setState(() => loading = false);

      this.error = '${res2['msg']}';
      return;
    }
    this.error = 'Tickets added and new data fetched';
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
                buildSizedBox(buildHeight(context), 0.02),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                buildSizedBox(buildHeight(context), 0.05),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      value = value.trim();

                      if (value.isEmpty) {
                        return 'Enter the no. of tickets';
                      }
                      if (int.parse(value) > widget.limit) {
                        return "Can't get tickets above ${widget.limit}";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      rigesterMatch['tickets'] = value;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        prefixIcon: Icon(Icons.card_membership),
                        labelText: 'Enter Tickets Count',
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
          left: buildWidth(context) * 0.21,
          child: CircleAvatar(
            backgroundImage: NetworkImage(widget.image),
            radius: 70,
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
