import 'package:booking_car_project_flutter/features/Enum/enumStatus.dart';

class Booking {
  int? id;
  String? from;
  String? to;
  int? total;
  int? userId;
  int? carId;
  String? createdAt;
  String? updatedAt;
  String? days;
  String? status;

  Booking(
      {this.id,
      this.from,
      this.to,
      this.total,
      this.userId,
      this.carId,
      this.createdAt,
      this.updatedAt,
      this.days,
      this.status});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    to = json['to'];
    total = json['total'];
    userId = json['user_id'];
    carId = json['car_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    days = json['days'].toString();
    status = json['status'];
  }
  Map<String, dynamic> toJsonOnlyfromAndto() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['status'] = this.status??BookingStatus.Pending.value;
    return data;
  }
  Map<String, dynamic> toJsonOnlyStatus() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status??BookingStatus.Pending.value;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from'] = this.from;
    data['to'] = this.to;
    data['total'] = this.total;
    data['user_id'] = this.userId;
    data['car_id'] = this.carId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['days'] = this.days;
    data['status'] = this.status ?? BookingStatus.Pending.name;

    return data;
  }
}
