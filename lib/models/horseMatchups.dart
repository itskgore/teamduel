class Races {
  String raceName;
  Races({this.raceName});
  Races.fromJson(Map<String, dynamic> json) {
    raceName = json['raceName'] ?? "";
  }
}

class HorseMatchups {
  int raceId;
  String raceDate;
  String raceStartTime;
  String raceEndTime;
  String raceName;
  String raceLocation;
  String raceCountry;
  String utcMatchStartTimeStamp;
  String utcMatchEndTimeStamp;
  List<Matchups> matchups;

  HorseMatchups(
      {this.raceId,
      this.raceDate,
      this.raceStartTime,
      this.raceEndTime,
      this.raceName,
      this.raceLocation,
      this.raceCountry,
      this.utcMatchEndTimeStamp,
      this.utcMatchStartTimeStamp,
      this.matchups});

  HorseMatchups.fromJson(Map<String, dynamic> json) {
    raceId = json['race_id'];
    raceDate = json['race_date'];
    raceStartTime = json['race_start_time'];
    raceEndTime = json['race_end_time'];
    raceName = json['race_name'];
    raceLocation = json['race_location'];
    raceCountry = json['race_country'];
    utcMatchEndTimeStamp = json['utc_race_end_timeStamp'].toString();
    utcMatchStartTimeStamp = json['utc_race_start_timeStamp'].toString();

    if (json['matchups'] != null) {
      matchups = new List<Matchups>();
      json['matchups'].forEach((v) {
        matchups.add(new Matchups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['race_id'] = this.raceId;
    data['race_date'] = this.raceDate;
    data['race_start_time'] = this.raceStartTime;
    data['race_end_time'] = this.raceEndTime;
    data['race_name'] = this.raceName;
    data['race_location'] = this.raceLocation;
    data['race_country'] = this.raceCountry;
    if (this.matchups != null) {
      data['matchups'] = this.matchups.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Matchups {
  int matchupId;
  MatchupOne matchupOne;
  MatchupOne matchupTwo;

  Matchups({this.matchupId, this.matchupOne, this.matchupTwo});

  Matchups.fromJson(Map<String, dynamic> json) {
    matchupId = json['matchup_id'];
    matchupOne = json['matchup_one'] != null
        ? new MatchupOne.fromJson(json['matchup_one'])
        : null;
    matchupTwo = json['matchup_two'] != null
        ? new MatchupOne.fromJson(json['matchup_two'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['matchup_id'] = this.matchupId;
    if (this.matchupOne != null) {
      data['matchup_one'] = this.matchupOne.toJson();
    }
    if (this.matchupTwo != null) {
      data['matchup_two'] = this.matchupTwo.toJson();
    }
    return data;
  }
}

class MatchupOne {
  String horseNo;
  String horseName;
  String jockey;
  String trainer;
  bool star;

  MatchupOne(
      {this.horseNo, this.horseName, this.jockey, this.trainer, this.star});

  MatchupOne.fromJson(Map<String, dynamic> json) {
    horseNo = json['horse_no'];
    horseName = json['horse_name'];
    jockey = json['jockey'];
    trainer = json['trainer'];
    star = json['star'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['horse_no'] = this.horseNo;
    data['horse_name'] = this.horseName;
    data['jockey'] = this.jockey;
    data['trainer'] = this.trainer;
    data['star'] = this.star;
    return data;
  }
}

class HorseMatchesData {
  String locations;
  HorseMatchesData({this.locations});
}
