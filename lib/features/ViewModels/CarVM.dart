import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/Models/Car/Car.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CarVM with ChangeNotifier{
    Dio connect = DioSingelton.getInstance();

List<Car> _allCArs = [];
  List<Car> get allCArs => _allCArs;
  Future<List<Car>> getCarsWithIdUserAndIdPrandWithApi(
      {required int user_id, prand_id}) async {
    print(
        '${APIurl.getCarWithUserAndPrand}?user_id=$user_id&prand_id=$prand_id');
    Dio dio = DioSingelton.getInstance();

    Response response = await dio.get(
        '${APIurl.getCarWithUserAndPrand}?user_id=$user_id&prand_id=$prand_id');
    try {
      List<dynamic> dtatAllBooking = response.data['data'];
      _allCArs = dtatAllBooking.map((e) => Car.fromJson(e)).toList();
      print(_allCArs);
      print(dtatAllBooking);
      print(user_id);
      print(prand_id);
      return _allCArs;
    } catch (e) {
      return _allCArs;
    }
  }
}