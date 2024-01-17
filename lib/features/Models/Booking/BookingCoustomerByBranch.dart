import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BookingCoustomerByBranch {
  int? id;
  String? from;
  String? to;
  int? total;
  int? userId;
  int? carId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? status;
  String? paymentStatus;
  Cars? cars;
  Users? user;

  BookingCoustomerByBranch(
      {this.id,
      this.from,
      this.to,
      this.total,
      this.userId,
      this.carId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.paymentStatus,
      this.cars,
      this.user});

  BookingCoustomerByBranch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    to = json['to'];
    total = json['total'];
    userId = json['user_id'];
    carId = json['car_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    cars = json['cars'] != null ? new Cars.fromJson(json['cars']) : null;
    user = json['user'] != null ? new Users.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from'] = this.from;
    data['to'] = this.to;
    data['total'] = this.total;
    data['user_id'] = this.userId;
    data['car_id'] = this.carId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    if (this.cars != null) {
      data['cars'] = this.cars!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Cars {
  int? id;
  String? name;
  String? model;
  int? active;
  int? price;
  int? userId;
  int? prandId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  Users? users;
  List<ImageCarBrands>? imageCarBrands;

  Cars(
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
      this.users,
      this.imageCarBrands});

  Cars.fromJson(Map<String, dynamic> json) {
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
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
    if (json['image_car_brands'] != null) {
      imageCarBrands = <ImageCarBrands>[];
      json['image_car_brands'].forEach((v) {
        imageCarBrands!.add(new ImageCarBrands.fromJson(v));
      });
    }
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
    if (this.users != null) {
      data['users'] = this.users!.toJson();
    }
    if (this.imageCarBrands != null) {
      data['image_car_brands'] =
          this.imageCarBrands!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  String? username;
  String? fullName;
  String? email;
  String? phone;
  String? userType;
  String? emailVerifiedAt;
  int? active;
  String? createdAt;
  String? updatedAt;
  String? image;
  String? location;

  Users(
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

  Users.fromJson(Map<String, dynamic> json) {
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

class ImageCarBrands {
  int? id;
  String? url;
  int? carId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  ImageCarBrands(
      {this.id,
      this.url,
      this.carId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  ImageCarBrands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    carId = json['car_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['car_id'] = this.carId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
