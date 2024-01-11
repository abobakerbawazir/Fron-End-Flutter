import 'package:booking_car_project_flutter/core/Constans/Api_Url_Transaction.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/Models/Transaction/TransactionHistoreyDiposit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TransactionVM with ChangeNotifier {
  final box = GetStorage();
  List<TransactionHistoryDiposit> _getInfoAllTransactionHistoryDiposit = [];
  List<TransactionHistoryDiposit> get getInfoAllTransactionHistoryDiposit =>
      _getInfoAllTransactionHistoryDiposit;

  Dio connect = DioSingelton.getInstance();
  Future<List<TransactionHistoryDiposit>> getInfoAllDiposit() async {
    Response responce = await connect
        .get(APIUrlTransaction.getInfoAllTransactionHistoryDipositURL);
    print(responce.data['data']);
    List<dynamic> dataAll = responce.data['data'];
    print(responce.data['data']);
    _getInfoAllTransactionHistoryDiposit = dataAll
        .map((e) =>
            TransactionHistoryDiposit.fromJson(e as Map<String, dynamic>))
        .toList();
    print(_getInfoAllTransactionHistoryDiposit);
    return _getInfoAllTransactionHistoryDiposit;
  }

  Future updateDiposit(int id) async {
    Response response =
        await connect.get(APIUrlTransaction.updateDipositURL + id.toString());
    notifyListeners();
    final code = response.data['code'];
    return code;
  }
}
