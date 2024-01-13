// class TransactionHistoryDiposit {
//   int? id;
//   int? transactionTypeId;
//   int? walletId;
//   double? amount;
//   Null? deletedAt;
//   String? createdAt;
//   String? updatedAt;
//   bool? status;
//   String? description;
//   TransactionType? transactionType;
//   Wallet? wallet;

//   TransactionHistoryDiposit(
//       {this.id,
//       this.transactionTypeId,
//       this.walletId,
//       this.amount,
//       this.deletedAt,
//       this.createdAt,
//       this.updatedAt,
//       this.status,
//       this.description,
//       this.transactionType,
//       this.wallet});

//   TransactionHistoryDiposit.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     transactionTypeId = json['transaction_type_id'];
//     walletId = json['wallet_id'];
//     amount = double.parse(json['amount'].toString());
//     deletedAt = json['deleted_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     status = json['status'];
//     description = json['description'];
//     transactionType = json['transaction_type'] != null
//         ? new TransactionType.fromJson(json['transaction_type'])
//         : null;
//     wallet =
//         json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['transaction_type_id'] = this.transactionTypeId;
//     data['wallet_id'] = this.walletId;
//     data['amount'] = this.amount;
//     data['deleted_at'] = this.deletedAt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['status'] = this.status;
//     data['description'] = this.description;
//     if (this.transactionType != null) {
//       data['transaction_type'] = this.transactionType!.toJson();
//     }
//     if (this.wallet != null) {
//       data['wallet'] = this.wallet!.toJson();
//     }
//     return data;
//   }
// }

// class TransactionType {
//   int? id;
//   String? name;
//   Null? deletedAt;
//   String? createdAt;
//   String? updatedAt;

//   TransactionType(
//       {this.id, this.name, this.deletedAt, this.createdAt, this.updatedAt});

//   TransactionType.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     deletedAt = json['deleted_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['deleted_at'] = this.deletedAt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

// class Wallet {
//   int? id;
//   String? code;
//   int? userId;
//   double? balance;
//   Null? deletedAt;
//   String? createdAt;
//   String? updatedAt;
//   User? user;

//   Wallet(
//       {this.id,
//       this.code,
//       this.userId,
//       this.balance,
//       this.deletedAt,
//       this.createdAt,
//       this.updatedAt,
//       this.user});

//   Wallet.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     code = json['code'];
//     userId = json['user_id'];
//     balance = double.parse(json['balance'].toString());
//     deletedAt = json['deleted_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['code'] = this.code;
//     data['user_id'] = this.userId;
//     data['balance'] = this.balance;
//     data['deleted_at'] = this.deletedAt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     return data;
//   }
// }

// class User {
//   int? id;
//   String? username;
//   String? fullName;
//   String? email;
//   String? phone;
//   String? userType;
//   Null? emailVerifiedAt;
//   int? active;
//   String? createdAt;
//   String? updatedAt;
//   String? image;
//   String? location;

//   User(
//       {this.id,
//       this.username,
//       this.fullName,
//       this.email,
//       this.phone,
//       this.userType,
//       this.emailVerifiedAt,
//       this.active,
//       this.createdAt,
//       this.updatedAt,
//       this.image,
//       this.location});

//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     username = json['username'];
//     fullName = json['full_name'];
//     email = json['email'];
//     phone = json['phone'];
//     userType = json['user_type'];
//     emailVerifiedAt = json['email_verified_at'];
//     active = json['active'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     image = json['image'];
//     location = json['location'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['username'] = this.username;
//     data['full_name'] = this.fullName;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['user_type'] = this.userType;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['active'] = this.active;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['image'] = this.image;
//     data['location'] = this.location;
//     return data;
//   }
// }
class TransactionHistoryNotTransfer {
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

  TransactionHistoryNotTransfer(
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
      this.wallet});

  TransactionHistoryNotTransfer.fromJson(Map<String, dynamic> json) {
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
  User? user;

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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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

class User {
  int? id;
  String? username;
  String? fullName;
  String? email;
  String? phone;
  String? userType;
  Null? emailVerifiedAt;
  bool? active;
  String? createdAt;
  String? updatedAt;
  String? image;
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