import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Sections { lobby, joined, completed }
enum SelectPlayerSections { wk, bat, bwl, ar }
enum MatchupSections { lobbymatchup, joinedmatchups }
enum InvestType { coins, chips }
enum MatchScreen { cricket, horse, greyhound }

class CricketStates with ChangeNotifier {
  //Cricket / Horse screen switch
  //1 = horse | 2 = cricket

  int selectionScreen = 1;
  List<Map<String, dynamic>> selectedScreen = [
    {
      'screen': MatchScreen.horse,
      'isSelected': true,
      'icon': FontAwesomeIcons.dailymotion,
      'title': 'Horse'
    },
    {
      'screen': MatchScreen.cricket,
      'isSelected': false,
      'icon': FontAwesomeIcons.solidSave,
      'title': 'Cricket'
    },
  ];

  bool isAppbar = true;
  int investLimit = 10;
  int invest = 0;
  InvestType investType = InvestType.coins;
  var section = Sections.lobby;
  var matchupSection = MatchupSections.lobbymatchup;
  var currentPlaySection = SelectPlayerSections.wk;
  int totalPlayers = 0;
  int totalAllowed = 11;
  List<Map<String, dynamic>> cricketMatchups = [];
  List<Map<String, dynamic>> horseMatchups = [];
  String selectedFilterCricket = "";
  String selectedFilterHorse = "";

  switchMatchUpScreens(MatchScreen data, bool selected) {
    selectedScreen.forEach((element) {
      if (element['screen'] == data) {
        element['isSelected'] = true;
      } else {
        element['isSelected'] = false;
      }
    });
    if (data == MatchScreen.cricket) {
      selectionScreen = 2;
    } else {
      selectionScreen = 1;
    }
    notifyListeners();
  }

  MatchScreen getSelectedScreen() {
    selectedScreen.forEach((element) {
      if (element['isSelected'] == true) {
        return element['screen'];
      }
    });
  }

  bool isSelectedSelected(MatchScreen data) {
    var select = 1;
    selectedScreen.forEach((element) {
      if (element['isSelected'] == true) {
        select = 0;
      } else {
        select = 1;
      }
    });

    if (select == 0) {
      return true;
    } else {
      return false;
    }
  }

  int getSelectedScreenLength() {
    return selectedScreen.length;
  }

  chagneFilterCricket(String filter) {
    selectedFilterCricket = filter;
    notifyListeners();
  }

  chagneFilterHorse(String filter) {
    selectedFilterHorse = filter;
    notifyListeners();
  }

  showHideAppBar(bool val) {
    isAppbar = val;
    notifyListeners();
  }

  clearData() {
    cricketMatchups.clear();
    horseMatchups.clear();
    notifyListeners();
  }

  addcricketMatchUps(
      String id, String side, String matchupSide, String playerNumber) {
    if (cricketMatchups.isEmpty) {
      cricketMatchups.add({
        "matchup": matchupSide,
        "matchup_id": id,
        "match_id": side,
        "type": 2,
        "playerNumber": playerNumber
      });
    } else {
      var data =
          cricketMatchups.where((element) => element['matchup_id'] == id);
      if (data.isEmpty) {
        cricketMatchups.add({
          "matchup": matchupSide,
          "matchup_id": id,
          "match_id": side,
          "type": 2,
          "playerNumber": playerNumber
        });
      } else {
        if (data.toList()[0]['matchup_id'] == id) {
          if (side != side) {
            if (data.toList()[0]['playerNumber'] == playerNumber) {
              cricketMatchups
                  .removeAt(cricketMatchups.indexOf(data.toList()[0]));
            } else {
              cricketMatchups[cricketMatchups.indexOf(data.toList()[0])]
                  ["playerNumber"] = playerNumber;
              cricketMatchups[cricketMatchups.indexOf(data.toList()[0])]
                  ["matchup"] = matchupSide;
            }
          } else {
            if (data.toList()[0]['playerNumber'] == playerNumber) {
              cricketMatchups
                  .removeAt(cricketMatchups.indexOf(data.toList()[0]));
            } else {
              cricketMatchups[cricketMatchups.indexOf(data.toList()[0])]
                  ["playerNumber"] = playerNumber;
              cricketMatchups[cricketMatchups.indexOf(data.toList()[0])]
                  ["matchup"] = matchupSide;
            }
          }
        } else {
          cricketMatchups.removeWhere((element) =>
              element['matchup_id'] == id &&
              playerNumber == element["playerNumber"]);
        }
      }
    }
    print(cricketMatchups);
    notifyListeners();
  }

