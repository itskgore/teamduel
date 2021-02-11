import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:winx/models/cricketMatchups.dart';
import 'package:winx/models/horseMatchups.dart';
import 'package:winx/models/joinedMatchups.dart';
import 'package:winx/models/joinedMatchupsDetail.dart';
import 'package:winx/models/matchupDates.dart';
import 'package:winx/models/timeDateModel.dart';
import 'auth.dart';

class MatchupsCrickets extends ChangeNotifier {
  bool cricketMatchupFetched = false;
  Auth auth;
  int userId;
  String token;
  bool submitLoading = false;

  ///Data lists

  List<JoinedMatchupsDetail> joinedMatchupsDetail = [];
  List<JoinedMatchupsDetail> get getJoinedMatchupsDetail {
    return [...joinedMatchupsDetail];
  }

  List<JoinedMatchups> joinedMatchups = [];
  List<JoinedMatchups> get getJoinedMatchups {
    return [...joinedMatchups];
  }

  List<CricketMatchups> cricketMatchups = [];
  List<CricketMatchups> get getCricketMatchupsData {
    return [...cricketMatchups];
  }

  List<CricketMatches> cricketMatches = [];
  List<CricketMatches> get getCricketMatchesData {
    return [...cricketMatches];
  }

  List<HorseMatchups> horseMatchups = [];
  List<HorseMatchups> get getHorseMatchups {
    return [...horseMatchups];
  }

  List<HorseMatchesData> horseMatchesLocation = [];
  List<HorseMatchesData> get getHorseMatchesLocation {
    return [...horseMatchesLocation];
  }

  List<MatchupTimeDate> matchupTimeDate = [];
  List<MatchupTimeDate> get getMatchupTimeDate {
    return [...matchupTimeDate];
  }

  List<MatchupDates> matchupDates = [];
  List<MatchupDates> get getMatchupDates {
    return [...matchupDates];
  }

  List<String> matchdatesFormated = [];
  List<String> get getMatchdatesFormated {
    return [...matchdatesFormated];
  }

  String selectedDate = "Today";

  void upate(Auth auth) async {
    this.auth = auth;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token') && prefs.containsKey('userId')) {
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      print(token);
    }
  }

  isSubmitLoading(bool value) {
    submitLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getCricketMatchups(String date, String type,
      [String filter]) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      print(token);
      print(userId);
      final res = await http.get(
        filter == null
            ? 'http://api.myteamduel.com/api/v1/getMatchups/$userId/$date/$type'
            : 'http://api.myteamduel.com/api/v1/getMatchups/$userId/$date/$type/$filter',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      print(res.body);
      cricketMatchupFetched = true;
      final response = json.decode(res.body) as Map<String, dynamic>;
      if (type == "cricket") {
        cricketMatchups.clear();
        cricketMatches.clear();
        response["data"].forEach((id, data) {
          print(id);
          data.forEach((dat) {
            cricketMatchups.add(CricketMatchups.fromJson(dat));
          });
        });
        response["matchs"].forEach((data) {
          print(data);
          cricketMatches.add(CricketMatches.fromJson(data));
        });
      } else {
        horseMatchups.clear();
        horseMatchesLocation.clear();
        response['data'].forEach((id, data) {
          horseMatchups.add(HorseMatchups.fromJson(data));
          // print(data['matchups']);
        });

        response['locations'].forEach((data) {
          horseMatchesLocation.add(HorseMatchesData(locations: data));
        });
      }
      // print(cricketMatches.length);
      // print(response["data"][0]);
      // print(response["data"]);
      print(cricketMatchups.length);
      print(horseMatchups.length);
      print(response['locations']);
      notifyListeners();
      resp['status'] = true;
      resp['msg'] = 'Data fetched!';
      return resp;
    } catch (e) {
      print(e.toString() + "here");
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  Future<Map<String, dynamic>> postMatchups(dynamic jsonData) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      // print(token);
      // print(userId);
      jsonData["user_id"] = userId.toString();
      print(jsonData);
      final res = await http.post(
        'http://api.myteamduel.com/api/v1/creatematchup',
        body: json.encode(jsonData),
        headers: {"Content-Type": "application/json", "token": this.token},
      );
      final response = json.decode(res.body) as Map<String, dynamic>;
      print(res.body);
      if (!response['status']) {
        resp['status'] = false;
        resp['msg'] = response['msg'];
        return resp;
      }

      resp['status'] = true;
      resp['msg'] = response['msg'];
      return resp;
    } catch (e) {
      print(e.toString() + "here");
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  Future<Map<String, dynamic>> getUserMatchups() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      // print(token);
      // print(userId);
      final res = await http.get(
        'http://api.myteamduel.com/api/v1/getUserMatchups/$userId',
        headers: {"Content-Type": "application/json", "token": this.token},
      );
      final response = json.decode(res.body) as Map<String, dynamic>;

      if (!response['status']) {
        resp['status'] = false;
        resp['msg'] = response['msg'];
        return resp;
      }
      joinedMatchups.clear();
      response['data'].forEach((value) {
        joinedMatchups.add(JoinedMatchups.fromJson(value));
      });
      print(joinedMatchups.length);
      resp['status'] = true;
      resp['msg'] = response['msg'];
      return resp;
    } catch (e) {
      print(e.toString() + "here");
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  Future<Map<String, dynamic>> getUserMatchupDetail(String matchupid) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      print(token);
      print(userId);
      print(matchupid);
      final res = await http.get(
        'http://api.myteamduel.com/api/v1/getUserMatchupList/$userId/$matchupid',
        headers: {"Content-Type": "application/json", "token": this.token},
      );
      final response = json.decode(res.body) as Map<String, dynamic>;
      // if (!response['status']) {
      //   resp['status'] = false;
      //   resp['msg'] = response['msg'];
      //   return resp;
      // }
      joinedMatchupsDetail.clear();
      joinedMatchupsDetail.add(JoinedMatchupsDetail.fromJson(response));

      print(joinedMatchupsDetail[0].data.length);
      resp['status'] = false;
      resp['msg'] = response['msg'];
      return resp;
    } catch (e) {
      print(e.toString() + "here");
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  //DateMatchup loading
  bool matchupDateLoading = false;
  void isLoadingMatchup(bool value) {
    matchupDateLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getMatchupDateTime() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      final date = DateFormat('dd-MM-yyyy')
          .format(DateTime.parse(DateTime.now().toString()));
      isLoadingMatchup(true);
      final res = await http.get(
        'http://api.myteamduel.com/api/v1/getMatchupsDate/$userId/$date',
        headers: {"Content-Type": "application/json", "token": this.token},
      );
      isLoadingMatchup(false);
      final response = json.decode(res.body);
      matchupDates.add(MatchupDates.fromJson(response));
      if (matchupDates.isNotEmpty) {
        arrangeDates();
      }
      resp['status'] = true;
      resp['msg'] = '';
      return resp;
    } catch (e) {
      print(e.toString() + "here");
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  void arrangeDates() async {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    getMatchupDates[0].data.forEach((element) {
      var date = DateTime.fromMicrosecondsSinceEpoch(element);
      matchdatesFormated.add(formatter.format(date));
    });
  }

  void changeSelectedDate(String value) async {
    selectedDate = value;
    notifyListeners();
  }
}
