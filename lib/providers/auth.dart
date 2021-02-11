import 'dart:convert';

import 'package:flutter/cupertino.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winx/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:winx/models/userLogin.dart';

import '../secrete.dart';

class Auth with ChangeNotifier {
  String _token = '';
  int _userId;
  List<User> _userData = [];
  List<UserLogin> _userLogin = [];
  bool signupLoading = false;
  bool loginLoading = false;
  List<User> get userData {
    return [..._userData];
  }

  List<UserLogin> get userLogin {
    return [..._userLogin];
  }

  Future<bool> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      this.saveToken();
      return true;
    }
    return false;
  }

  Future<void> saveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this._token = prefs.get('token');
    this._userId = prefs.get('userId');
  }

  Map<String, String> headers = {
    "Content-Type": "application/x-www-form-urlencoded",
  };
  Future<Map<String, dynamic>> signupUser(Map<String, String> userData) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      final res = await http.post('http://app.myteamduel.com/api/v1/user',
          headers: headers, body: userData);
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      // print(response['data']['name']);
      if (response['error'] != null || !response['status']) {
        resp['msg'] = response['error'];
        resp['status'] = response['status'];
        return resp;
      }
      _userData.clear();
      _userData.add(User(
        bonusChips: response['data']['bonus_chips'],
        country: response['data']['country'],
        dob: response['data']['dob'],
        email: response['data']['email'],
        id: response['data']['id'],
        img: response['data']['img'],
        mobileNumber: response['data']['mobile_number'],
        name: response['data']['name'],
        referalCode: response['data']['referal_code'],
        roleId: response['data']['role_id'],
        status: response['data']['status'],
        teamName: response['data']['team_name'],
      ));
      print('done');
      resp['msg'] = 'Please Verify Your Email-Id';
      resp['status'] = true;
      // notifyListeners();
      return resp;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Map<String, dynamic>> loginUser(Map<String, String> userData) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      final res = await http.post(
          'http://app.myteamduel.com/api/v1/user-signin',
          headers: headers,
          body: userData);
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      if (!response['status']) {
        print('eerr');
        resp['msg'] = response['error'];
        resp['status'] = response['status'];
        return resp;
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response['data']['password_token']);
      this._token = response['data']['password_token'];
      prefs.setInt('userId', response['data']['id']);
      this._userId = response['data']['id'];
      // print(response['data']);
      _userLogin.add(UserLogin(
        adminType: response['data']['admin_type'].toString(),
        bonusChips: response['data']['bonus_chips'].toString(),
        city: response['data']['city'].toString(),
        country: response['data']['country'].toString(),
        dob: response['data']['dob'].toString(),
        email: response['data']['email'].toString(),
        gender: response['data']['gender'].toString(),
        id: response['data']['id'],
        img: response['data']['img'].toString(),
        lastLogin: response['data']['last_login'].toString(),
        mobileNumber: response['data']['mobile_number'].toString(),
        name: response['data']['name'].toString(),
        passwordToken: response['data']['password_token'].toString(),
        pincode: response['data']['pincode'].toString(),
        provider: response['data']['provider'].toString(),
        providerId: response['data']['provider_id'].toString(),
        referalCode: response['data']['referal_code'].toString(),
        roleId: response['data']['role_id'],
        state: response['data']['state'].toString(),
        status: response['data']['status'],
        teamName: response['data']['team_name'].toString(),
        userWalletCurrentAmount:
            response['data']['user_wallet_current_amount'].toString(),
        winnings: response['data']['winnings'].toString(),
      ));
      // print('here');
      // print(this._userLogin.length);
      resp['msg'] = 'User Authenticated!';
      resp['status'] = true;
      return resp;
    } catch (e) {
      print(e.toString());
      resp['msg'] = 'Something went wrong please try again!';
      resp['status'] = false;
      return resp;
    }
  }

  Future<Map<String, dynamic>> googleLogin() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
      GoogleSignInAccount _currentUser;
      await _googleSignIn.signOut();
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      print(googleSignInAccount.id);
      // print(googleSignInAuthentication.accessToken);
      Map<String, String> userData = {
        "email": googleSignInAccount.email,
        "name": googleSignInAccount.displayName,
        "provider": "google",
        "provider_id": googleSignInAccount.id,
      };
      final res = await http.post(
          'http://app.myteamduel.com/api/v1/social-media-login',
          headers: headers,
          body: userData);
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      print(response);
      if (!response['status']) {
        print('false in error');
        print(response);
        resp['msg'] = response['error'];
        resp['status'] = response['status'];
        return resp;
      }
      _userLogin.clear();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this._token = response['data']['password_token'];
      prefs.setString('token', response['data']['password_token']);
      prefs.setInt('userId', response['data']['id']);
      this._userId = response['data']['id'];
      print(response['data']['password_token']);
      _userLogin.add(UserLogin(
        adminType: response['data']['admin_type'].toString(),
        bonusChips: response['data']['bonus_chips'].toString(),
        city: response['data']['city'],
        country: response['data']['country'],
        dob: response['data']['dob'].toString(),
        email: response['data']['email'],
        gender: response['data']['gender'],
        id: response['data']['id'],
        img: response['data']['img'],
        lastLogin: response['data']['last_login'],
        mobileNumber: response['data']['mobile_number'],
        name: response['data']['name'],
        passwordToken: response['data']['password_token'],
        pincode: response['data']['pincode'],
        provider: response['data']['provider'],
        providerId: response['data']['provider_id'],
        referalCode: response['data']['referl_code'],
        roleId: response['data']['role_id'],
        state: response['data']['state'],
        status: response['data']['status'],
        teamName: response['data']['team_name'],
        userWalletCurrentAmount: response['data']['user_wallet_current_amount'],
        winnings: response['data']['winnings'],
      ));
      print('doneeeeeeeeeeeeeeeeeeeeeeeeeee');
      resp['msg'] = response['msg'];
      resp['status'] = response['status'];
      return resp;
    } catch (e) {
      print(e.toString());
      resp['msg'] = 'Something when wrong please try again!';
      resp['status'] = false;
      return resp;
    }

    // print(googleSignInAuthentication);
  }

  Future<Map<String, dynamic>> resendOTP(String email) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      final res = await http.post(
          'http://app.myteamduel.com/api/v1/resend-verification',
          headers: headers,
          body: {"email": email});
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      print(response);
      if (response['error'] != null || !response['status']) {
        resp['msg'] = response['msg'];
        resp['status'] = response['status'];
        return resp;
      }
      resp['msg'] = 'Verfication Code sent to $email';
      resp['status'] = true;
      return resp;
    } catch (e) {
      resp['msg'] = 'Something went wrong please try again!';
      resp['status'] = false;
      return resp;
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false, 'id': ''};
    try {
      final res = await http.post(
          'http://app.myteamduel.com/api/v1/forgot-password',
          headers: headers,
          body: {"user_id": email});
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      print(response);
      if (response['error'] != null || !response['status']) {
        resp['msg'] = response['error'];
        resp['status'] = response['status'];
        return resp;
      }
      resp['msg'] = 'Otp sent on $email';
      resp['status'] = true;
      resp['id'] = response['data']['id'];
      return resp;
    } catch (e) {
      print(e.toString());
      resp['msg'] = 'Something went wrong please try again!';
      resp['status'] = false;
      return resp;
    }
  }

  Future<Map<String, dynamic>> emailVerify(Map<String, String> userdata) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      final res = await http.post(
          'http://app.myteamduel.com/api/v1/email-verification',
          headers: headers,
          body: userdata);
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      print(response['msg']);
      if (!response['status']) {
        resp['msg'] = response['msg'];
        resp['status'] = response['status'];
        return resp;
      }
      resp['msg'] = response['msg'];
      resp['status'] = true;
      return resp;
    } catch (e) {
      print(e.toString());
      resp['msg'] = 'Something went wrong please try again!';
      resp['status'] = false;
      return resp;
    }
  }

  Future<Map<String, dynamic>> loginFacebook() async {
    // final facebookLogin = FacebookLogin();
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    // try {
    //   final result = await facebookLogin.logIn(['email']);
    //   final token = result.accessToken.token;
    //   final graphResponse = await http.get(
    //       'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
    //   final profile = json.decode(graphResponse.body);
    //   print(profile);
    //   if (profile.containsKey('email')) {
    //     Map<String, String> userData = {
    //       "email": profile['email'],
    //       "name": profile['first_name'] + profile['last_name'],
    //       "provider": "facebook",
    //       "provider_id": profile['id'],
    //     };
    //     final res = await http.post(
    //         'http://app.myteamduel.com/api/v1/social-media-login',
    //         headers: headers,
    //         body: userData);
    //     final response = json.decode(res.body) as Map<dynamic, dynamic>;
    //     print(response);
    //     if (response['error'] != null || !response['status']) {
    //       resp['msg'] = response['error'];
    //       resp['status'] = response['status'];
    //       return resp;
    //     }
    //     SharedPreferences prefs = await SharedPreferences.getInstance();
    //     this._token = response['data']['password_token'];
    //     prefs.setInt('userId', response['data']['id']);
    //     this._userId = response['data']['id'];

    //     prefs.setString('token', response['data']['password_token']);
    //     _userLogin.add(UserLogin(
    //       adminType: response['data']['admin_type'],
    //       bonusChips: response['data']['bonus_chips'],
    //       city: response['data']['city'],
    //       country: response['data']['country'],
    //       dob: response['data']['dob'].toString(),
    //       email: response['data']['email'],
    //       gender: response['data']['gender'],
    //       id: response['data']['id'],
    //       img: response['data']['img'],
    //       lastLogin: response['data']['last_login'],
    //       mobileNumber: response['data']['mobile_number'],
    //       name: response['data']['name'],
    //       passwordToken: response['data']['password_token'],
    //       pincode: response['data']['pincode'],
    //       provider: response['data']['provider'],
    //       providerId: response['data']['provider_id'],
    //       referalCode: response['data']['referl_code'],
    //       roleId: response['data']['role_id'],
    //       state: response['data']['state'],
    //       status: response['data']['status'],
    //       teamName: response['data']['team_name'],
    //       userWalletCurrentAmount: response['data']
    //           ['user_wallet_current_amount'],
    //       winnings: response['data']['winnings'],
    //     ));
    //     print('done');
    //     resp['msg'] = response['msg'];
    //     resp['status'] = response['status'];
    //     return response;
    //   } else {
    //     resp['msg'] =
    //         "Your facebook account doesn't provide a email-id.\nPlease login with other platform";
    //     resp['status'] = false;
    //     return resp;
    //   }
    // } catch (e) {
    //   resp['msg'] = "Something went wrong please try again later!";
    //   resp['status'] = false;
    // }
  }

  Future<Map<String, dynamic>> changePassword(
      Map<String, String> userData) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      final res = await http.post(
          'http://app.myteamduel.com/api/v1/change-password',
          headers: headers,
          body: userData);
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      print(response);
      if (!response['status']) {
        resp['msg'] = response['error'];
        resp['status'] = response['status'];
        return resp;
      }
      resp['msg'] = response['msg'];
      resp['status'] = true;
      return resp;
    } catch (e) {
      print(e.toString());
      resp['msg'] = 'Something went wrong please try again!';
      resp['status'] = false;
      return resp;
    }
  }
}
