import 'package:flutter/material.dart';
import 'package:winx/widgets/contestInfoJoinButton.dart';

class InfoDistribution extends StatelessWidget {
  var prize;
  InfoDistribution({Key key, this.prize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              primary: false,
              itemCount: prize.length,
              itemBuilder: (con, i) => ListTile(
                    title: Text(
                      'From #${prize[i].from} To #${prize[i].to}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${prize[i].type} ',
                    ),
                    trailing: Text(
                      '${prize[i].prize} ₹',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  )),
        ),
        ContestInfoJoinButton()
      ],
    );
  }
}
