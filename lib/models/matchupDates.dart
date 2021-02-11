class MatchupDates {
  bool status;
  List<int> data;

  MatchupDates({this.status, this.data});

  MatchupDates.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    return data;
  }
}
