class MyMatches {
  String matchesId;
  String contestId;
  String matchDestination;
  String seconds;
  String pricePerTicket;
  String userAllowedTicket;
  String isFirstFree;
  String userMatchStatus;
  String userJoinedTicket;
  String matchTitle;
  String status;
  String flag;

  MyMatches(
      {this.contestId,
      this.flag,
      this.isFirstFree,
      this.matchDestination,
      this.matchTitle,
      this.matchesId,
      this.pricePerTicket,
      this.seconds,
      this.status,
      this.userAllowedTicket,
      this.userJoinedTicket,
      this.userMatchStatus});
}