  addhorseMatchUps(
      String id, String side, String matchupSide, String horseNumber) {
    if (horseMatchups.isEmpty) {
      horseMatchups.add({
        "matchup": matchupSide,
        "matchup_id": id,
        "match_id": side,
        "type": 1,
        "horseNumber": horseNumber
      });
    } else {
      var data = horseMatchups.where((element) => element['matchup_id'] == id);
      if (data.isEmpty) {
        horseMatchups.add({
          "matchup": matchupSide,
          "matchup_id": id,
          "match_id": side,
          "type": 1,
          "horseNumber": horseNumber
        });
      } else {
        if (data.toList()[0]['matchup_id'] == id) {
          if (horseNumber != horseNumber) {
            if (data.toList()[0]['horseNumber'] == horseNumber) {
              horseMatchups.removeAt(horseMatchups.indexOf(data.toList()[0]));
            } else {
              horseMatchups[horseMatchups.indexOf(data.toList()[0])]
                  ["horseNumber"] = horseNumber;
              horseMatchups[horseMatchups.indexOf(data.toList()[0])]
                  ["matchup"] = matchupSide;
            }
          } else {
            if (data.toList()[0]['horseNumber'] == horseNumber) {
              horseMatchups.removeAt(horseMatchups.indexOf(data.toList()[0]));
            } else {
              horseMatchups[horseMatchups.indexOf(data.toList()[0])]
                  ["horseNumber"] = horseNumber;
              horseMatchups[horseMatchups.indexOf(data.toList()[0])]
                  ["matchup"] = matchupSide;
            }
          }
        } else {
          horseMatchups.removeWhere((element) =>
              element['matchup_id'] == id &&
              horseNumber == element["horseNumber"]);
        }
      }
    }
    print(horseMatchups);
    notifyListeners();
  }

  changeInvestType() {
    investType == InvestType.coins
        ? investType = InvestType.chips
        : investType = InvestType.coins;
    notifyListeners();
  }

  increDecreInvest(bool incre) {
    if (incre) {
      if (invest != investLimit) {
        invest += 1;
      }
    } else {
      if (invest != 0) {
        invest -= 1;
      }
    }
    notifyListeners();
  }

  changeSection(Sections data) {
    section = data;
    notifyListeners();
  }

  changeMatchUpSection(MatchupSections data) {
    matchupSection = data;
    notifyListeners();
  }

  changeSelectPlayer(SelectPlayerSections data) {
    currentPlaySection = data;
    notifyListeners();
  }

  Map<String, String> selectCapVic = {
    "captain": "07",
    "viceCaptain": "",
    "manOfMatch": ""
  };

  String getCapText(String posi, String id) {
    if (posi == "C") {
      if (id == selectCapVic["captain"]) {
        return "2x";
      } else {
        return posi;
      }
    }
    if (posi == "VC") {
      if (id == selectCapVic["viceCaptain"]) {
        return "1.5x";
      } else {
        return posi;
      }
    }
    if (posi == "manOfMatch") {
      if (id == selectCapVic["manOfMatch"]) {
        return "50pts";
      } else {
        return "☆";
      }
    }
    return posi;
  }

  bool setCaptain(String id) {
    if (selectCapVic["viceCaptain"] == id) {
      selectCapVic["viceCaptain"] = "";
    }
    selectCapVic["captain"] = id;
    notifyListeners();
    return true;
  }

  bool setViceCaptain(String id) {
    if (selectCapVic["captain"] == id) {
      selectCapVic["captain"] = "";
    }
    selectCapVic["viceCaptain"] = id;
    notifyListeners();
    return true;
  }

  bool setManOfTheMatch(String id) {
    selectCapVic["manOfMatch"] = id;
    notifyListeners();

    return true;
  }

