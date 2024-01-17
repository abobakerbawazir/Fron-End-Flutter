import 'package:booking_car_project_flutter/core/Constans/Api_URL_delete.dart';
import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/Models/Car/Car.dart';
import 'package:booking_car_project_flutter/features/Models/Car/ImageCar.dart';
import 'package:booking_car_project_flutter/features/Models/ImageCar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CarVM with ChangeNotifier {
  Dio connect = DioSingelton.getInstance();

  List<Car> _allCArs = [];
  List<Car> get allCArs => _allCArs;
  List<ImageCar> _imageCarLists = [];
  List<ImageCar> get imageCarLists => _imageCarLists;

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

  Future<List<ImageCar>> getallImageCarBYCarId({required int car_id}) async {
    print('${APIurl.getallImageCarBYCarIdURL}$car_id');
    Dio dio = DioSingelton.getInstance();
    Response response =
        await dio.get('${APIurl.getallImageCarBYCarIdURL}$car_id');
    try {
      List<dynamic> dataImage = response.data['data'];
      _imageCarLists = dataImage.map((e) => ImageCar.fromJson(e)).toList();
      print(_allCArs);
      print(dataImage);
      return _imageCarLists;
    } catch (e) {
      return _imageCarLists;
    }
  }

  Future addCarWithImage({required FormData formData}) async {
    print(APIurl.baseCarUrl + 'addCarAndImage');
    Dio dio = DioSingelton.getInstance();
    Response responce =
        await dio.post(APIurl.baseCarUrl + 'addCarAndImage', data: formData);
    var x = responce.data;
    notifyListeners();
    return x;
  }

  Future deleteCar({required int id}) async {
    Response responce =
        await connect.delete(API_URL_Delete.deleteCarUrl + id.toString());
    var data = responce.data;
    notifyListeners();
    return data;
  }
}
