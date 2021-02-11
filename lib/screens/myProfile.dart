import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/user.dart';
import 'package:winx/screens/changePassScreen.dart';
import 'package:winx/screens/changePassword.dart';

import 'editUser.dart';
import 'homeScreen.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('My Profile'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacement(
                  context, DownSlideNavigation(widget: HomeScreen()));
            },
          )),
      body: SafeArea(
          child: Consumer<User>(
        builder: (con, user, _) => user.getUser
            ? CircularProgressIndicator()
            : Container(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                            user.userDetails[0].img),
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
                                      Navigator.push(
                                          context,
                                          FadeNavigation(
                                              widget: EditUser(
                                            birth: user.userDetails[0].dob,
                                            country:
                                                user.userDetails[0].country,
                                            email: user.userDetails[0].email,
                                            gender: user.userDetails[0].gender,
                                            state: user.userDetails[0].state,
                                            userImg: user.userDetails[0].img,
                                          )));
                                    },
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          buildSizedBox(buildHeight(context), 0.02),
                          Text('Team Name: ${user.userDetails[0].team_name}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              )),
                          buildSizedBox(buildHeight(context), 0.05),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              children: [
                                TextFormField(
                                  readOnly: true,
                                  initialValue: user.userDetails[0].email,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      prefixIcon: Icon(FontAwesomeIcons.user),
                                      labelText: 'Email / Mobile No.',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                                buildSizedBox(buildHeight(context), 0.04),
                                TextFormField(
                                  readOnly: true,
                                  initialValue:
                                      user.userDetails[0].dob == 'null'
                                          ? ''
                                          : user.userDetails[0].dob,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      prefixIcon:
                                          Icon(FontAwesomeIcons.birthdayCake),
                                      labelText: 'Birth date',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                                buildSizedBox(buildHeight(context), 0.04),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AnimatedOpacity(
                                      opacity:
                                          'male' == user.userDetails[0].gender
                                              ? 1
                                              : 0.3,
                                      duration: Duration(seconds: 1),
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: 'male' ==
                                                      user.userDetails[0].gender
                                                  ? Colors.green
                                                  : Colors.grey,
                                              width: 'male' ==
                                                      user.userDetails[0].gender
                                                  ? 2
                                                  : 1),
                                        ),
                                        height: 70,
                                        width: 70,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            'https://www.nicepng.com/png/detail/780-7805650_generic-user-image-male-man-cartoon-no-eyes.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    AnimatedOpacity(
                                      opacity:
                                          'female' == user.userDetails[0].gender
                                              ? 1
                                              : 0.3,
                                      duration: Duration(seconds: 1),
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: 'female' ==
                                                      user.userDetails[0].gender
                                                  ? Colors.green
                                                  : Colors.grey,
                                              width: 'female' ==
                                                      user.userDetails[0].gender
                                                  ? 2
                                                  : 1),
                                        ),
                                        height: 70,
                                        width: 70,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            'https://f1.pngfuel.com/png/729/184/894/transparency-user-profile-avatar-computer-watercolor-paint-wet-ink-female-face-head-cartoon-png-clip-art.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    AnimatedOpacity(
                                      opacity:
                                          'gay' == user.userDetails[0].gender
                                              ? 1
                                              : 0.3,
                                      duration: Duration(seconds: 1),
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: 'gay' ==
                                                      user.userDetails[0].gender
                                                  ? Colors.green
                                                  : Colors.grey,
                                              width:
                                                  user.userDetails[0].gender ==
                                                          'gay'
                                                      ? 2
                                                      : 1),
                                        ),
                                        height: 70,
                                        width: 70,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            'https://img.icons8.com/cotton/2x/gender.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                buildSizedBox(buildHeight(context), 0.04),
                                TextFormField(
                                  readOnly: true,
                                  initialValue: user.userDetails[0].country,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      prefixIcon: Icon(FontAwesomeIcons.flag),
                                      labelText: 'Country',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                                buildSizedBox(buildHeight(context), 0.04),
                                TextFormField(
                                  readOnly: true,
                                  initialValue: user.userDetails[0].state,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      prefixIcon:
                                          Icon(FontAwesomeIcons.mapMarked),
                                      labelText: 'State',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                DownSlideNavigation(widget: ResetPassword()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey[300], width: 1),
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Change\nPassword",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      )),
    );
  }

  AnimatedOpacity buildGenderWidget(String gen, String img) {
    return AnimatedOpacity(
      opacity: gender == gen ? 1 : 0.3,
      duration: Duration(seconds: 1),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: gender == gen ? Colors.green : Colors.grey,
              width: gender == gen ? 2 : 1),
        ),
        height: 70,
        width: 70,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            img,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
