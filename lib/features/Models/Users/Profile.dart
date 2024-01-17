// class Profile {
//   String? username;
//   String? phone;
//   String? fullName;
//   String? userType;
//   String? email;
//   String? password;
//   String? password_confirmation;
//   String? roles;
//   int? active;
//   String? image;
//   String? location;

//   String? updatedAt;
//   String? createdAt;
//   int? id;
//   Profile(
//       {this.username,
//       this.phone,
//       this.fullName,
//       this.userType,
//       this.email,
//       this.password,
//       this.password_confirmation,
//       this.roles,
//       this.active,
//       this.image,
//       this.location,
//       this.updatedAt,
//       this.createdAt,
//       this.id});

//   Profile.fromJson(Map<String, dynamic> json) {
//     username = json['username'];
//     phone = json['phone'];
//     fullName = json['full_name'];
//     userType = json['user_type'];
//     email = json['email'];
//     password = json['password'];
//     password_confirmation = json['password_confirmation'];
//     roles = json['roles'];
//     active = json['active'];
//     image = json['image'];
//     location = json['location'];
//     updatedAt = json['updated_at'];
//     createdAt = json['created_at'];
//     id = json['id'];
//   }
//   Map<String, dynamic> toJsonActive() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['active'] = this.active;

//     return data;
//   }

//   Map<String, dynamic> toJsonProfile() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     //data['username'] = this.username;
//     data['phone'] = this.phone;
//     data['full_name'] = this.fullName;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['password_confirmation'] = this.password_confirmation;
//     //data['location'] = this.location;
//     return data;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['username'] = this.username;
//     data['phone'] = this.phone;
//     data['full_name'] = this.fullName;
//     data['user_type'] = this.userType;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['password_confirmation'] = this.password_confirmation;
//     data['roles'] = this.roles;
//     data['active'] = this.active;
//     data['updated_at'] = this.updatedAt;
//     data['created_at'] = this.createdAt;
//     data['id'] = this.id;
//     return data;
//   }
// }
class Branch {
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
  String? roles;

  Branch(
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
      this.location,
      this.roles});

  Branch.fromJson(Map<String, dynamic> json) {
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
    roles = json['roles'];
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
    data['roles'] = this.roles;
    return data;
  }
}
class UserSignUp {
  String? username;
  String? phone;
  String? fullName;
  String? userType;
  String? email;
  String? password;
  String? passwordConfirmation;
  String? role;

  UserSignUp(
      {this.username,
      this.phone,
      this.fullName,
      this.userType,
      this.email,
      this.password,
      this.passwordConfirmation,
      this.role});

  UserSignUp.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    phone = json['phone'];
    fullName = json['full_name'];
    userType = json['user_type'];
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    data['role'] = this.role;
    return data;
  }
}
class Profile {
  int? id;
  String? username;
  String? fullName;
  String? email;
  String? phone;
  String? userType;
  Null? emailVerifiedAt;
  int? active;
  String? password;
  String? password_confirmation;
  String? createdAt;
  String? updatedAt;
  String? image;
  String? location;
  String? token;
  Wallet? wallet;
  String? roles;
  String? role;

  Profile(
      {this.id,
      this.username,
      this.fullName,
      this.email,
      this.phone,
      this.userType,
      this.password,
      this.password_confirmation,
      this.emailVerifiedAt,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.image,
      this.location,
      this.token,
      this.wallet,
      this.roles,this.role});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    userType = json['user_type'];
    password = json['password'];
    password_confirmation = json['password_confirmation'];
    emailVerifiedAt = json['email_verified_at'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    location = json['location'];
    token = json['token'];
    wallet =
        json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
    roles = json['role'];
    role = json['roles'];
  }
  Map<String, dynamic> toJsonActive() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;

    return data;
  }

  Map<String, dynamic> toJsonProfile() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['username'] = this.username;
    data['phone'] = this.phone;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.password_confirmation;
    //data['location'] = this.location;
    return data;
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
    data['password'] = this.password;
    data['password_confirmation'] = this.password_confirmation;
    data['image'] = this.image;
    data['location'] = this.location;
    data['token'] = this.token;
    if (this.wallet != null) {
      data['wallet'] = this.wallet!.toJson();
    }
    data['role'] = this.roles;
    return data;
  }
    Map<String, dynamic> toJsonSignUP() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['full_name'] = this.fullName;
    data['user_type'] = this.userType;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.password_confirmation;
    data['role'] = this.roles;
    data['active'] = this.active;
    data['id'] = this.id;
    return data;
  }
  Map<String, dynamic> toJsonSignUPImage() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['full_name'] = this.fullName;
    data['user_type'] = this.userType;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.password_confirmation;
    data['role'] = this.roles;
    data['active'] = this.active;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['image'] = this.image;
    data['location'] = this.location;
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
