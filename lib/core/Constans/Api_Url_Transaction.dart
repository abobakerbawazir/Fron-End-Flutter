import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';

class APIUrlTransaction {
  static const String baseTransactionUrl =
      APIurl.baseUrl + 'transaction_history/';
  static const String getInfoAllTransactionHistoryToTransfer =
      baseTransactionUrl + 'getInfoAllTransactionHistoryToTransfer';
      static const String getInfoOneTransactionHistoryToTransfer =
      baseTransactionUrl + 'getInfoOneTransactionHistoryToTransfer/';
      static const String getInfoAllTransactionHistory =
      baseTransactionUrl + 'getInfoAllTransactionHistory';
      static const String transferURL =
      baseTransactionUrl + 'transfer';
      static const String dipositURL =
      baseTransactionUrl + 'diposit';
      static const String withdrawURL =
      baseTransactionUrl + 'withdraw';
      static const String updateDipositURL =
      baseTransactionUrl + 'updateDiposit/';
      static const String getInfoAllTransactionHistoryDipositURL =
      baseTransactionUrl + 'getInfoAllTransactionHistoryDiposit';
}
