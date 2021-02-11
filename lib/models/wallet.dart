class Chips {
  static String total;
  final String totalchips;
  final String id;
  final String uid;
  final String amount;
  final String type;
  final String bonus;
  final String message;
  final String createdAt;
  final String updatedAt;

  Chips(
      {this.totalchips,
      this.id,
      this.uid,
      this.amount,
      this.type,
      this.bonus,
      this.message,
      this.createdAt,
      this.updatedAt});
}

class Coins {
  static String total;
  final String totalcoins;
  final String id;
  final String uid;
  final String amount;
  final String type;
  final String bonus;
  final String message;
  final String createdAt;
  final String updatedAt;

  Coins(
      {this.totalcoins,
      this.id,
      this.uid,
      this.amount,
      this.type,
      this.bonus,
      this.message,
      this.createdAt,
      this.updatedAt});
}
