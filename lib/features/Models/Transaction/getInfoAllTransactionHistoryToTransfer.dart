//getInfoAllTransactionHistoryToTransfer
class TransactionHistoryToAllTransfer {
  int? id;
  int? transactionTypeId;
  int? walletId;
  int? bookingId;
  int? amount;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  bool? status;
  String? description;
  TransactionType? transactionType;
  Wallet? wallet;
  Booking? booking;

  TransactionHistoryToAllTransfer(
      {this.id,
      this.transactionTypeId,
      this.walletId,
      this.bookingId,
      this.amount,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.description,
      this.transactionType,
      this.wallet,
      this.booking});

  TransactionHistoryToAllTransfer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionTypeId = json['transaction_type_id'];
    walletId = json['wallet_id'];
    bookingId = json['booking_id'];
    amount = json['amount'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    description = json['description'];
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
    data['status'] = this.status;
    data['description'] = this.description;
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
  dynamic? balance;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  WalletUser? user;

  Wallet(
      {this.id,
      this.code,
      this.userId,
      this.balance,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.user});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    userId = json['user_id'];
    balance = json['balance'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new WalletUser.fromJson(json['user']) : null;
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
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class WalletUser {
  int? id;
  String? username;
  String? fullName;
  String? email;
  String? phone;
  String? userType;
  Null? emailVerifiedAt;
  int? active;
  String? createdAt;
  String? updatedAt;
  String? image;
  String? location;

  WalletUser(
      {this.id,
      this.username,
      this.fullName,
      this.email,
      this.phone,
      this.userType,
      this.emailVerifiedAt,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.image,
      this.location});

  WalletUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    userType = json['user_type'];
    emailVerifiedAt = json['email_verified_at'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['user_type'] = this.userType;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['location'] = this.location;
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
  User? user;
  Cars? cars;

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
      this.paymentStatus,
      this.user,
      this.cars});

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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    cars = json['cars'] != null ? new Cars.fromJson(json['cars']) : null;
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
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.cars != null) {
      data['cars'] = this.cars!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? fullName;
  String? email;
  String? phone;
  String? userType;
  Null? emailVerifiedAt;
  int? active;
  String? createdAt;
  String? updatedAt;
  Null? image;
  String? location;

  User(
      {this.id,
      this.username,
      this.fullName,
      this.email,
      this.phone,
      this.userType,
      this.emailVerifiedAt,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.image,
      this.location});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    userType = json['user_type'];
    emailVerifiedAt = json['email_verified_at'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['user_type'] = this.userType;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['location'] = this.location;
    return data;
  }
}

class Cars {
  int? id;
  String? name;
  String? model;
  int? active;
  int? price;
  int? userId;
  int? prandId;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  User? users;

  Cars(
      {this.id,
      this.name,
      this.model,
      this.active,
      this.price,
      this.userId,
      this.prandId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.users});

  Cars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    model = json['model'];
    active = json['active'];
    price = json['price'];
    userId = json['user_id'];
    prandId = json['prand_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    users = json['users'] != null ? new User.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['model'] = this.model;
    data['active'] = this.active;
    data['price'] = this.price;
    data['user_id'] = this.userId;
    data['prand_id'] = this.prandId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.users != null) {
      data['users'] = this.users!.toJson();
    }
    return data;
  }
}