class WeeklyHorseModel {
  String id;
  String contestName;
  String fromDate;
  String endDate;
  String noWinning;
  String prizeType;
  String prizeMoney;
  String updates;
  String flag;
  String status;
  String jointPlayers;
  String userJointStatus;
  String totalWinningChips;
  String totalWinningCoins;
  int duration;

  List<PrizeBreakUp> prizeBreakUp;
  List<Info> info;

  WeeklyHorseModel(
      {this.contestName,
      this.endDate,
      this.flag,
      this.fromDate,
      this.id,
      this.info,
      this.totalWinningChips,
      this.totalWinningCoins,
      this.jointPlayers,
      this.noWinning,
      this.prizeBreakUp,
      this.prizeMoney,
      this.prizeType,
      this.status,
      this.updates,
      this.duration,
      this.userJointStatus});
}

class PrizeBreakUp {
  String from;
  String to;
  String prize;
  String type;

  PrizeBreakUp({this.from, this.prize, this.to, this.type});
}

class Info {
  String slNo;
  String date;
  String location;
  String status;
  Info({this.date, this.location, this.slNo, this.status});
}
