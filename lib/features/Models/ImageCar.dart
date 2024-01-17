class ImageCar {
  int? id;
  String? url;
  int? carId;

  ImageCar({this.id, this.url, this.carId});

  ImageCar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    carId = json['car_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['car_id'] = this.carId;
    return data;
  }
}