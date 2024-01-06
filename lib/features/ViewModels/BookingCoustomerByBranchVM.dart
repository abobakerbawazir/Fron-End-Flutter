import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/Models/Booking/BookingCoustomerByBranch.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BookingCoustomerByBranchVM with ChangeNotifier {
  List<BookingCoustomerByBranch> _allBookings = [];
  List<BookingCoustomerByBranch> _allBookingByBranchs = [];
  List<BookingCoustomerByBranch>
      _allBookingByBranchIdByCustomerIdForCoustomers = [];

  BookingCoustomerByBranch _oneBookings = BookingCoustomerByBranch();
  BookingCoustomerByBranch get oneCars => _oneBookings;
  List<BookingCoustomerByBranch> get allBookings => _allBookings;
  List<BookingCoustomerByBranch> get allBookingByBranchs =>
      _allBookingByBranchs;
  List<BookingCoustomerByBranch>
      get allBookingByBranchIdByCustomerIdForCoustomers =>
          _allBookingByBranchIdByCustomerIdForCoustomers;

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
    print('${APIurl.getAllInformationBookingForAllCustomer}');
    Dio dio = DioSingelton.getInstance();

    Response response = await dio.get('${APIurl.getBookingByBranchId}/$id');
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
  Future<List<BookingCoustomerByBranch>> getBookingByBranchIdByCustomerIdForCoustomer() async {
    print('${APIurl.getBookingByBranchIdByCustomerIdForCoustomer}');
    Dio dio = DioSingelton.getInstance();

    Response response =
        await dio.get('${APIurl.getBookingByBranchIdByCustomerIdForCoustomer}');
    try {
      List<dynamic> allBookingByBranchIdByCustomerIdForCoustomersDtat = response.data;
      _allBookingByBranchIdByCustomerIdForCoustomers = allBookingByBranchIdByCustomerIdForCoustomersDtat
          .map((e) => BookingCoustomerByBranch.fromJson(e))
          .toList();
      print(_allBookingByBranchIdByCustomerIdForCoustomers);
      print(allBookingByBranchIdByCustomerIdForCoustomersDtat);
      return _allBookingByBranchIdByCustomerIdForCoustomers;
    } catch (e) {
      return _allBookingByBranchIdByCustomerIdForCoustomers;
    }
  }
}
