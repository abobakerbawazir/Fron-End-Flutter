class TreansactionBooking {
  int? id;
  int? transactionTypeId;
  int? walletId;
  int? bookingId;
  String? code;
  double? amount;
  bool? status;
  String? description;

  TreansactionBooking(
      {this.id,
      this.transactionTypeId,
      this.walletId,
      this.bookingId,
      this.amount,
      this.code,
      this.status,
      this.description});

  TreansactionBooking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionTypeId = json['transaction_type_id'];
    walletId = json['wallet_id'];
    bookingId = json['booking_id'];
    amount = double.parse(json['amount'].toString());
    status = json['status'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_type_id'] = this.transactionTypeId;
    data['wallet_id'] = this.walletId;
    data['booking_id'] = this.bookingId;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['description'] = this.description;
    return data;
  }

  Map<String, dynamic> withdrawtoJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['amount'] = this.amount;
    data['status'] = this.status;
    return data;
  }

  Map<String, dynamic> diposittoJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet_id'] = this.walletId;
    data['amount'] = this.amount;
    data['description'] = this.description ?? "ليس هناك وصف";
    return data;
  }

  Map<String, dynamic> transferToJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['wallet_id'] = this.walletId;
    data['description'] = this.description ?? "ليس هناك وصف";
    return data;
  }
}
