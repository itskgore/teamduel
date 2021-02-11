class User {
  String name;
  String email;
  String country;
  String img;
  String dob;
  String mobileNumber;
  String referalCode;
  int bonusChips;
  int status;
  int roleId;
  String teamName;
  int id;

  User(
      {this.name,
      this.email,
      this.country,
      this.img,
      this.dob,
      this.mobileNumber,
      this.referalCode,
      this.bonusChips,
      this.status,
      this.roleId,
      this.teamName,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    country = json['country'];
    img = json['img'];
    dob = json['dob'];
    mobileNumber = json['mobile_number'];
    referalCode = json['referal_code'];
    bonusChips = json['bonus_chips'];
    status = json['status'];
    roleId = json['role_id'];
    teamName = json['team_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['country'] = this.country;
    data['img'] = this.img;
    data['dob'] = this.dob;
    data['mobile_number'] = this.mobileNumber;
    data['referal_code'] = this.referalCode;
    data['bonus_chips'] = this.bonusChips;
    data['status'] = this.status;
    data['role_id'] = this.roleId;
    data['team_name'] = this.teamName;
    data['id'] = this.id;
    return data;
  }
}
