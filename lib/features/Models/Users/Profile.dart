class Profile {
  String? username;
  String? phone;
  String? fullName;
  String? userType;
  String? email;
  String? password;
  String? password_confirmation;
  String? role;
  String? roles;
  int? active;

  String? updatedAt;
  String? createdAt;
  int? id;
  Profile(
      {this.username,
      this.phone,
      this.fullName,
      this.userType,
      this.email,
      this.password,
      this.password_confirmation,
      this.role,
      this.roles,
      this.active,
      this.updatedAt,
      this.createdAt,
      this.id});

  Profile.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    phone = json['phone'];
    fullName = json['full_name'];
    userType = json['user_type'];
    email = json['email'];
    password = json['password'];
    password_confirmation = json['password_confirmation'];
    role = json['role'];
    roles = json['roles'];
    active = json['active'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  Map<String, dynamic> toJsonActive() {

    final Map<String, dynamic> data = new Map<String, dynamic>();
        data['active'] = this.active;

        return data;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['full_name'] = this.fullName;
    data['user_type'] = this.userType;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.password_confirmation;
    data['role'] = this.role;
    data['roles'] = this.roles;
    data['active'] = this.active;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
