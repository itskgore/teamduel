import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winx/models/KycStatus.dart';
import 'package:winx/models/transactions.dart';
import 'package:winx/models/userData.dart';
import 'package:winx/models/wallet.dart';
import 'package:winx/providers/auth.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  bool getUser = false;
  bool getWalletData = false;
  int userId;
  String token;
  Auth auth;
  void upate(Auth auth) async {
    this.auth = auth;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token') && prefs.containsKey('userId')) {
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
    }
  }

  Coins coin = new Coins();
  Chips chip = new Chips();

  List<UserData> _userData = [];
  List<UserData> get userDetails {
    return [..._userData];
  }

  List<Coins> _coins = [];
  List<Coins> get getCoins {
    return [..._coins];
  }

  List<Chips> _chips = [];
  List<Chips> get getChips {
    return [..._chips];
  }

  List<Transaction> _transaction = [];
  List<Transaction> get transaction {
    return [..._transaction];
  }

  List<KycStatus> _kyc = [];
  List<KycStatus> get kyc {
    return [..._kyc];
  }

  Future<void> userData() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      _userData.clear();
      getUser = true;
      print(this.userId);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      final res = await http.get(
        'http://app.myteamduel.com/api/v1/get-profile/${this.userId}',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      // print(response);
      if (response['error'] != null || !response['status']) {
        resp['msg'] = response['error'];
        resp['status'] = response['status'];
        return resp;
      }
      _userData.add(UserData(
        admin_type: response['data']['admin_type'].toString(),
        bonus_chips: response['data']['bonus_chips'].toString(),
        city: response['data']['city'].toString(),
        country: response['data']['country'].toString(),
        dob: response['data']['dob'].toString(),
        email: response['data']['email'].toString(),
        gender: response['data']['gender'].toString(),
        id: response['data']['id'].toString(),
        img: response['data']['img'].toString(),
        last_login: response['data']['last_login'].toString(),
        mobile_number: response['data']['mobile_number'].toString(),
        name: response['data']['name'].toString(),
        pincode: response['data']['pincode'].toString(),
        profileStatus: response['data']['profileStatus'].toString(),
        provider: response['data']['provider'].toString(),
        provider_id: response['data']['provider_id'].toString(),
        referal_code: response['data']['referal_code'].toString(),
        role_id: response['data']['role_id'].toString(),
        state: response['data']['state'].toString(),
        status: response['data']['status'].toString(),
        team_name: response['data']['team_name'].toString(),
        user_wallet_current_amount:
            response['data']['user_wallet_current_amount'].toString(),
        winnings: response['data']['winnings'].toString(),
      ));
      notifyListeners();
    } catch (e) {
      print(e.toString());
    } finally {
      getUser = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> editUser(Map<String, String> body) async {
    body['user_id'] = this.userId.toString();
    print(body);
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      final res = await http.post(
        'http://app.myteamduel.com/api/v1/edit-profile',
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      if (!response['status']) {
        resp['msg'] = response['error'];
        resp['status'] = response['status'];
        return resp;
      }
      resp['msg'] = 'User data updated Successfully';
      resp['status'] = true;
      return resp;
    } catch (e) {
      print('object');
      print(e.toString());
      resp['msg'] = 'Something went wrong please try again!!';
      resp['status'] = false;
      return resp;
    } finally {
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> referFriend(Map<String, String> body) async {
    body['user_id'] = this.userId.toString();
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      final res = await http.post(
        'http://app.myteamduel.com/api/v1/user-refarel',
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      print(response);
      if (response['error'] != null || !response['status']) {
        resp['msg'] = response['error'];
        resp['status'] = response['status'];
        return resp;
      }
      resp['msg'] = response['msg'];
      resp['status'] = true;
      return resp;
    } catch (e) {
      print(e.toString());
      resp['msg'] = 'Something went wrong please try again!!';
      resp['status'] = false;
      return resp;
    } finally {
      notifyListeners();
    }
  }

  Future<void> getWallet() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userId = prefs.getInt('userId');
    this.token = prefs.getString('token');
    try {
      _coins.clear();
      _chips.clear();
      Chips.total = '0';
      Coins.total = '0';
      getWalletData = true;
      final res = await http.get(
        'http://app.myteamduel.com/api/v1/walletbalace/${this.userId}',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      print(response);
      if (!response['status']) {
        resp['msg'] = response['msg'];
        resp['status'] = response['status'];
        return resp;
      }

      response['chips'].forEach((id, data) {
        if (id == 'chips') {
          // print(data);
          Chips.total = response['chips']['chips'].toString();
        }
        if (id == 'history') {
          // print(data);
          data.forEach((id) {
            print(response['coins']);
            _chips.add(Chips(
              totalchips: response['coins']['coins'].toString(),
              amount: id['amount'].toString(),
              bonus: id['bonus'].toString(),
              createdAt: id['created_at'].toString(),
              id: id['id'].toString(),
              message: id['message'].toString(),
              type: id['type'].toString(),
              uid: id['uid'].toString(),
              updatedAt: id['updated_at'].toString(),
            ));
          });
        }
      });
      response['coins'].forEach((id, data) {
        if (id == 'coins') {
          // print('data');
          Coins.total = response['coins']['coins'].toString();
        }
        print(Coins.total);
        if (id == 'history') {
          data.forEach((id) {
            print(response['coins']);
            _coins.add(Coins(
              totalcoins: response['coins']['coins'].toString(),
              amount: id['amount'].toString(),
              bonus: id['bonus'].toString(),
              createdAt: id['created_at'].toString(),
              id: id['id'].toString(),
              message: id['message'].toString(),
              type: id['type'].toString(),
              uid: id['uid'].toString(),
              updatedAt: id['updated_at'].toString(),
            ));
          });
        }
      });
      getWalletData = false;
      print(response['coins']['coins']);
      print(res.body);
    } catch (e) {
      print(e.toString());
      resp['msg'] = 'Something went wrong please try again!!';
      resp['status'] = false;
      getWalletData = false;

      return resp;
    } finally {
      getWalletData = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> getAdsPerUser() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userId = prefs.getInt('userId');
    this.token = prefs.getString('token');
    try {
      final res = await http.get(
        'http://app.myteamduel.com/api/v1/ads-coin-per-user/${this.userId}',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      if (response.containsKey('sattus')) {
        print('dsaasdsad');
        resp['msg'] = response['msg'];
        resp['status'] = response['status'];
        return resp;
      }
      return response;
    } catch (e) {
      print(e.toString());
      resp['msg'] = 'Something went wrong please try again!';
      resp['status'] = false;
      return resp;
    }
  }

  Future<dynamic> getKycStatus() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      final res = await http.get(
        'http://app.myteamduel.com/api/v1/kyc-status/${this.userId}',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      print(response);
      resp['msg'] = response['msg'];
      resp['status'] = response['status'];
      _kyc.clear();
      _kyc.add(KycStatus(msg: response['msg']));
      notifyListeners();
      return resp;
    } catch (e) {
      print(e.toString());
      resp['msg'] = 'Something went wrong please try again!';
      resp['status'] = false;
      return resp;
    }
  }

  Future<Map<String, dynamic>> uploadDoc(File file) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userId = prefs.getInt('userId');
    this.token = prefs.getString('token');
    try {
      var _fileContent = file.readAsBytesSync();
      var _fileContentBase64 = base64.encode(_fileContent);
      // print(_fileContentBase64);
      // String base64Image = base64Encode(file.readAsBytesSync());
      // return;
      Map<dynamic, dynamic> body = {
        "user_id": this.userId.toString(),
        "document": _fileContentBase64
      };
      final res = await http.post(
        'http://app.myteamduel.com/api/v1/register-kyc',
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Accept': 'application/json',
          "token": this.token
        },
      );
      print(res.body);
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      if (!response['status']) {
        resp['msg'] = response['msg'];
        resp['status'] = false;
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
    } finally {}
  }

  Future<Map<String, dynamic>> getPaymentWithdrawQuation() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userId = prefs.getInt('userId');
    this.token = prefs.getString('token');
    try {
      final res = await http.get(
        'http://app.myteamduel.com/api/v1/payment-withdraw-quation/${this.userId}',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      if (!response['status']) {
        resp['msg'] = response['msg'];
        resp['status'] = false;
        return resp;
      }
      // print(response);
      return response;
    } catch (e) {
      print('error');
      print(e.toString());
      resp['msg'] = 'Something went wrong please try again!';
      resp['status'] = false;
      return resp;
    }
  }

  Future<Map<String, dynamic>> paymentWithdraw(
      Map<String, dynamic> payment) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userId = prefs.getInt('userId');
    this.token = prefs.getString('token');
    payment['user_id'] = this.userId.toString();
    try {
      final res = await http.post(
        'http://app.myteamduel.com/api/v1/payment-withdraws',
        body: payment,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      print(res.body);
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      if (!response['status']) {
        resp['msg'] = response['msg'];
        resp['status'] = false;
        return resp;
      }

      return response;
    } catch (e) {
      print(e.toString());
      resp['msg'] = 'Something went wrong please try again!';
      resp['status'] = false;
      return resp;
    }
  }

  Future<Map<String, dynamic>> paymentVerify(Map<String, dynamic> body) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userId = prefs.getInt('userId');
    this.token = prefs.getString('token');
    body['user_id'] = this.userId.toString();
    print(body);
    try {
      final res = await http.post(
        'http://app.myteamduel.com/api/v1/otp-verification-for-widthdrawls',
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      print(res.body);
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      if (!response['status']) {
        resp['msg'] = response['msg'];
        resp['status'] = false;
        return resp;
      }
      return response;
    } catch (e) {
      print(e.toString());
      resp['msg'] = 'Something went wrong please try again!';
      resp['status'] = false;
      return resp;
    }
  }

  Future<Map<String, dynamic>> resendPaymentOTP(String requestId) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userId = prefs.getInt('userId');
    this.token = prefs.getString('token');
    try {
      final res = await http.get(
        'http://app.myteamduel.com/api/v1/payment-withdraws-resendOtp/${this.userId}/${requestId}',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      print(res.body);
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      if (!response['status']) {
        resp['msg'] = response['msg'];
        resp['status'] = false;
        return resp;
      }
      // print(response);
      return response;
    } catch (e) {
      print(e.toString());
      resp['msg'] = 'Something went wrong please try again!';
      resp['status'] = false;
      return resp;
    }
  }

  Future<dynamic> getProfilePic() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userId = prefs.getInt('userId');
    this.token = prefs.getString('token');
    try {
      final res = await http.get(
        'http://app.myteamduel.com/api/v1/get-all-profile-pics/${this.userId}',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      final response = json.decode(res.body) as List<dynamic>;
      // if (!response['status']) {
      //   resp['msg'] = response['msg'];
      //   resp['status'] = false;
      //   return resp;
      // }
      // print(response);
      return response;
    } catch (e) {
      print(e.toString());
      resp['msg'] = 'Something went wrong please try again!';
      resp['status'] = false;
      return resp;
    }
  }

  Future<Map<String, dynamic>> getTransactions() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userId = prefs.getInt('userId');
    this.token = prefs.getString('token');
    try {
      final res = await http.get(
        'http://app.myteamduel.com/api/v1/payment-withdraws-history/${this.userId}',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      final response = json.decode(res.body) as Map<String, dynamic>;
      if (!response['status']) {
        resp['msg'] = response['msg'];
        resp['status'] = false;
        return resp;
      }
      print(response);
      _transaction.clear();
      response['data'].forEach((data) {
        _transaction.add(Transaction(
          createdAt: data['created_at'].toString(),
          depositedDate: data['deposited_date'].toString(),
          id: data['id'].toString(),
          mobileNumber: data['mobile_number'].toString(),
          paymentStatus: data['payment_status'].toString(),
          updatedAt: data['updated_at'].toString(),
          userId: data['user_id'].toString(),
          verificationId: data['verification_id'].toString(),
          verificationStatus: data['verification_status'].toString(),
          walletName: data['wallet_name'].toString(),
          withdrawAmount: data['withdraw_amount'].toString(),
        ));
      });
      resp['msg'] = 'Transaction data successfully loaded';
      resp['status'] = true;
      return resp;
    } catch (e) {
      print(e.toString());
      resp['msg'] = 'Something went wrong please try again!';
      resp['status'] = false;
      return resp;
    }
  }

  Future<Map<String, dynamic>> resetPassword(Map<String, dynamic> body) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userId = prefs.getInt('userId');
    this.token = prefs.getString('token');
    try {
      body['id'] = this.userId.toString();
      print(body);
      final res = await http.post(
        'http://app.myteamduel.com/api/v1/reset-password',
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      final response = json.decode(res.body) as Map<String, dynamic>;
      print(response);
      if (!response['status']) {
        resp['msg'] = response['msg'];
        resp['status'] = false;
        return resp;
      }
      return response;
    } catch (e) {
      print(e.toString());
      resp['msg'] = 'Something went wrong please try again!';
      resp['status'] = false;
      return resp;
    }
  }
}
