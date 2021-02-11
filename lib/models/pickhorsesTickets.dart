class PickHorsesMegaLeague {
  List<Tickets> tickets;
  List<Horses> horses;
  PickHorsesMegaLeague({this.horses, this.tickets});
}

class Tickets {
  String ticketId;
  String ticketBudget;
  String spent;
  Tickets({this.spent, this.ticketBudget, this.ticketId});
}

class Horses {
  String horseId;
  String horseName;
  String jockey;
  String playPoints;
  String selectedUserPer;
  String trainer;
  String playerPerformance;
  bool horseWithdrawalStatus;
  Horses(
      {this.horseId,
      this.trainer,
      this.horseName,
      this.horseWithdrawalStatus,
      this.jockey,
      this.playPoints,
      this.playerPerformance,
      this.selectedUserPer});
}
