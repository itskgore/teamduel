class MyJointMatches {
  String matchId;
  String contestId;
  String matchDestination;
  String startTime;
  String pricePerTicket;
  String userAllowedTickets;
  String ifFirstFree;
  String userMatchStatus;
  String userJointTickets;
  String matchTitle;
  String status;
  String flag;

  MyJointMatches(
      {this.contestId,
      this.flag,
      this.ifFirstFree,
      this.matchDestination,
      this.matchId,
      this.matchTitle,
      this.pricePerTicket,
      this.startTime,
      this.status,
      this.userAllowedTickets,
      this.userJointTickets,
      this.userMatchStatus});
}
