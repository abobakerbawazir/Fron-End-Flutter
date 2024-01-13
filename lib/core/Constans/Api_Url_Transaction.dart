import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';

class APIUrlTransaction {
  static const String baseTransactionUrl =
      APIurl.baseUrl + 'transaction_history/';
  static const String getInfoAllTransactionHistoryToTransferURl =
      baseTransactionUrl + 'getInfoAllTransactionHistoryToTransfer';
  static const String getInfoOneTransactionHistoryToTransferURL =
      baseTransactionUrl + 'getInfoOneTransactionHistoryToTransfer/';
  static const String getInfoAllTransactionHistoryURL =
      baseTransactionUrl + 'getInfoAllTransactionHistory';
  static const String transferURL = baseTransactionUrl + 'transfer';
  static const String dipositURL = baseTransactionUrl + 'diposit';
  static const String withdrawURL = baseTransactionUrl + 'withdraw';
  static const String updateDipositURL = baseTransactionUrl + 'updateDiposit/';
  static const String getInfoAllTransactionHistoryNotTransferURL =
      baseTransactionUrl + 'getInfoAllTransactionHistoryNotTransfer/';
  static const String getConutTransactionHistoryDipositStateFalse =
      baseTransactionUrl + 'getConutTransactionHistoryDipositStateFalse';
  static const String getConutTransactionHistory =
      baseTransactionUrl + 'getConutTransactionHistory/';
}
