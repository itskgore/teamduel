class MyGrandLeague {
  String id;
  String contestName;
  String fromData;
  String toDate;
  String noWinner;
  String prizeType;
  String prizeMoney;
  String updates;
  String flag;
  String status;
  String prizeCoins;
  String contestId;
  String userId;
  List<PrizeBreakUpMyLeague> prizeBreakUp;
  List<InfoMyLeague> info;
  String jointPlayers;
  String userJointStatus;
  String seconds;

  MyGrandLeague(
      {this.contestId,
      this.contestName,
      this.flag,
      this.fromData,
      this.id,
      this.info,
      this.jointPlayers,
      this.noWinner,
      this.prizeBreakUp,
      this.prizeCoins,
      this.prizeMoney,
      this.prizeType,
      this.seconds,
      this.status,
      this.toDate,
      this.updates,
      this.userId,
      this.userJointStatus});
}

class PrizeBreakUpMyLeague {
  String from;
  String to;
  String prize;
  String type;

  PrizeBreakUpMyLeague({this.from, this.prize, this.to, this.type});
}

class InfoMyLeague {
  String slNo;
  String date;
  String location;
  String status;
  InfoMyLeague({this.date, this.location, this.slNo, this.status});
}