  Color positionColor(String posi, String id) {
    if (posi == "C") {
      if (selectCapVic['captain'] == id) {
        return Color(0xffbbFF4956);
      } else {
        return Color(0xffbbE2E2E2);
      }
    }
    if (posi == "VC") {
      if (selectCapVic['viceCaptain'] == id) {
        return Color(0xffbbFF4956);
      } else {
        return Color(0xffbbE2E2E2);
      }
    }
    if (posi == "manOfMatch") {
      if (selectCapVic['manOfMatch'] == id) {
        return Color(0xffbbFF4956);
      } else {
        return Color(0xffbbE2E2E2);
      }
    }
  }

  List<Map<String, dynamic>> dummywkt = [];
  List<Map<String, dynamic>> dummybat = [];
  List<Map<String, dynamic>> dummybwl = [];
  List<Map<String, dynamic>> dummyar = [];
  List<Map<String, dynamic>> wkt = [];
  Map<String, dynamic> wKT = {};
  List<Map<String, dynamic>> bat = [];
  List<Map<String, dynamic>> bwl = [];
  List<Map<String, dynamic>> ar = [];

  bool addPlayer(bool remove) {
    if (totalPlayers != totalAllowed) {
      if (remove) {
        totalPlayers -= 1;
      } else {
        totalPlayers += 1;
      }
      print("$totalPlayers TOTAL PLAYES true");

      return true;
    }
    print("$totalPlayers TOTAL PLAYES false");

    return false;
  }

  toggleWKT(int id, bool remove) {
    if (wkt.isEmpty || remove) {
      if (addPlayer(remove)) {
        var data = wkt.indexWhere((element) => element['id'] == id);
        if (data.isNegative) {
          wkt.add({"id": id});
          dummywkt.removeWhere((element) => element['id'] == id);
        } else {
          wkt.removeWhere((element) => element['id'] == id);
          dummywkt.add({"id": id});
        }
        notifyListeners();
      }
    }
  }

  toggleBAT(int id, bool remove) {
    if (bat.length <= 4 || remove) {
      if (addPlayer(remove)) {
        var data = bat.indexWhere((element) => element['id'] == id);
        if (data.isNegative) {
          bat.add({"id": id});
          dummybat.removeWhere((element) => element['id'] == id);
        } else {
          bat.removeWhere((element) => element['id'] == id);
          dummybat.add({"id": id});
        }
        print("${bat.length} BAT LENGTH   $remove");

        notifyListeners();
      }
    }
  }

  toggleBWL(int id, remove) {
    if (bwl.length <= 4 || remove) {
      if (addPlayer(remove)) {
        var data = bwl.indexWhere((element) => element['id'] == id);
        if (data.isNegative) {
          bwl.add({"id": id});
          dummybwl.removeWhere((element) => element['id'] == id);
        } else {
          bwl.removeWhere((element) => element['id'] == id);
          dummybwl.add({"id": id});
        }
        notifyListeners();
      }
    }
  }

  toggleAR(int id, bool remove) {
    if (ar.length <= 4 || remove) {
      if (addPlayer(remove)) {
        var data = ar.indexWhere((element) => element['id'] == id);
        if (data.isNegative) {
          ar.add({"id": id});
          dummyar.removeWhere((element) => element['id'] == id);
        } else {
          ar.removeWhere((element) => element['id'] == id);
          dummyar.add({"id": id});
        }
        notifyListeners();
      }
    }
  }

  Color checkNext() {
    if (totalAllowed == totalPlayers) {
      return Color(0xffbbFF4956);
    }
    if (currentPlaySection == SelectPlayerSections.wk) {
      if (wkt.length == 1) {
        return Color(0xffbbFF4956);
      } else {
        return Color(0xffbb808080);
      }
    }
    if (currentPlaySection == SelectPlayerSections.bat) {
      if (bat.length >= 3 && bwl.length <= 5) {
        return Color(0xffbbFF4956);
      } else {
        return Color(0xffbb808080);
      }
    }
    if (currentPlaySection == SelectPlayerSections.bwl) {
      if (bwl.length >= 3 && bwl.length <= 5) {
        return Color(0xffbbFF4956);
      } else {
        return Color(0xffbb808080);
      }
    }
    if (currentPlaySection == SelectPlayerSections.ar) {
      if (ar.length >= 3 && ar.length <= 5) {
        return Color(0xffbbFF4956);
      } else {
        return Color(0xffbb808080);
      }
    }
  }
}
