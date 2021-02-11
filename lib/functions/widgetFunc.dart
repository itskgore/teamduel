import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

SizedBox buildSizedBox(double height, double value) {
  return SizedBox(
    height: height * value,
  );
}

SizedBox buildSizedBoxWidth(double width, double value) {
  return SizedBox(
    width: width * value,
  );
}

double buildWidth(BuildContext context) => MediaQuery.of(context).size.width;

double buildHeight(BuildContext context) => MediaQuery.of(context).size.height;
AppBar buildAppBar(BuildContext context, title) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: Text(
      '$title',
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.transparent,
    leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () => Navigator.of(context).pop()),
  );
}

void showSnack(
    BuildContext context, stringList, GlobalKey<ScaffoldState> _scaffoldkey) {
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

Future showCupertinoPop(Map<String, dynamic> success, BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: new Text(success['msg']),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}

void showSnackSuccess(
    BuildContext context, stringList, GlobalKey<ScaffoldState> _scaffoldkey) {
  _scaffoldkey.currentState.showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    content: Text(
      stringList,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.green),
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.black87,
  ));
}

BoxDecoration buildBoxDecoration() {
  return BoxDecoration(
    gradient: new LinearGradient(
        colors: [
          const Color(0xFF00CCFF),
          const Color(0xFF3366FF),
        ],
        begin: const FractionalOffset(0.0, 0.3),
        end: const FractionalOffset(0.0, 0.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp),
  );
}

BoxDecoration buildBoxDecoration2() {
  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)));
}

AppBar buildAppBarHome(BuildContext context, String text) {
  return AppBar(
    title: Text(text),
    centerTitle: true,
    leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.of(context).pop()),
  );
}

var boxDecoration = BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 6.0,
      ),
    ],
    color: Colors.grey[200],
    border: Border.all(color: Colors.grey, width: 1),
    borderRadius: BorderRadius.circular(20));
