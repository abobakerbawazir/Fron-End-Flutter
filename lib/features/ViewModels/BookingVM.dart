import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/Models/Booking/Booking.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/awasome_dialog_page.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/DialogMessage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class BookingVM with ChangeNotifier {
  static BookingVM? _objectDio;
  static BookingVM getInstanceSinglton() {
    if (_objectDio == null) _objectDio = BookingVM();
    return _objectDio!;
  }

  final box = GetStorage();

  Dio connect = DioSingelton.getInstance();
  List<Booking> _allBookings = [];
  List<Booking> get allBookings => _allBookings;

  Future<int> addBookingwithObjectByUserIdAndCarId(
      {required Booking b,
      required int userId,
      required int carId,
      required BuildContext context}) async {
    print(APIurl
        .addBookingCarsWithId_user_And_Id_car_From_To_date_request_car_isNot_activeUrl);
    int? code = 0;
    try {
      final token = box.read('token_login');
      // if (token != "dd") {
      //   Navigator.push(context, MaterialPageRoute(
      //     builder: (context) {
      //       return HomePage();
      //     },
      //   ));
      // }

      Response response = await connect.post(
          APIurl.addBookingCarsWithId_user_And_Id_car_From_To_date_request_car_isNot_activeUrl +
              '$userId/$carId',
          data: b.toJsonOnlyfromAndto(),
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      print(response.data);
      code = response.statusCode;
      if (code == 209) {
        return warningDialog(
            context: context,
            data: response.data['data'],
            type: response.data['type']);
      } else if (code == 208) {
        return warningDialog(
            context: context,
            data: response.data['data'],
            type: response.data['type']);
      } else if (code == 207) {
        return warningDialog(
            context: context,
            data: response.data['data'],
            type: response.data['type']);
      } else if (code == 206) {
        return warningDialog(
            context: context,
            data: response.data['data'],
            type: response.data['type']);
      } else if (code == 205) {
        return warningDialog(
            context: context,
            data: response.data['data'],
            type: response.data['type']);
      } else if (code == 203) {
        return warningDialog(
            context: context,
            data: response.data['data'],
            type: "${response.data['type']}");
      } else if (code == 213) {
        return warningDialog(
            context: context,
            data: response.data['data'],
            type: "${response.data['type']}");
      } else if (code == 212) {
        return warningDialog(
            context: context,
            data: response.data['data'],
            type: "${response.data['type']}");
      } else if (code == 201) {
        box.write("new_booking_id", response.data['data']['id']);
        box.write("new_total", response.data['data']['total']);
        return successDialog(
            context: context,
            data: '''معلومات الحجز : 
            {رقم السيارة : ${response.data['data']['car_id']}
            \nتاريخ بداية الحجز : ${response.data['data']['from']}
            \nتاريخ نهاية الحجز : ${response.data['data']['to']}
            \nالتكلفة الاجمالية للحجز : ${response.data['data']['total']}
            \nعدد ايام الحجز : ${response.data['days']}
            \nأسم السيارة التي تم حجزها : ${response.data['active']['target']['name']}
            \nموديل السيارة : ${response.data['active']['target']['model']}
            \n حالة الحجز : ${response.data['data']['status']}}
''',
            type: response.data['type']);
      }
      notifyListeners();
      return code!;
    } catch (e) {
      print(e);
      return code!;
    }
  }

  Future<List<Booking>> getAllBookingsFromAPiwithObject() async {
    print("sdfghsdfghjhgfdsa");
    print(APIurl.getAllBookingUrl);
    Response responce = await connect.get(APIurl.getAllBookingUrl);
    //print(responce.data['data']);
    List<dynamic> databooking = responce.data['data'];
    //print("@@@@@@@@@@@@@ $databooking @@@@@@@@@@@");
    try {
      _allBookings =
          databooking.map<Booking>((e) => Booking.fromJson(e)).toList();
      print(_allBookings);
    } catch (e) {
      print(e);
    }
    return _allBookings;
  }

  Future updateBookingStateByBranch(int id, Booking booking) async {
    print("${APIurl.updateBookingStateByBranch}$id");
    Response result = await connect.put(
        "${APIurl.updateBookingStateByBranch}$id",
        data: booking.toJsonOnlyStatus());
    final code = result.data;
    print("%%  code = $code %%");
    notifyListeners();
    return code;
  }
}
