class Car {
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
  String? imageCarOfBrands;

  Car(
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
      this.imageCarOfBrands});

  Car.fromJson(Map<String, dynamic> json) {
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
    imageCarOfBrands = json['image_car_of_brands'];
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
    data['image_car_of_brands'] = this.imageCarOfBrands;
    return data;
  }
}