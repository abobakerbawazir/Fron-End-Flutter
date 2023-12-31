import 'dart:io';
import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/Models/Prand/Prand.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class PrandVM with ChangeNotifier {
  Dio connect = DioSingelton.getInstance();
  List<Prand> _allPrands = [];
  List<Prand> get allPrands => _allPrands;
  Future<List<Prand>> getAllPrandsFromAPi() async {
    Response responce = await connect.get(APIurl.getImageUrl);
    print(responce.data['data']);
    List<dynamic> dataPrands = responce.data['data'];
    print(responce.data['data']);
    _allPrands = dataPrands
        .map((e) => Prand.fromJson(e as Map<String, dynamic>))
        .toList();
    print(_allPrands);
    return _allPrands;
  }

  Future deleteBrand(int id) async {
    Response responce =
        await connect.delete(APIurl.deleteBrandUrl + id.toString());
    var code = responce.data["code"];
    notifyListeners();
    return code;
  }

  Future addBrand() async {
    // File imageFile=await ImagePicker.
    // FormData fromdata = FormData.fromMap({'image_path':MultipartFile.fromBytes(value)});
    // Response responce =
    //     await connect.post(APIurl.deleteBrandUrl + id.toString());
    // var code = responce.data["code"];
    // notifyListeners();
    // return code;
  }
}
