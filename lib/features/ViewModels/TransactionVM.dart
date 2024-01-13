import 'package:booking_car_project_flutter/core/Constans/Api_Url_Transaction.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/Models/Transaction/TransactionHistoreyDiposit.dart';
import 'package:booking_car_project_flutter/features/Models/Transaction/TransactionHistory.dart';
import 'package:booking_car_project_flutter/features/Models/Transaction/getInfoAllTransactionHistoryToTransfer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TransactionVM with ChangeNotifier {
  final box = GetStorage();
  int _countDiposit = 0;
  int get countDiposit => _countDiposit;
  TransactionHistoryToTransferOne _oneTransactionHistoryToTransferOne =
      TransactionHistoryToTransferOne();
  TransactionHistoryToTransferOne get oneTransactionHistoryToTransferOne =>
      _oneTransactionHistoryToTransferOne;
  List<TransactionHistoryToAllTransfer>
      _getInfoAllTransactionHistoryToTransferLists = [];
  List<TransactionHistoryToAllTransfer>
      get getInfoAllTransactionHistoryToTransferLists =>
          _getInfoAllTransactionHistoryToTransferLists;

  List<TransactionHistoryNotTransfer> _getInfoAllTransactionHistoryNotTransfer =
      [];
  List<TransactionHistoryNotTransfer>
      get getInfoAllTransactionHistoryNotTransfer =>
          _getInfoAllTransactionHistoryNotTransfer;

  Dio connect = DioSingelton.getInstance();
  Future<TransactionHistoryToTransferOne> getTransactionHistoryToTransferOne(
      {required int id}) async {
    print(
        '${APIUrlTransaction.getInfoOneTransactionHistoryToTransferURL}${id.toString()}');
    Dio dio = DioSingelton.getInstance();

    Response response = await dio.get(
        '${APIUrlTransaction.getInfoOneTransactionHistoryToTransferURL}$id');
    try {
      Map<String, dynamic> dtatoneBooking = response.data['data'];
      _oneTransactionHistoryToTransferOne =
          TransactionHistoryToTransferOne.fromJson(dtatoneBooking);
      print(_oneTransactionHistoryToTransferOne);
      print(dtatoneBooking);
      return _oneTransactionHistoryToTransferOne;
    } catch (e) {
      return _oneTransactionHistoryToTransferOne;
    }
  }

  Future<int> getConutTransactionHistoryDipositStatusFalse() async {
    Response response = await connect
        .get(APIUrlTransaction.getConutTransactionHistoryDipositStateFalse);
    _countDiposit = response.data['data'];
    return _countDiposit;
  }Future<int> getConutTransactionHistory({required String id}) async {
    Response response = await connect
        .get(APIUrlTransaction.getConutTransactionHistory+id);
    _countDiposit = response.data['data'];
    return _countDiposit;
  }

  Future<List<TransactionHistoryToAllTransfer>>
      getInfoAllTransactionHistoryToTransfer() async {
    Response responce = await connect
        .get(APIUrlTransaction.getInfoAllTransactionHistoryToTransferURl);
    print(responce.data['data']);
    List<dynamic> dataAll = responce.data['data'];
    print(responce.data['data']);
    _getInfoAllTransactionHistoryToTransferLists = dataAll
        .map((e) =>
            TransactionHistoryToAllTransfer.fromJson(e as Map<String, dynamic>))
        .toList();
    print(_getInfoAllTransactionHistoryToTransferLists);
    return _getInfoAllTransactionHistoryToTransferLists;
  }

  Future<List<TransactionHistoryNotTransfer>> transactionHistoryNotTransfer(
      {required String id}) async {
    if (id != "2") {
      Response responce = await connect.get(
          "${APIUrlTransaction.getInfoAllTransactionHistoryNotTransferURL}$id");
      print(responce.data['data']);
      List<dynamic> dataAll = responce.data['data'];
      print(responce.data['data']);
      _getInfoAllTransactionHistoryNotTransfer = dataAll
          .map((e) =>
              TransactionHistoryNotTransfer.fromJson(e as Map<String, dynamic>))
          .toList();
      print(_getInfoAllTransactionHistoryNotTransfer);
      return _getInfoAllTransactionHistoryNotTransfer;
    }
    return [];
  }

  Future updateDiposit(int id) async {
    Response response =
        await connect.get(APIUrlTransaction.updateDipositURL + id.toString());
    notifyListeners();
    final code = response.data['code'];
    return code;
  }
}
