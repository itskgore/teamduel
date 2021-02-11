class Transaction {
  String id;
  String userId;
  String walletName;
  String withdrawAmount;
  String mobileNumber;
  String verificationId;
  String verificationStatus;
  String paymentStatus;
  String createdAt;
  String updatedAt;
  String depositedDate;

  Transaction(
      {this.id,
      this.userId,
      this.walletName,
      this.withdrawAmount,
      this.mobileNumber,
      this.verificationId,
      this.verificationStatus,
      this.paymentStatus,
      this.createdAt,
      this.updatedAt,
      this.depositedDate});
}
