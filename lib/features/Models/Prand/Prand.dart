class Prand {
  int? id;
  String? name;
  String? path;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Prand(
      {this.id,
      this.name,
      this.path,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Prand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    path = json['path'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['path'] = this.path;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}