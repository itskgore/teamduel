import 'package:flutter/material.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/widgets/contestInfoJoinButton.dart';

class InfoRaceList extends StatelessWidget {
  var info;
  InfoRaceList({Key key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    return Column(
      children: [
        buildSizedBox(buildHeight(context), 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Sr No',
              style: textStyle,
            ),
            Text(
              'Date',
              style: textStyle,
            ),
            Text(
              'Race Center',
              style: textStyle,
            ),
            Text(
              'Status',
              style: textStyle,
            ),
          ],
        ),
        buildSizedBox(buildHeight(context), 0.02),
        Divider(color: Colors.black),
        Expanded(
            child: ListView.builder(
                primary: false,
                itemCount: info.length,
                itemBuilder: (con, i) => Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('${info[i].slNo}'),
                              Text('${info[i].date}'),
                              Text('${info[i].location}'),
                              Text('${info[i].status.toUpperCase()}'),
                            ],
                          ),
                        ),
                        Divider()
                      ],
                    ))),
        ContestInfoJoinButton()
      ],
    );
  }
}
