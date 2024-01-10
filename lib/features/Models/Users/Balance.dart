class Balance {
  double? balance;

  Balance({this.balance});

  Balance.fromJson(Map<String, dynamic> json) {
    balance = double.parse(json['balance'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    return data;
  }
}

class Wallet {
  int? id;
  String? code;
  int? userId;
  double? balance;

  Wallet({this.id, this.code, this.userId, this.balance});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    userId = json['user_id'];
    balance = json['balance'];
  }
  Wallet.fromJsonBalance(Map<String, dynamic> json) {
    balance = json['balance'];
  }
  Map<String, dynamic> toJsonBalance() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['user_id'] = this.userId;
    data['balance'] = this.balance;
    return data;
  }
}
