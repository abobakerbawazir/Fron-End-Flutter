import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/Models/Booking/BookingCoustomerByBranch.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BookingCoustomerByBranchVM with ChangeNotifier {
  List<BookingCoustomerByBranch> _allgetAllInformationBookingForAllCustomers =
      [];
  List<BookingCoustomerByBranch> _allBookings = [];
  List<BookingCoustomerByBranch> _allBookingByBranchs = [];
  List<BookingCoustomerByBranch>
      _allBookingByBranchIdByCustomerIdForCoustomers = [];
  List<BookingCoustomerByBranch> _allgetAllInformationBookingForOnlyCustomers =
      [];

  BookingCoustomerByBranch _oneBookings = BookingCoustomerByBranch();
  BookingCoustomerByBranch get oneCars => _oneBookings;
  List<BookingCoustomerByBranch> get allBookings => _allBookings;
  List<BookingCoustomerByBranch> get allBookingByBranchs =>
      _allBookingByBranchs;
  List<BookingCoustomerByBranch>
      get allBookingByBranchIdByCustomerIdForCoustomers =>
          _allBookingByBranchIdByCustomerIdForCoustomers;
  List<BookingCoustomerByBranch>
      get allgetAllInformationBookingForOnlyCustomers =>
          _allgetAllInformationBookingForOnlyCustomers;
  List<BookingCoustomerByBranch>
      get allgetAllInformationBookingForAllCustomers =>
          _allgetAllInformationBookingForAllCustomers;

  Future<List<BookingCoustomerByBranch>> getBookingCoustomerByBranch() async {
    print('${APIurl.getBookingByBranchIdByCustomerIdForCoustomer}');
    Dio dio = DioSingelton.getInstance();

    Response response =
        await dio.get('${APIurl.getBookingByBranchIdByCustomerIdForCoustomer}');
    try {
      List<dynamic> dtatAllBooking = response.data;
      _allBookings = dtatAllBooking
          .map((e) => BookingCoustomerByBranch.fromJson(e))
          .toList();
      print(_allBookings);
      print(dtatAllBooking);
      return _allBookings;
    } catch (e) {
      return _allBookings;
    }
  }

  Future<BookingCoustomerByBranch> getByIDInformationBookingForAllCustomer(
      {required int id}) async {
    print('${APIurl.getByIDInformationBookingForAllCustomer}');
    Dio dio = DioSingelton.getInstance();

    Response response =
        await dio.get('${APIurl.getByIDInformationBookingForAllCustomer}/$id');
    try {
      Map<String, dynamic> dtatoneBooking = response.data;
      _oneBookings = BookingCoustomerByBranch.fromJson(dtatoneBooking);
      print(_oneBookings);
      print(dtatoneBooking);
      return _oneBookings;
    } catch (e) {
      return _oneBookings;
    }
  }

  Future<List<BookingCoustomerByBranch>> getBookingByBranchId(
      {required int id}) async {
    Dio dio = DioSingelton.getInstance();

    Response response = await dio.get('${APIurl.getBookingByBranchId}$id');
    try {
      List<dynamic> allBookingByBranchsData = response.data;
      _allBookingByBranchs = allBookingByBranchsData
          .map((e) => BookingCoustomerByBranch.fromJson(e))
          .toList();
      print(_allBookingByBranchs);
      print(allBookingByBranchsData);
      return _allBookingByBranchs;
    } catch (e) {
      return _allBookingByBranchs;
    }
  }

  Future<List<BookingCoustomerByBranch>>
      getBookingByBranchIdByCustomerIdForCoustomer(
          {required int branch_id, required int user_id}) async {
    print('${APIurl.getBookingByBranchIdByCustomerIdForCoustomer}');
    Dio dio = DioSingelton.getInstance();

    Response response = await dio.get(
        '${APIurl.getBookingByBranchIdByCustomerIdForCoustomer}$branch_id/$user_id');
    try {
      List<dynamic> allBookingByBranchIdByCustomerIdForCoustomersDtat =
          response.data;
      _allBookingByBranchIdByCustomerIdForCoustomers =
          allBookingByBranchIdByCustomerIdForCoustomersDtat
              .map((e) => BookingCoustomerByBranch.fromJson(e))
              .toList();
      print(_allBookingByBranchIdByCustomerIdForCoustomers);
      print(allBookingByBranchIdByCustomerIdForCoustomersDtat);
      return _allBookingByBranchIdByCustomerIdForCoustomers;
    } catch (e) {
      return _allBookingByBranchIdByCustomerIdForCoustomers;
    }
  }

  Future<List<BookingCoustomerByBranch>>
      getAllInformationBookingForOnlyCustomer({required int user_id}) async {
    print('${APIurl.getAllInformationBookingForOnlyCustomer}${user_id}');
    Dio dio = DioSingelton.getInstance();

    Response response = await dio
        .get('${APIurl.getAllInformationBookingForOnlyCustomer}$user_id');
    try {
      List<dynamic> allgetAllInformationBookingForOnlyCustomersDtat =
          response.data;
      _allgetAllInformationBookingForOnlyCustomers =
          allgetAllInformationBookingForOnlyCustomersDtat
              .map((e) => BookingCoustomerByBranch.fromJson(e))
              .toList();
      print(_allBookingByBranchIdByCustomerIdForCoustomers);
      print(allgetAllInformationBookingForOnlyCustomersDtat);
      return _allgetAllInformationBookingForOnlyCustomers;
    } catch (e) {
      return _allgetAllInformationBookingForOnlyCustomers;
    }
  }

  Future<List<BookingCoustomerByBranch>>
      getAllInformationBookingForAllCustomer() async {
    print('${APIurl.getAllInformationBookingForAllCustomer}');
    Dio dio = DioSingelton.getInstance();

    Response response =
        await dio.get('${APIurl.getAllInformationBookingForAllCustomer}');
    try {
      List<dynamic> allgetAllInformationBookingForAllCustomerDtat =
          response.data;
      _allgetAllInformationBookingForAllCustomers =
          allgetAllInformationBookingForAllCustomerDtat
              .map((e) => BookingCoustomerByBranch.fromJson(e))
              .toList();
      print(_allgetAllInformationBookingForAllCustomers);
      print(allgetAllInformationBookingForAllCustomerDtat);
      return _allgetAllInformationBookingForAllCustomers;
    } catch (e) {
      return _allgetAllInformationBookingForAllCustomers;
    }
  }
}
