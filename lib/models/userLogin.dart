class UserLogin {
  int id;
  String name;
  String teamName;
  String email;
  String img;
  String dob;
  String mobileNumber;
  String gender;
  String userWalletCurrentAmount;
  String winnings;
  String bonusChips;
  String city;
  String state;
  String pincode;
  String country;
  String provider;
  String providerId;
  int status;
  int roleId;
  String adminType;
  String passwordToken;
  String lastLogin;
  String referalCode;

  UserLogin(
      {this.id,
      this.name,
      this.teamName,
      this.email,
      this.img,
      this.dob,
      this.mobileNumber,
      this.gender,
      this.userWalletCurrentAmount,
      this.winnings,
      this.bonusChips,
      this.city,
      this.state,
      this.pincode,
      this.country,
      this.provider,
      this.providerId,
      this.status,
      this.roleId,
      this.adminType,
      this.passwordToken,
      this.lastLogin,
      this.referalCode});
}
