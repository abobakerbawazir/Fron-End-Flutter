// class ImageCar {
//   int? id;
//   String? url;
//   int? carId;
//   Null? deletedAt;
//   String? createdAt;
//   String? updatedAt;
//   Null? cars;

//   ImageCar(
//       {this.id,
//       this.url,
//       this.carId,
//       this.deletedAt,
//       this.createdAt,
//       this.updatedAt,
//       this.cars});

//   ImageCar.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     url = json['url'];
//     carId = json['car_id'];
//     deletedAt = json['deleted_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     cars = json['cars'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['url'] = this.url;
//     data['car_id'] = this.carId;
//     data['deleted_at'] = this.deletedAt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['cars'] = this.cars;
//     return data;
//   }
// }