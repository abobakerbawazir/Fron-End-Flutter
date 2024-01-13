// //getInfoOneTransactionHistoryToTransfer/64 by id transaction
class TransactionHistoryToTransferOne {
  User? userBranch;
  TransactionType? transactionType;
  Treansaction? treansaction;
  Booking? booking;
  User? userCars;
  User? userBooking;
  Wallet? walletCustomer;
  User? userCustomer;
  Wallet? walletBranch;
  Car? car;

  TransactionHistoryToTransferOne(
      {this.userBranch,
      this.transactionType,
      this.treansaction,
      this.booking,
      this.userCars,
      this.userBooking,
      this.walletCustomer,
      this.userCustomer,
      this.walletBranch,
      this.car});

  TransactionHistoryToTransferOne.fromJson(Map<String, dynamic> json) {
    userBranch = json['userBranch'] != null
        ? new User.fromJson(json['userBranch'])
        : null;
    transactionType = json['transactionType'] != null
        ? new TransactionType.fromJson(json['transactionType'])
        : null;
    treansaction = json['treansaction'] != null
        ? new Treansaction.fromJson(json['treansaction'])
        : null;
    booking =
        json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
    userCars =
        json['userCars'] != null ? new User.fromJson(json['userCars']) : null;
    userBooking = json['userBooking'] != null
        ? new User.fromJson(json['userBooking'])
        : null;
    walletCustomer = json['walletCustomer'] != null
        ? new Wallet.fromJson(json['walletCustomer'])
        : null;
    userCustomer = json['userCustomer'] != null
        ? new User.fromJson(json['userCustomer'])
        : null;
    walletBranch = json['walletBranch'] != null
        ? new Wallet.fromJson(json['walletBranch'])
        : null;
    car = json['car'] != null ? new Car.fromJson(json['car']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userBranch != null) {
      data['userBranch'] = this.userBranch!.toJson();
    }
    if (this.transactionType != null) {
      data['transactionType'] = this.transactionType!.toJson();
    }
    if (this.treansaction != null) {
      data['treansaction'] = this.treansaction!.toJson();
    }
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    if (this.userCars != null) {
      data['userCars'] = this.userCars!.toJson();
    }
    if (this.userBooking != null) {
      data['userBooking'] = this.userBooking!.toJson();
    }
    if (this.walletCustomer != null) {
      data['walletCustomer'] = this.walletCustomer!.toJson();
    }
    if (this.userCustomer != null) {
      data['userCustomer'] = this.userCustomer!.toJson();
    }
    if (this.walletBranch != null) {
      data['walletBranch'] = this.walletBranch!.toJson();
    }
    if (this.car != null) {
      data['car'] = this.car!.toJson();
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

class TransactionType {
  int? id;
  String? name;

  TransactionType({this.id, this.name});

  TransactionType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Treansaction {
  int? id;
  int? transactionTypeId;
  int? walletId;
  int? bookingId;
  int? amount;
  bool? status;
  String? description;

  Treansaction(
      {this.id,
      this.transactionTypeId,
      this.walletId,
      this.bookingId,
      this.amount,
      this.status,
      this.description});

  Treansaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionTypeId = json['transaction_type_id'];
    walletId = json['wallet_id'];
    bookingId = json['booking_id'];
    amount = json['amount'];
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
}

class Booking {
  int? id;
  String? from;
  String? to;
  int? total;
  int? userId;
  int? carId;
  String? status;
  String? paymentStatus;

  Booking(
      {this.id,
      this.from,
      this.to,
      this.total,
      this.userId,
      this.carId,
      this.status,
      this.paymentStatus});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    to = json['to'];
    total = json['total'];
    userId = json['user_id'];
    carId = json['car_id'];
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
    data['status'] = this.status;
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}

class Wallet {
  int? id;
  String? code;
  double? balance;
  int? userId;

  Wallet({this.id, this.code, this.balance, this.userId});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    balance = double.parse(json['balance'].toString());
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['balance'] = this.balance;
    data['user_id'] = this.userId;
    return data;
  }
}

class Car {
  int? id;
  String? name;
  String? model;
  bool? active;
  int? price;
  int? userId;
  int? prandId;

  Car(
      {this.id,
      this.name,
      this.model,
      this.active,
      this.price,
      this.userId,
      this.prandId});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    model = json['model'];
    active = json['active'];
    price = json['price'];
    userId = json['user_id'];
    prandId = json['prand_id'];
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
    return data;
  }
}
// class TransactionHistoryToTransferOne {
//   UserBranch? userBranch;
//   TransactionType? transactionType;
//   Treansaction? treansaction;
//   Booking? booking;
//   UserBranch? userCars;
//   UserBranch? userBooking;
//   WalletCustomer? walletCustomer;
//   UserBranch? userCustomer;
//   WalletCustomer? walletBranch;
//   Car? car;

//   TransactionHistoryToTransferOne(
//       {this.userBranch,
//       this.transactionType,
//       this.treansaction,
//       this.booking,
//       this.userCars,
//       this.userBooking,
//       this.walletCustomer,
//       this.userCustomer,
//       this.walletBranch,
//       this.car});

//   TransactionHistoryToTransferOne.fromJson(Map<String, dynamic> json) {
//     userBranch = json['userBranch'] != null
//         ? new UserBranch.fromJson(json['userBranch'])
//         : null;
//     transactionType = json['transactionType'] != null
//         ? new TransactionType.fromJson(json['transactionType'])
//         : null;
//     treansaction = json['treansaction'] != null
//         ? new Treansaction.fromJson(json['treansaction'])
//         : null;
//     booking =
//         json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
//     userCars = json['userCars'] != null
//         ? new UserBranch.fromJson(json['userCars'])
//         : null;
//     userBooking = json['userBooking'] != null
//         ? new UserBranch.fromJson(json['userBooking'])
//         : null;
//     walletCustomer = json['walletCustomer'] != null
//         ? new WalletCustomer.fromJson(json['walletCustomer'])
//         : null;
//     userCustomer = json['userCustomer'] != null
//         ? new UserBranch.fromJson(json['userCustomer'])
//         : null;
//     walletBranch = json['walletBranch'] != null
//         ? new WalletCustomer.fromJson(json['walletBranch'])
//         : null;
//     car = json['car'] != null ? new Car.fromJson(json['car']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.userBranch != null) {
//       data['userBranch'] = this.userBranch!.toJson();
//     }
//     if (this.transactionType != null) {
//       data['transactionType'] = this.transactionType!.toJson();
//     }
//     if (this.treansaction != null) {
//       data['treansaction'] = this.treansaction!.toJson();
//     }
//     if (this.booking != null) {
//       data['booking'] = this.booking!.toJson();
//     }
//     if (this.userCars != null) {
//       data['userCars'] = this.userCars!.toJson();
//     }
//     if (this.userBooking != null) {
//       data['userBooking'] = this.userBooking!.toJson();
//     }
//     if (this.walletCustomer != null) {
//       data['walletCustomer'] = this.walletCustomer!.toJson();
//     }
//     if (this.userCustomer != null) {
//       data['userCustomer'] = this.userCustomer!.toJson();
//     }
//     if (this.walletBranch != null) {
//       data['walletBranch'] = this.walletBranch!.toJson();
//     }
//     if (this.car != null) {
//       data['car'] = this.car!.toJson();
//     }
//     return data;
//   }
// }

// class UserBranch {
//   int? id;
//   String? username;
//   String? fullName;
//   String? email;
//   String? phone;
//   String? userType;
//   Null? emailVerifiedAt;
//   bool? active;
//   String? createdAt;
//   String? updatedAt;
//   String? image;
//   String? location;

//   UserBranch(
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

//   UserBranch.fromJson(Map<String, dynamic> json) {
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

// class TransactionType {
//   int? id;
//   String? name;

//   TransactionType({this.id, this.name});

//   TransactionType.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     return data;
//   }
// }

// class Treansaction {
//   int? id;
//   int? transactionTypeId;
//   int? walletId;
//   int? bookingId;
//   int? amount;
//   bool? status;
//   String? description;

//   Treansaction(
//       {this.id,
//       this.transactionTypeId,
//       this.walletId,
//       this.bookingId,
//       this.amount,
//       this.status,
//       this.description});

//   Treansaction.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     transactionTypeId = json['transaction_type_id'];
//     walletId = json['wallet_id'];
//     bookingId = json['booking_id'];
//     amount = json['amount'];
//     status = json['status'];
//     description = json['description'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['transaction_type_id'] = this.transactionTypeId;
//     data['wallet_id'] = this.walletId;
//     data['booking_id'] = this.bookingId;
//     data['amount'] = this.amount;
//     data['status'] = this.status;
//     data['description'] = this.description;
//     return data;
//   }
// }

// class Booking {
//   int? id;
//   String? from;
//   String? to;
//   int? total;
//   int? userId;
//   int? carId;
//   String? status;
//   String? paymentStatus;

//   Booking(
//       {this.id,
//       this.from,
//       this.to,
//       this.total,
//       this.userId,
//       this.carId,
//       this.status,
//       this.paymentStatus});

//   Booking.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     from = json['from'];
//     to = json['to'];
//     total = json['total'];
//     userId = json['user_id'];
//     carId = json['car_id'];
//     status = json['status'];
//     paymentStatus = json['payment_status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['from'] = this.from;
//     data['to'] = this.to;
//     data['total'] = this.total;
//     data['user_id'] = this.userId;
//     data['car_id'] = this.carId;
//     data['status'] = this.status;
//     data['payment_status'] = this.paymentStatus;
//     return data;
//   }
// }

// class WalletCustomer {
//   int? id;
//   String? code;
//   int? balance;
//   int? userId;

//   WalletCustomer({this.id, this.code, this.balance, this.userId});

//   WalletCustomer.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     code = json['code'];
//     balance = json['balance'];
//     userId = json['user_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['code'] = this.code;
//     data['balance'] = this.balance;
//     data['user_id'] = this.userId;
//     return data;
//   }
// }

// class Car {
//   int? id;
//   String? name;
//   String? model;
//   bool? active;
//   int? price;
//   int? userId;
//   int? prandId;

//   Car(
//       {this.id,
//       this.name,
//       this.model,
//       this.active,
//       this.price,
//       this.userId,
//       this.prandId});

//   Car.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     model = json['model'];
//     active = json['active'];
//     price = json['price'];
//     userId = json['user_id'];
//     prandId = json['prand_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['model'] = this.model;
//     data['active'] = this.active;
//     data['price'] = this.price;
//     data['user_id'] = this.userId;
//     data['prand_id'] = this.prandId;
//     return data;
//   }
// }