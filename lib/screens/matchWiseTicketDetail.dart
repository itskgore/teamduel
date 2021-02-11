import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winx/functions/widgetFunc.dart';

class MatchWiseTicketDetail extends StatefulWidget {
  String appbarTitle;
  MatchWiseTicketDetail({Key key, this.appbarTitle}) : super(key: key);

  @override
  _MatchWiseTicketDetailState createState() => _MatchWiseTicketDetailState();
}

class _MatchWiseTicketDetailState extends State<MatchWiseTicketDetail> {
  final List<Map<String, String>> listUserType = [
    {
      'name': 'Ticket 1',
      'budget': '15000',
    },
    {
      'name': 'Ticket 2',
      'budget': '15000',
    },
    {
      'name': 'Ticket 3',
      'budget': '15000',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarHome(context, widget.appbarTitle),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          buildSizedBox(buildHeight(context), 0.02),
          Container(
              width: double.infinity,
              alignment: Alignment.topCenter,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        flex: 1,
                        child: DropdownButtonFormField(
                            onChanged: (val) {},
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.movie_creation),
                              hintText: 'Stable 1',
                              filled: true,
                              fillColor: Colors.white,
                              errorStyle: TextStyle(color: Colors.yellow),
                            ),
                            items: listUserType.map((map) {
                              return DropdownMenuItem(
                                child: Text(map['name']),
                                value: map['name'],
                              );
                            }).toList())),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Total Score: 450 PTS\nStable: 1',
                          textAlign: TextAlign.center,
                          style: TextStyle(height: 1.5, fontSize: 15),
                        ))
                  ])),
          buildSizedBox(buildHeight(context), 0.02),
          Expanded(
            child: ListView.builder(
                primary: false,
                itemCount: 10,
                itemBuilder: (con, i) => Container(
                      child: Column(
                        children: <Widget>[
                          ExpansionTile(
                            title: Text('Hyderbad - Race $i'),
                            subtitle: Text('Score 25$i'),
                            children: List.generate(
                                2,
                                (index) => Column(
                                      children: <Widget>[
                                        index == 0
                                            ? Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10),
                                                decoration:
                                                    boxDecoration.copyWith(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    Text(
                                                      'H.No',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      'H Name',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      'Result',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      'Sel.Time',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      'Score',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1)),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 10),
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              CircleAvatar(
                                                maxRadius: 12,
                                                backgroundColor:
                                                    Colors.blue[200],
                                              ),
                                              buildSizedBoxWidth(
                                                  buildWidth(context), 0.02),
                                              Text('Moonlight\nRomance'),
                                              buildSizedBoxWidth(
                                                  buildWidth(context), 0.03),
                                              Text('${index}nd'),
                                              buildSizedBoxWidth(
                                                  buildWidth(context), 0.03),
                                              Text('$i times'),
                                              buildSizedBoxWidth(
                                                  buildWidth(context), 0.01),
                                              Column(
                                                children: <Widget>[
                                                  Text(
                                                    '${i}*60=300\nPTS',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                          ),
                          Divider(
                            color: Colors.black,
                          )
                        ],
                      ),
                    )),
          )
        ],
      )),
    );
  }
}
