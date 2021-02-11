import 'dart:io';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/user.dart';

class EditUser extends StatefulWidget {
  String userImg;
  final String email;
  final String birth;
  final String gender;
  final String state;
  final String country;

  EditUser(
      {Key key,
      this.userImg,
      this.email,
      this.birth,
      this.gender,
      this.state,
      this.country})
      : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  Map<String, String> userEdit = {
    'email': '',
    'dob': '',
    'gender': '',
    'country': '',
    'state': '',
    'porfile_pic': '',
  };
  final _formKey = GlobalKey<FormState>();
  String gender;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  bool loading = false;
  bool profileloading = false;
  DateTime _selectedDate;

  List<dynamic> profilePic;
  Future<void> getProfilePic() async {
    final user = Provider.of<User>(context, listen: false);
    setState(() => profileloading = true);
    final res = await user.getProfilePic();
    setState(() => profileloading = false);
    profilePic = res;
    print(profilePic);
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    userEdit['gender'] = gender;
    _formKey.currentState.save();
    final user = Provider.of<User>(context, listen: false);
    setState(() => loading = true);
    final res = await user.editUser(userEdit);
    print(userEdit);
    if (!res['status']) {
      var stringList = res['msg'];

      showSnack(context, stringList, _scaffoldkey);
      return;
    }
    await user.userData();
    setState(() => loading = false);
    showSnack(context, res['msg'], _scaffoldkey);
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void buildDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: buildHeight(context) * 0.80,
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10.0,
                            offset: const Offset(0.0, 10.0),
                          ),
                        ]),
                    child: profileloading
                        ? CircularProgressIndicator()
                        : GridView.builder(
                            itemCount: profilePic.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        (MediaQuery.of(context).orientation ==
                                                Orientation.portrait)
                                            ? 2
                                            : 3),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.userImg =
                                        profilePic[index]['file_url'];
                                    userEdit['porfile_pic'] =
                                        profilePic[index]['file_name'];
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                        profilePic[index]['file_url']),
                                  ),
                                ),
                              );
                            },
                          ),
                  )
                ],
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
    // userEdit['porfile_pic'] = widget.userImg;
    setState(() {
      gender = widget.gender;
    });
    getProfilePic();
    print(gender);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: buildAppBarHome(context, 'Edit User'),
        body: SafeArea(
            child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    buildSizedBox(buildHeight(context), 0.02),
                    Stack(
                      overflow: Overflow.visible,
                      children: [
                        Container(
                          height: buildHeight(context) * 0.15,
                          width: buildHeight(context) * 0.15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      // userEdit['porfile_pic'].isEmpty
                                      widget.userImg
                                      // : userEdit['porfile_pic']
                                      ),
                                  fit: BoxFit.cover)),
                        ),
                        Positioned(
                          top: 50,
                          left: 80,
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 18.0,
                            child: IconButton(
                              icon: Icon(FontAwesomeIcons.pencilAlt),
                              iconSize: 15,
                              onPressed: () {
                                buildDialog(context);
                                // Navigator.push(context,
                                //     FadeNavigation(widget: EditUser()));
                              },
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    buildSizedBox(buildHeight(context), 0.02),
                    TextFormField(
                      initialValue: widget.email,
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
                        userEdit['email'] = value.trim();
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          prefixIcon: Icon(FontAwesomeIcons.user),
                          labelText: 'Email / Mobile No.',
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
                    buildSizedBox(buildHeight(context), 0.04),
                    TextFormField(
                      // onTap: _presentDatePicker,
                      readOnly: true,
                      // initialValue: user.userDetails[0].dob,
                      showCursor: false,

                      controller: TextEditingController(
                          text: _selectedDate == null
                              ? widget.birth
                              : DateFormat('yyyy-MM-dd').format(_selectedDate)),
                      validator: (val) {
                        val = val.trim();
                        if (val.isEmpty) {
                          return 'Please tell us your birth date';
                        }
                      },
                      onSaved: (val) {
                        userEdit['dob'] = val.trim();
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          prefixIcon: Icon(FontAwesomeIcons.birthdayCake),
                          labelText: 'Birth date',
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
                    buildSizedBox(buildHeight(context), 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              gender = 'male';
                            });
                          },
                          child: AnimatedOpacity(
                            opacity: 'male' == gender ? 1 : 0.3,
                            duration: Duration(seconds: 1),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: 'male' == gender
                                        ? Colors.green
                                        : Colors.grey,
                                    width: 'male' == gender ? 2 : 1),
                              ),
                              height: 70,
                              width: 70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  'https://www.nicepng.com/png/detail/780-7805650_generic-user-image-male-man-cartoon-no-eyes.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              gender = 'female';
                            });
                          },
                          child: AnimatedOpacity(
                            opacity: 'female' == gender ? 1 : 0.3,
                            duration: Duration(seconds: 1),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: 'female' == gender
                                        ? Colors.green
                                        : Colors.grey,
                                    width: 'female' == gender ? 2 : 1),
                              ),
                              height: 70,
                              width: 70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  'https://f1.pngfuel.com/png/729/184/894/transparency-user-profile-avatar-computer-watercolor-paint-wet-ink-female-face-head-cartoon-png-clip-art.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              gender = 'gay';
                            });
                          },
                          child: AnimatedOpacity(
                            opacity: 'gay' == gender ? 1 : 0.3,
                            duration: Duration(seconds: 1),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: 'gay' == gender
                                        ? Colors.green
                                        : Colors.grey,
                                    width: gender == 'gay' ? 2 : 1),
                              ),
                              height: 70,
                              width: 70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  'https://img.icons8.com/cotton/2x/gender.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    buildSizedBox(buildHeight(context), 0.04),
                    TextFormField(
                      readOnly: true,
                      initialValue: widget.country,
                      validator: (val) {
                        val = val.trim();
                        if (val.isEmpty) {
                          return 'Please enter your country name';
                        }
                        var count;
                        try {
                          count = CountryPickerUtils.getCountryByName(val);
                        } catch (e) {
                          return 'Please enter a valid country name';
                        }
                        if (count.iso3Code.isEmpty) {
                          return 'Please enter a valid country name';
                        }
                      },
                      onSaved: (val) {
                        userEdit['country'] = val.trim();
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          prefixIcon: Icon(FontAwesomeIcons.flag),
                          labelText: 'Country',
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
                    buildSizedBox(buildHeight(context), 0.04),
                    TextFormField(
                      initialValue: widget.state,
                      validator: (val) {
                        val = val.trim();
                        if (val.isEmpty) {
                          return 'Please enter your state name';
                        }
                      },
                      onSaved: (val) {
                        userEdit['state'] = val.trim();
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          prefixIcon: Icon(FontAwesomeIcons.mapMarked),
                          labelText: 'State',
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
                    buildSizedBox(buildHeight(context), 0.03),
                    loading
                        ? CircularProgressIndicator()
                        : Container(
                            width: buildWidth(context) * 0.75,
                            height: buildHeight(context) * 0.08,
                            child: RaisedButton(
                              onPressed: () {
                                _submit(context);
                              },
                              color: Colors.blue,
                              elevation: 4,
                              animationDuration: Duration(milliseconds: 350),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text(
                                'Update',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        )));
  }
}
