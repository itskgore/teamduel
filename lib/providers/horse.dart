import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:winx/models/megaLeagurRaceList.dart';
import 'package:winx/models/myJointMatches.dart';
import 'package:winx/models/myMatches.dart';
import 'package:winx/models/weeklyHorse.dart';
import 'package:winx/models/myGrandLeague.dart';
import 'package:winx/models/pickhorsesTickets.dart';
import 'package:winx/screens/pickHorseScreen.dart';
import 'package:winx/widgets/raceList.dart';
import '../secrete.dart';
import 'auth.dart';

class HorseProvider with ChangeNotifier {
  Auth auth;
  int userId;
  String token;
  void upate(Auth auth) async {
    this.auth = auth;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token') && prefs.containsKey('userId')) {
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      print(token);
    }
  }

  List<WeeklyHorseModel> weeklyHorse = [];
  List<WeeklyHorseModel> get getWeeklyHorse {
    return [...weeklyHorse];
  }

  List<MyGrandLeague> myWeeklyHorse = [];
  List<MyGrandLeague> get getMyWeeklyHorse {
    return [...myWeeklyHorse];
  }

  List<MyMatches> myMatches = [];
  List<MyMatches> get getMyMatch {
    return [...myMatches];
  }

  List<MyJointMatches> myJointMatches = [];
  List<MyJointMatches> get getMyJointMatch {
    return [...myJointMatches];
  }

  List<MegaLeagueRaceList> myRaceList = [];
  List<MegaLeagueRaceList> get getMyRaceList {
    return [...myRaceList];
  }

  List<PickHorsesMegaLeague> pickHorse = [];
  List<PickHorsesMegaLeague> get getPickHorse {
    return [...pickHorse];
  }

  List<Horses> horses = [];
  List<Tickets> tickets = [];
  List<InfoMyLeague> myInfo = [];
  List<PrizeBreakUpMyLeague> myPrizeBreakUp = [];
  List<Info> info = [];
  List<PrizeBreakUp> prizeBreakUp = [];

  Future<Map<String, dynamic>> getWeeklyHorseData() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      final res = await http.get(
        'http://app.myteamduel.com/api/v1/grand-leagues/${this.userId}',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      // if (!response['status']) {
      //   resp['msg'] = response['msg'];
      //   resp['status'] = false;
      //   return resp;
      // }
      // print(response);
      weeklyHorse.clear();
      response.forEach((key, value) {
        if (key == 'data') {
          value.forEach((id) {
            id['info'].forEach((el) {
              info.add(Info(
                date: el['date'].toString(),
                location: el['location'].toString(),
                slNo: el['slno'].toString(),
                status: el['status'].toString(),
              ));
            });
            id['prize_break_up'].forEach((el) {
              prizeBreakUp.add(PrizeBreakUp(
                  from: el['from'].toString(),
                  prize: el['prize'].toString(),
                  to: el['to'].toString(),
                  type: el['type'].toString()));
            });
            // print(id['id']);
            weeklyHorse.add(WeeklyHorseModel(
                duration: id['seconds'],
                contestName: id['contest_name'].toString(),
                endDate: id['to_date'].toString(),
                flag: id['flag'].toString(),
                fromDate: id['from_date'].toString(),
                id: id['id'].toString(),
                info: info,
                totalWinningChips: id['totalWinningChips'].toString(),
                totalWinningCoins: id['totalWinningCoins'].toString(),
                jointPlayers: id['joined_players'].toString(),
                noWinning: id['no_winner'].toString(),
                prizeBreakUp: prizeBreakUp,
                prizeMoney: id['prize_money'].toString(),
                prizeType: id['prize_type'].toString(),
                status: id['status'].toString(),
                updates: id['updates'].toString(),
                userJointStatus: id['user_joined_status'].toString()));
          });
        }
      });
      resp['status'] = true;
      resp['msg'] = 'Grand League data loaded';
      return resp;
    } catch (e) {
      print(e.toString());
      resp['status'] = true;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  Future<Map<String, dynamic>> joinContest(String contestId) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      Map<String, dynamic> body = {
        'userid': this.userId.toString(),
        'contestid': contestId
      };
      final res = await http.post(
        'http://app.myteamduel.com/api/v1/enter-grand-league',
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      return response;
    } catch (e) {
      print(e.toString());
      resp['status'] = true;
      resp['msg'] = 'Something went wrong please try again';
    }
  }

  Future<Map<String, dynamic>> getMyContest() async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      final res = await http.get(
        'http://app.myteamduel.com/api/v1/my-grand-leagues/${this.userId}',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      myWeeklyHorse.clear();
      final response = json.decode(res.body) as Map<dynamic, dynamic>;
      // print(res.body);
      // if (!response['status']) {
      //   resp['status'] = true;
      //   resp['msg'] = response['msg'];
      //   return resp;
      // }

      // print(response);
      response.forEach((key, value) {
        if (key == 'data') {
          value.forEach((id) {
            id['info'].forEach((el) {
              myInfo.add(InfoMyLeague(
                date: el['date'].toString(),
                location: el['location'].toString(),
                slNo: el['slno'].toString(),
                status: el['status'].toString(),
              ));
            });
            id['prize_break_up'].forEach((el) {
              myPrizeBreakUp.add(PrizeBreakUpMyLeague(
                  from: el['from'].toString(),
                  prize: el['prize'].toString(),
                  to: el['to'].toString(),
                  type: el['type'].toString()));
            });
            myWeeklyHorse.add(MyGrandLeague(
              contestId: id['contest_id'].toString(),
              contestName: id['contest_name'].toString(),
              flag: id['flag'].toString(),
              fromData: id['from_date'].toString(),
              id: id['id'].toString(),
              info: myInfo,
              jointPlayers: id['joined_players'].toString(),
              noWinner: id['no_winner'].toString(),
              prizeBreakUp: myPrizeBreakUp,
              prizeCoins: id['prize_coins'].toString(),
              prizeMoney: id['prize_money'].toString(),
              prizeType: id['prize_type'].toString(),
              seconds: id['seconds'].toString(),
              status: id['status'].toString(),
              toDate: id['to_date'].toString(),
              updates: id['updates'].toString(),
              userId: id['user_id'].toString(),
              userJointStatus: id['user_joined_status'].toString(),
            ));
          });
        }
      });
      // print(myWeeklyHorse.length);
      notifyListeners();
      resp['status'] = true;
      resp['msg'] = 'Grand League data loaded';
      return resp;
    } catch (e) {
      print(e.toString());
      resp['status'] = true;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  Future<Map<String, dynamic>> jointMatch(String id) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      final res = await http.get(
        'http://app.myteamduel.com/api/v1/mega-matches/${this.userId}/$id',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      myMatches.clear();
      var response;
      // if (res.body.contains('status')) {
      //   response = json.decode(res.body);
      //   if (!response['status']) {
      //     resp['status'] = false;
      //     resp['msg'] = response['msg'];
      //     return resp;
      //   }
      // }

      response = json.decode(res.body) as Map<dynamic, dynamic>;
      print(response);
      if (!response['status']) {
        resp['status'] = false;
        resp['msg'] = response['msg'];
        return resp;
      }
      response.forEach((key, value) {
        if (key == 'live') {
          value.forEach((id) {
            myMatches.add(MyMatches(
                contestId: id['contestId'].toString(),
                flag: id['flag'].toString(),
                isFirstFree: id['is_first_free'].toString(),
                matchDestination: id['matchDestination'].toString(),
                matchTitle: id['matchTitle'].toString(),
                matchesId: id['matchesId'].toString(),
                pricePerTicket: id['price_per_ticket'].toString(),
                seconds: id['seconds'].toString(),
                status: id['status'].toString(),
                userAllowedTicket: id['user_allowed_tickets'].toString(),
                userJoinedTicket: id['user_joined_tickets'].toString(),
                userMatchStatus: id['user_match_status'].toString()));
          });
        }
      });
      // print(response);
      // print(getMyMatch.length);
      resp['status'] = true;
      resp['msg'] = 'Matches data successfully fetched';
      return resp;
    } catch (e) {
      print(e.toString());
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  Future<Map<String, dynamic>> registerMegaMatch(
      {int contestId, int matchid, int tickets}) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      Map<String, dynamic> body = {
        'userid': this.userId.toString(),
        'contestid': contestId.toString(),
        'matchid': matchid.toString(),
        'tickets': tickets.toString(),
      };
      final res = await http.post(
        'http://app.myteamduel.com/api/v1/register-mega-matches',
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      final response = json.decode(res.body);
      // print(response);
      if (!response['status']) {
        resp['status'] = false;
        resp['msg'] = response['msg'];
        return resp;
      }
      return response;
    } catch (e) {
      print(e.toString());
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  Future<Map<String, dynamic>> myJointMatched(String contestId) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      final res = await http.get(
        'http://app.myteamduel.com/api/v1/my-mega-matches/${this.userId}/$contestId',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      myJointMatches.clear();
      // print(res.body);
      var response;
      response = json.decode(res.body) as Map<String, dynamic>;
      print(response);
      if (!response['status']) {
        response = json.decode(res.body);
        resp['status'] = false;
        resp['msg'] = response['msg'];
        return resp;
      }

      response.forEach((key, value) {
        if (key == 'data') {
          value.forEach((id) {
            myJointMatches.add(MyJointMatches(
                contestId: id['contestId'].toString(),
                flag: id['flag'],
                ifFirstFree: id['is_first_free'].toString(),
                matchDestination: id['matchDestination'],
                matchId: id['matchesId'].toString(),
                matchTitle: id['matchTitle'],
                pricePerTicket: id['price_per_ticket'].toString(),
                startTime: id['startsTime'].toString(),
                status: id['status'],
                userAllowedTickets: id['user_allowed_tickets'].toString(),
                userJointTickets: id['user_joined_tickets'].toString(),
                userMatchStatus: id['user_match_status'].toString()));
          });
        }
      });
      resp['status'] = true;
      resp['msg'] = 'New data fetched successfully';
      return resp;
    } catch (e) {
      print(e.toString());
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  Future<Map<String, dynamic>> getMegaRaceList(
      String conId, String matchId) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      final res = await http.get(
        'http://app.myteamduel.com/api/v1/get-race-list-by-mega-match-id/${this.userId}/$matchId/$conId',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      final response = json.decode(res.body);
      myRaceList.clear();
      response.forEach((id) {
        myRaceList.add(MegaLeagueRaceList(
            pickStatus: id['pick_status'].toString(),
            raceId: id['race_id'].toString(),
            raceName: id['race_name'].toString(),
            result: id['result'].toString(),
            seconds: id['seconds'].toString()));
      });
      resp['status'] = true;
      resp['msg'] = 'Taking you to the race list tab';
      return resp;
    } catch (e) {
      print(e.toString());
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  Future<Map<String, dynamic>> getHorses(String raceId) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      final res = await http.get(
        'http://app.myteamduel.com/api/v1/get-horse-list-by-mega-race-id/${this.userId.toString()}/$raceId',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "token": this.token
        },
      );
      var response;
      response = json.decode(res.body) as Map<String, dynamic>;
      // if (!response['status']) {
      //   resp['status'] = false;
      //   resp['msg'] = response['msg'];
      //   return resp;
      // }
      horses.clear();
      tickets.clear();
      pickHorse.clear();
      response.forEach((key, value) {
        if (key == 'horses') {
          value.forEach((id) {
            horses.add(Horses(
                horseId: id['horse_no'].toString(),
                horseName: id['horse_name'].toString(),
                jockey: id['jockey'].toString(),
                playPoints: id['play_points'].toString(),
                trainer: id['trainer'].toString(),
                playerPerformance: id['player_performance'].toString(),
                selectedUserPer: id['selected_users_percentage'].toString(),
                horseWithdrawalStatus: id['horse_withdrawl_status']));
            // pickHorse.add(PickHorsesMegaLeague());
          });
        }
        if (key == 'tickets') {
          value.forEach((id) {
            print(id);
            tickets.add(Tickets(
                spent: id['spent'].toString(),
                ticketBudget: id['ticketBudget'].toString(),
                ticketId: id['ticketId'].toString()));
          });
        }
      });
      pickHorse.add(PickHorsesMegaLeague(horses: horses, tickets: tickets));
      resp['status'] = true;
      resp['msg'] = 'Races fetched successfully';
      return resp;
    } catch (e) {
      print(e.toString());
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }

  Future<Map<String, dynamic>> submitStableHorse(
      Map<String, dynamic> body) async {
    Map<String, dynamic> resp = {'msg': '', 'status': false};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print('ider');

      this.userId = prefs.getInt('userId');
      this.token = prefs.getString('token');
      body['user_id'] = this.userId.toString();
      print(body);
      final res = await http.post(
        'http://app.myteamduel.com/api/v1/register-mega-race',
        body: {
          'user_id': this.userId.toString(),
          'race_id': body['race_id'].toString(),
          'ticket': body['ticket'].toString(),
          'horses': body['horses'].toString()
        },
        headers: {"Content-Type": "application/json", "token": this.token},
      );
      print(res.body);
      final response = json.decode(res.body);
      print(response);
      if (response['status']) {
        await this.getHorses(body['race_id'].toString());
        notifyListeners();
        resp['status'] = true;
        resp['msg'] = response['msg'];
        return resp;
      }

      resp['status'] = false;
      resp['msg'] = response['msg'];

      return resp;
    } catch (e) {
      print(e.toString());
      resp['status'] = false;
      resp['msg'] = 'Something went wrong please try again';
      return resp;
    }
  }
}
