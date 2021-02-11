import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/user.dart';

class UploadDoc extends StatefulWidget {
  UploadDoc({Key key}) : super(key: key);

  @override
  _UploadDocState createState() => _UploadDocState();
}

class _UploadDocState extends State<UploadDoc> {
  bool loading = false;
  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        backgroundColor: Colors.grey[200],
        elevation: 5,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (builder) {
          return Container(
            height: 200.0,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: buildHeight(context) * 0.10,
                  child: OutlineButton(
                    splashColor: Colors.teal[200],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.grey, width: 2)),
                    onPressed: () {
                      getImageFromCamera();
                      Navigator.of(context).pop();
                    },
                    color: Colors.blue,
                    child: Icon(FontAwesomeIcons.camera),
                  ),
                ),
                Container(
                  height: buildHeight(context) * 0.10,
                  child: OutlineButton(
                    splashColor: Colors.teal[200],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.grey, width: 2)),
                    onPressed: () {
                      getImageFromGallery();
                      Navigator.of(context).pop();
                    },
                    color: Colors.blue,
                    child: Icon(FontAwesomeIcons.photoVideo),
                  ),
                )
              ],
            ),
          );
        });
  }

  File imageURI;
  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imageURI = image;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageURI = image;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  Future<void> _submit(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    setState(() => loading = true);
    final res = await user.uploadDoc(imageURI);
    setState(() => loading = false);
    var stringList = res['msg'];
    if (!res['status']) {
      showSnack(context, stringList, _scaffoldkey);
      return;
    }
    showSnack(context, stringList, _scaffoldkey);
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: buildAppBarHome(context, 'KYC Registration'),
      body: SafeArea(
        child: Container(
          color: Colors.grey[300],
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _modalBottomSheetMenu();
                  },
                  child: Container(
                    height: buildHeight(context) * 0.60,
                    width: double.infinity,
                    child: imageURI == null
                        ? Container(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: buildHeight(context) * 0.15),
                              child: Text(
                                'Click here to Select Image',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://reactnativecode.com/wp-content/uploads/2018/02/Default_Image_Thumbnail.png'),
                                    fit: BoxFit.cover)),
                          )
                        : Image.file(imageURI, fit: BoxFit.cover),
                  ),
                ),
                buildSizedBox(buildHeight(context), 0.02),
                AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: imageURI == null ? 0 : 1,
                  child: Container(
                    width: buildWidth(context) * 0.65,
                    height: buildHeight(context) * 0.08,
                    child: RaisedButton(
                      onPressed: () {
                        // _modalBottomSheetMenu();
                        _submit(context);
                      },
                      color: Colors.blue,
                      elevation: 4,
                      animationDuration: Duration(milliseconds: 350),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: loading
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.red,
                            )
                          : Text(
                              'Upload',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                    ),
                  ),
                ),
                buildSizedBox(buildHeight(context), 0.04),
                Text('3 lines KYC registration instructions.......',
                    style: TextStyle(
                      color: Colors.black,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
