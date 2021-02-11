import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winx/functions/widgetFunc.dart';

class UserAllTicketInfo extends StatefulWidget {
  String appBarTitle;
  UserAllTicketInfo({Key key, this.appBarTitle}) : super(key: key);

  @override
  _UserAllTicketInfoState createState() => _UserAllTicketInfoState();
}

class _UserAllTicketInfoState extends State<UserAllTicketInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarHome(context, widget.appBarTitle),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              'India - Hyderabad Races',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              primary: false,
              itemCount: 10,
              itemBuilder: (con, i) => Container(
                decoration: boxDecoration.copyWith(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    buildSizedBoxWidth(buildWidth(context), 0.02),
                    Text('Ticket_$i',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    buildSizedBoxWidth(buildWidth(context), 0.03),
                    i == 0
                        ? Icon(
                            FontAwesomeIcons.solidStar,
                            color: Colors.blue,
                            size: 15,
                          )
                        : Container(),
                    Spacer(),
                    buildSizedBoxWidth(buildWidth(context), 0.03),
                    Column(
                      children: <Widget>[
                        Text(
                          '$i',
                        ),
                        buildSizedBox(buildHeight(context), 0.01),
                        Text('Rank'),
                      ],
                    ),
                    buildSizedBoxWidth(buildWidth(context), 0.01),
                    Container(
                      height: buildHeight(context) * 0.05,
                      child: VerticalDivider(
                        color: Colors.black,
                      ),
                    ),
                    buildSizedBoxWidth(buildWidth(context), 0.01),
                    Column(
                      children: <Widget>[
                        Text('${i}12'),
                        buildSizedBox(buildHeight(context), 0.01),
                        Text('PTS'),
                      ],
                    ),
                    buildSizedBoxWidth(buildWidth(context), 0.01),
                    Container(
                      height: buildHeight(context) * 0.05,
                      child: VerticalDivider(
                        color: Colors.black,
                      ),
                    ),
                    buildSizedBoxWidth(buildWidth(context), 0.01),
                    Column(
                      children: <Widget>[
                        Text('${i}22'),
                        buildSizedBox(buildHeight(context), 0.01),
                        Text('PTS'),
                      ],
                    ),
                    buildSizedBoxWidth(buildWidth(context), 0.01),
                    Container(
                      height: buildHeight(context) * 0.05,
                      child: VerticalDivider(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
