class JoinedMatchups {
  int matchupId;
  String registerId;
  int betAmount;
  int returnPayout;
  String returnPayoutType;
  int matchupCount;
  String scoreStaus;
  String matchupStatus;
  String matchupDate;

  JoinedMatchups(
      {this.matchupId,
      this.registerId,
      this.betAmount,
      this.returnPayout,
      this.returnPayoutType,
      this.matchupCount,
      this.scoreStaus,
      this.matchupStatus,
      this.matchupDate});

  JoinedMatchups.fromJson(Map<String, dynamic> json) {
    matchupId = json['matchup_id'];
    registerId = json['register_id'];
    betAmount = json['bet_amount'];
    returnPayout = json['return_payout'];
    returnPayoutType = json['return_payout_type'];
    matchupCount = json['matchup_count'];
    scoreStaus = json['score_staus'];
    matchupStatus = json['matchup_status'];
    matchupDate = json['matchup_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['matchup_id'] = this.matchupId;
    data['register_id'] = this.registerId;
    data['bet_amount'] = this.betAmount;
    data['return_payout'] = this.returnPayout;
    data['return_payout_type'] = this.returnPayoutType;
    data['matchup_count'] = this.matchupCount;
    data['score_staus'] = this.scoreStaus;
    data['matchup_status'] = this.matchupStatus;
    data['matchup_date'] = this.matchupDate;
    return data;
  }
}
