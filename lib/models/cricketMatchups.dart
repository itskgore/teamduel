class CricketMatchups {
  String matchId;
  String matchTeamOne;
  String matchTeamTwo;
  String matchDate;
  String matchStartTime;
  String matchEndTime;
  String matchStatus;
  String utcMatchStartTime;
  String utcMatchStartTimeStamp;
  String utcMatchEndTimeStamp;
  List<Matchups> matchups;

  CricketMatchups(
      {this.matchId,
      this.matchTeamOne,
      this.matchTeamTwo,
      this.matchDate,
      this.matchStartTime,
      this.matchEndTime,
      this.matchStatus,
      this.utcMatchStartTime,
      this.utcMatchEndTimeStamp,
      this.utcMatchStartTimeStamp,
      this.matchups});

  CricketMatchups.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'].toString();
    matchTeamOne = json['match_team_one'].toString();
    matchTeamTwo = json['match_team_two'].toString();
    utcMatchStartTime = json['utc_match_start_time'].toString();
    matchDate = json['match_date'].toString();
    matchStartTime = json['match_start_time'].toString();
    matchEndTime = json['match_end_time'].toString();
    matchStatus = json['match_status'].toString();
    utcMatchEndTimeStamp = json['utc_match_end_timeStamp'].toString();
    utcMatchStartTimeStamp = json['utc_match_start_timeStamp'].toString();

    if (json['matchups'] != null) {
      matchups = new List<Matchups>();
      json['matchups'].forEach((v) {
        matchups.add(new Matchups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = this.matchId;
    data['match_team_one'] = this.matchTeamOne;
    data['match_team_two'] = this.matchTeamTwo;
    data['match_date'] = this.matchDate;
    data['match_start_time'] = this.matchStartTime;
    data['match_end_time'] = this.matchEndTime;
    data['match_status'] = this.matchStatus;
    if (this.matchups != null) {
      data['matchups'] = this.matchups.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Matchups {
  String matchid;
  MatchupOne matchupOne;
  MatchupOne matchupTwo;
  String winner;
  String isAbandon;
  int matchupId;

  Matchups(
      {this.matchid,
      this.matchupOne,
      this.matchupTwo,
      this.winner,
      this.isAbandon,
      this.matchupId});

  Matchups.fromJson(Map<String, dynamic> json) {
    matchid = json['matchid'].toString();
    matchupOne = json['matchup_one'] != null
        ? new MatchupOne.fromJson(json['matchup_one'])
        : null;
    matchupTwo = json['matchup_two'] != null
        ? new MatchupOne.fromJson(json['matchup_two'])
        : null;
    winner = json['winner'].toString();
    isAbandon = json['is_abandon'].toString();
    matchupId = json['matchup_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['matchid'] = this.matchid;
    if (this.matchupOne != null) {
      data['matchup_one'] = this.matchupOne.toJson();
    }
    if (this.matchupTwo != null) {
      data['matchup_two'] = this.matchupTwo.toJson();
    }
    data['winner'] = this.winner;
    data['is_abandon'] = this.isAbandon;
    data['matchup_id'] = this.matchupId;
    return data;
  }
}

class MatchupOne {
  String playerId;
  String playerName;
  String playerTeamName;
  String playerRole;
  bool star;
  String jersy;

  MatchupOne(
      {this.playerId,
      this.playerName,
      this.playerTeamName,
      this.playerRole,
      this.star,
      this.jersy});

  MatchupOne.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'].toString();
    playerName = json['player_name'].toString();
    playerTeamName = json['player_team_name'].toString();
    playerRole = json['player_role'].toString();
    star = json['star'];
    jersy = json['jersy'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId;
    data['player_name'] = this.playerName;
    data['player_team_name'] = this.playerTeamName;
    data['player_role'] = this.playerRole;
    data['star'] = this.star;
    data['jersy'] = this.jersy;
    return data;
  }
}

class CricketMatches {
  int seriesId;
  String seriesName;

  CricketMatches({this.seriesId, this.seriesName});

  CricketMatches.fromJson(Map<String, dynamic> json) {
    seriesId = json['series_id'];
    seriesName = json['series_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['series_id'] = this.seriesId;
    data['series_name'] = this.seriesName;
    return data;
  }
}
