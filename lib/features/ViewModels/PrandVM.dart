import 'dart:io';
import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Constans/Api_Url_Prand.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/Models/Prand/Prand.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PrandVM with ChangeNotifier {
  static PrandVM? _objectDio;
  static PrandVM getInstanceSinglton() {
    if (_objectDio == null) _objectDio = PrandVM();
    return _objectDio!;
  }

  final nameController = TextEditingController();
  myNotifyListeners() {
    // textEditingController.text = value;
    //value = textEditingController.text;
    notifyListeners();
  }

  clearControlle(TextEditingController textEditingController) {
    textEditingController.clear();
    notifyListeners();
  }

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

  Future<List<Prand>> filtterPrandName({required String fultterName}) async {
    print(ApiUrlPrand.filtterPrandNameUrl + fultterName);
    try {
      Response responce =
          await connect.get(ApiUrlPrand.filtterPrandNameUrl + '${fultterName}');
      print(responce.data['data']);
      List<dynamic> dataPrands = responce.data['data'];
      print(responce.data['data']);
      _allPrands = dataPrands
          .map((e) => Prand.fromJson(e as Map<String, dynamic>))
          .toList();
      //notifyListeners();
      print(_allPrands);
      return _allPrands;
    } catch (e) {
      return _allPrands;
    }
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
