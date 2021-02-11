import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:winx/models/pickhorsesTickets.dart';
import 'package:winx/providers/horse.dart';

class HorseMegaLeagueStates with ChangeNotifier {
  HorseProvider horse;
  void upate(HorseProvider horse) {
    this.horse = horse;
  }

  //CONTEST INFO TABS
  Map<String, String> info = {
    'type': 'distribution',
  };

  void setPayment(String state) {
    info['type'] = state;
    notifyListeners();
  }
  //CONTEST INFO TABS

  //HOME SCREEN MY RACE PAGE VIEW
  int currentIndex = 0;
  void changecurrentIndex(int val) {
    currentIndex = val;
    notifyListeners();
  }
  //HOME SCREEN MY RACE PAGE VIEW

  //HOME SCREEN ADD MY RACE
  double myRaceHeight = 0.0;
  void changeMyRaceHeight(double val) {
    myRaceHeight = val;
    notifyListeners();
  }
  //HOME SCREEN ADD MY RACE

  //RACE MEETS MEGA LEAGUE
  bool isSelected = false;
  void changeSelected(bool select) {
    isSelected = select;
    notifyListeners();
  }
  //RACE MEETS MEGA LEAGUE

  //PICK HORSE STABLE INDEX
  bool loading = false;
  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  int stable = 1;
  int stableIndex = 0;
  void changeStable(int index) {
    resetBudget(stableIndex);
    // print(index);
    stable = index;
    stableIndex = --index;
    setMaxBudget(index);
    clearData();
    notifyListeners();
  }

  void resetBudget(int stable) {
    horse.getPickHorse[0].tickets[stable].ticketBudget = items;
    // print(horse.getPickHorse[0].tickets[stable].ticketBudget);
    notifyListeners();
  }

  var items;
  void keepCopy(itemsdata) {
    this.items = itemsdata;
    // print(items);
  }
  //PICK HORSE STABLE INDEX

  //STABLE CALCULATION

  void clearData() {
    horses.clear();
    horsesdummy.clear();
    // print(horses);
    // print(horsesdummy);
  }

  int i = 0;
  List<Map<String, dynamic>> horses = [];
  List<Map<String, dynamic>> horsesdummy = [];
  void addHorse(String horseNo, int value, int stableIndex) {
    int flag = 1;
    var horseValue = value;
    if (horses.isEmpty) {
      horses.add({'horse_no': horseNo, 'ticket_count': 1});
    } else {
      var data = horses.where((element) => element['horse_no'] == horseNo);
      if (data.isEmpty) {
        horses.add({'horse_no': horseNo, 'ticket_count': 1});
      } else {
        data.forEach((element) {
          if (element['horse_no'] == horseNo) {
            element['ticket_count'] = ++element['ticket_count'];
          }
        });
      }
      // horses.forEach((element) {
      //   if (element['horse_no'] == horseNo) {
      //     element['ticket_count'] = ++element['ticket_count'];
      //     flag = 2;
      //   } else {
      //     horsesdummy.add({'horse_no': horseNo, 'ticket_count': 1});
      //     flag = 2;
      //   }

      // });
    }
    if (horsesdummy.isNotEmpty) {
      horses.add(horsesdummy[0]);
      horsesdummy.clear();
    }
    // print(horses);
    decreaseStable(stableIndex, value);
  }

  void removeHorse(String horseNo, int value, int stableIndex) {
    horses.forEach((id) {
      if (id['horse_no'] == horseNo) {
        if (id['ticket_count'] == 0) {
          return;
        }
        id['ticket_count'] = id['ticket_count'] - value;
      }
    });
    increaseStable(stableIndex, value);
  }

  void increaseStable(int stableIndex, int increaseValue) {
    horse.getPickHorse[0].tickets[stableIndex].ticketBudget =
        (int.parse(horse.getPickHorse[0].tickets[stableIndex].ticketBudget) +
                increaseValue)
            .toString();
    notifyListeners();
  }

  void decreaseStable(int stableIndex, int decreaseValue) {
    int value = decreaseValue;
    value = int.parse(horse.getPickHorse[0].tickets[stableIndex].ticketBudget) -
        value;
    // print(decreaseValue);
    value.isNegative ? value = 0 : value = value;
    horse.getPickHorse[0].tickets[stableIndex].ticketBudget = value.toString();
    notifyListeners();
  }

  String maxBudget;
  void setMaxBudget(int index) {
    maxBudget = horse.getPickHorse[0].tickets[index].ticketBudget;
  }

  //STABLE CALCULATION

}

// {
//   "user_id": 0,
//   "race_id": 0,
//   "ticket": 0,
//   "horses": {
//     "horse_no": 0,
//     "ticket_count": 0
//   }
// }
