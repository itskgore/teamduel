import 'package:flutter/material.dart';

class ContestInfoJoinButton extends StatelessWidget {
  const ContestInfoJoinButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        onPressed: () {},
        child: Text('Join Contest',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
