//getInfoAllTransactionHistory
class TransactionHistoryAll {
  int? id;
  int? transactionTypeId;
  int? walletId;
  int? bookingId;
  int? amount;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  TransactionType? transactionType;
  Wallet? wallet;
  Booking? booking;

  TransactionHistoryAll(
      {this.id,
      this.transactionTypeId,
      this.walletId,
      this.bookingId,
      this.amount,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.transactionType,
      this.wallet,
      this.booking});

  TransactionHistoryAll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionTypeId = json['transaction_type_id'];
    walletId = json['wallet_id'];
    bookingId = json['booking_id'];
    amount = json['amount'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    transactionType = json['transaction_type'] != null
        ? new TransactionType.fromJson(json['transaction_type'])
        : null;
    wallet =
        json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
    booking =
        json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_type_id'] = this.transactionTypeId;
    data['wallet_id'] = this.walletId;
    data['booking_id'] = this.bookingId;
    data['amount'] = this.amount;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.transactionType != null) {
      data['transaction_type'] = this.transactionType!.toJson();
    }
    if (this.wallet != null) {
      data['wallet'] = this.wallet!.toJson();
    }
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    return data;
  }
}

class TransactionType {
  int? id;
  String? name;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  TransactionType(
      {this.id, this.name, this.deletedAt, this.createdAt, this.updatedAt});

  TransactionType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Wallet {
  int? id;
  String? code;
  int? userId;
  int? balance;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Wallet(
      {this.id,
      this.code,
      this.userId,
      this.balance,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    userId = json['user_id'];
    balance = json['balance'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['user_id'] = this.userId;
    data['balance'] = this.balance;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Booking {
  int? id;
  String? from;
  String? to;
  int? total;
  int? userId;
  int? carId;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? status;
  String? paymentStatus;

  Booking(
      {this.id,
      this.from,
      this.to,
      this.total,
      this.userId,
      this.carId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.paymentStatus});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    to = json['to'];
    total = json['total'];
    userId = json['user_id'];
    carId = json['car_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from'] = this.from;
    data['to'] = this.to;
    data['total'] = this.total;
    data['user_id'] = this.userId;
    data['car_id'] = this.carId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}