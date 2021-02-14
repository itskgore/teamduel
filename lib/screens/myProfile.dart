import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/user.dart';
import 'package:winx/screens/changePassScreen.dart';
import 'package:winx/screens/changePassword.dart';
import 'package:winx/screens/cricket/matchups/matchUpsHome.dart';

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
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Text('Profile'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context, DownSlideNavigation(widget: MatchUpHome()));
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
                              // Positioned(
                              //   top: 50,
                              //   left: 80,
                              //   child: CircleAvatar(
                              //     backgroundColor: Colors.green,
                              //     radius: 18.0,
                              //     child: IconButton(
                              //       icon: Icon(FontAwesomeIcons.pencilAlt),
                              //       iconSize: 15,
                              //       onPressed: () {

                              //       },
                              //       color: Colors.white,
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                          buildSizedBox(buildHeight(context), 0.03),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            width: double.infinity,
                            alignment: Alignment.topLeft,
                            child: Text('Personal Information',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(186, 196, 208, 0.91),
                                )),
                          ),
                          buildSizedBox(buildHeight(context), 0.02),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              children: [
                                fieldsContainer(
                                    "Full Name", user.userDetails[0].name),
                                buildSizedBox(buildHeight(context), 0.01),
                                fieldsContainer(
                                    "Email-id", user.userDetails[0].email),

                                // TextFormField(
                                //     readOnly: true,
                                //     initialValue: user.userDetails[0].email,
                                //     style: GoogleFonts.poppins(
                                //         color: Colors.white),
                                //     decoration: InputDecoration(
                                //       fillColor: AppColors.mainColorLight,
                                //       filled: true,
                                //       contentPadding:
                                //           EdgeInsets.symmetric(vertical: 10),
                                //       prefixIcon: Icon(
                                //         FontAwesomeIcons.envelope,
                                //         color: Colors.white,
                                //       ),
                                //       hintText: 'Email / Mobile No.',
                                //       focusedBorder: buildOutlineInputBorder(),
                                //       border: buildOutlineInputBorder(),
                                //     )),
                                buildSizedBox(buildHeight(context), 0.01),
                                fieldsContainer(
                                    "Birthday",
                                    user.userDetails[0].dob == 'null'
                                        ? ''
                                        : user.userDetails[0].dob),

                                // TextFormField(
                                //   readOnly: true,
                                //   style:
                                //       GoogleFonts.poppins(color: Colors.white),
                                //   initialValue:
                                //       user.userDetails[0].dob == 'null'
                                //           ? ''
                                //           : user.userDetails[0].dob,
                                //   decoration: InputDecoration(
                                //     fillColor: AppColors.mainColorLight,
                                //     filled: true,
                                //     contentPadding:
                                //         EdgeInsets.symmetric(vertical: 10),
                                //     prefixIcon: Icon(
                                //       FontAwesomeIcons.birthdayCake,
                                //       color: Colors.white,
                                //     ),
                                //     hintText: 'Birth date',
                                //     focusedBorder: buildOutlineInputBorder(),
                                //     border: buildOutlineInputBorder(),
                                //   ),
                                // ),
                                buildSizedBox(buildHeight(context), 0.01),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceEvenly,
                                //   children: [
                                //     AnimatedOpacity(
                                //       opacity:
                                //           'male' == user.userDetails[0].gender
                                //               ? 1
                                //               : 0.3,
                                //       duration: Duration(seconds: 1),
                                //       child: Container(
                                //         padding: EdgeInsets.all(5),
                                //         decoration: BoxDecoration(
                                //           borderRadius:
                                //               BorderRadius.circular(50),
                                //           border: Border.all(
                                //               color: 'male' ==
                                //                       user.userDetails[0].gender
                                //                   ? Colors.green
                                //                   : Colors.grey,
                                //               width: 'male' ==
                                //                       user.userDetails[0].gender
                                //                   ? 2
                                //                   : 1),
                                //         ),
                                //         height: 70,
                                //         width: 70,
                                //         child: ClipRRect(
                                //           borderRadius:
                                //               BorderRadius.circular(50),
                                //           child: Image.network(
                                //             'https://www.nicepng.com/png/detail/780-7805650_generic-user-image-male-man-cartoon-no-eyes.png',
                                //             fit: BoxFit.cover,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     AnimatedOpacity(
                                //       opacity:
                                //           'female' == user.userDetails[0].gender
                                //               ? 1
                                //               : 0.3,
                                //       duration: Duration(seconds: 1),
                                //       child: Container(
                                //         padding: EdgeInsets.all(5),
                                //         decoration: BoxDecoration(
                                //           borderRadius:
                                //               BorderRadius.circular(50),
                                //           border: Border.all(
                                //               color: 'female' ==
                                //                       user.userDetails[0].gender
                                //                   ? Colors.green
                                //                   : Colors.grey,
                                //               width: 'female' ==
                                //                       user.userDetails[0].gender
                                //                   ? 2
                                //                   : 1),
                                //         ),
                                //         height: 70,
                                //         width: 70,
                                //         child: ClipRRect(
                                //           borderRadius:
                                //               BorderRadius.circular(50),
                                //           child: Image.network(
                                //             'https://f1.pngfuel.com/png/729/184/894/transparency-user-profile-avatar-computer-watercolor-paint-wet-ink-female-face-head-cartoon-png-clip-art.png',
                                //             fit: BoxFit.cover,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     AnimatedOpacity(
                                //       opacity:
                                //           'gay' == user.userDetails[0].gender
                                //               ? 1
                                //               : 0.3,
                                //       duration: Duration(seconds: 1),
                                //       child: Container(
                                //         padding: EdgeInsets.all(5),
                                //         decoration: BoxDecoration(
                                //           borderRadius:
                                //               BorderRadius.circular(50),
                                //           border: Border.all(
                                //               color: 'gay' ==
                                //                       user.userDetails[0].gender
                                //                   ? Colors.green
                                //                   : Colors.grey,
                                //               width:
                                //                   user.userDetails[0].gender ==
                                //                           'gay'
                                //                       ? 2
                                //                       : 1),
                                //         ),
                                //         height: 70,
                                //         width: 70,
                                //         child: ClipRRect(
                                //           borderRadius:
                                //               BorderRadius.circular(50),
                                //           child: Image.network(
                                //             'https://img.icons8.com/cotton/2x/gender.png',
                                //             fit: BoxFit.cover,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // buildSizedBox(buildHeight(context), 0.02),
                                fieldsContainer(
                                    "Country", user.userDetails[0].country),
                                // TextFormField(
                                //   style:
                                //       GoogleFonts.poppins(color: Colors.white),
                                //   readOnly: true,
                                //   initialValue: user.userDetails[0].country,
                                //   decoration: InputDecoration(
                                //     fillColor: AppColors.mainColorLight,
                                //     filled: true,
                                //     contentPadding:
                                //         EdgeInsets.symmetric(vertical: 10),
                                //     prefixIcon: Icon(
                                //       FontAwesomeIcons.flag,
                                //       color: Colors.white,
                                //     ),
                                //     hintText: 'Country',
                                //     focusedBorder: buildOutlineInputBorder(),
                                //     border: buildOutlineInputBorder(),
                                //   ),
                                // ),
                                buildSizedBox(buildHeight(context), 0.01),
                                fieldsContainer(
                                    "State", user.userDetails[0].state),
                                // TextFormField(
                                //   readOnly: true,
                                //   style:
                                //       GoogleFonts.poppins(color: Colors.white),
                                //   initialValue: user.userDetails[0].state,
                                //   decoration: InputDecoration(
                                //     fillColor: AppColors.mainColorLight,
                                //     filled: true,
                                //     contentPadding:
                                //         EdgeInsets.symmetric(vertical: 10),
                                //     prefixIcon: Icon(
                                //       FontAwesomeIcons.mapMarked,
                                //       color: Colors.white,
                                //     ),
                                //     hintText: 'State',
                                //     focusedBorder: buildOutlineInputBorder(),
                                //     border: buildOutlineInputBorder(),
                                //   ),
                                // ),
                                buildSizedBox(buildHeight(context), 0.03),
                                Container(
                                  width: double.infinity,
                                  alignment: Alignment.topLeft,
                                  child: Text('Account Setting',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromRGBO(186, 196, 208, 0.91),
                                      )),
                                ),
                                buildSizedBox(buildHeight(context), 0.03),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        DownSlideNavigation(
                                            widget: ResetPassword()));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColorLight,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Change Password",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                buildSizedBox(buildHeight(context), 0.04),
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
                            Navigator.push(
                                context,
                                FadeNavigation(
                                    widget: EditUser(
                                  birth: user.userDetails[0].dob,
                                  country: user.userDetails[0].country,
                                  email: user.userDetails[0].email,
                                  gender: user.userDetails[0].gender,
                                  state: user.userDetails[0].state,
                                  userImg: user.userDetails[0].img,
                                )));
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: AppColors.buttonColor,
                                border: Border.all(
                                    color: AppColors.buttonColor, width: 1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "Edit Account",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
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

  Container fieldsContainer(String key, String value) {
    return Container(
      width: double.infinity,
      height: 55,
      padding: EdgeInsets.only(top: 5, left: 10, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.mainColorLight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "$key",
            style:
                GoogleFonts.poppins(fontSize: 10, color: AppColors.labelColor),
          ),
          Text(
            "$value",
            style: GoogleFonts.poppins(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
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
