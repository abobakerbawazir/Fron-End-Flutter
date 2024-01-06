import 'package:booking_car_project_flutter/features/ViewModels/BookingCoustomerByBranchVM.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class getByIDInformationBookingForAllCustomerPage extends StatefulWidget {
  getByIDInformationBookingForAllCustomerPage({super.key});

  @override
  State<getByIDInformationBookingForAllCustomerPage> createState() =>
      _getByIDInformationBookingForAllCustomerPageState();
}

class _getByIDInformationBookingForAllCustomerPageState
    extends State<getByIDInformationBookingForAllCustomerPage> {
  // List<BookingCoustomerByBranch> _allCArs = [];
  // List<BookingCoustomerByBranch> get allCArs => _allCArs;
  // Future<List<BookingCoustomerByBranch>> getBookingCoustomerByBranch() async {
  //   print('${APIurl.baseUrl}getBookingByBranchIdByCustomerIdForCoustomer/1/4');
  //   Dio dio = DioSingelton.getInstance();

  //   Response response = await dio
  //       .get('${APIurl.baseUrl}booking/getAllInformationBookingForAllCustomer');
  //   try {
  //     List<dynamic> dtatAllBooking = response.data;
  //     _allCArs = dtatAllBooking
  //         .map((e) => BookingCoustomerByBranch.fromJson(e))
  //         .toList();
  //     print(_allCArs);
  //     print(dtatAllBooking);
  //     return _allCArs;
  //   } catch (e) {
  //     return _allCArs;
  //   }
  // }
  // @override
  // void initState() {
  //   Future.delayed(
  //     Duration(
  //       seconds: 3,
  //     ),
  //     () {
  //       return CircularProgressIndicator();
  //     },
  //   );
  //   super.initState();
  // }

  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final bookingCoustomerByBranchProvider =
        Provider.of<BookingCoustomerByBranchVM>(context);
    final id = box.read('getByIDInformationBookingForAllCustomerPage') ?? 294;
    final xx = box.read('id_getByIDInformationBookingForAllCustomerPage') ?? 0;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("getByIDInformationBookingForAllCustomerPage"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: FutureBuilder(
              future: bookingCoustomerByBranchProvider
                  .getByIDInformationBookingForAllCustomer(id: id),
              builder: (context, snapshot) {
                

                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          //margin: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text(
                                "معلومات الحجز الاولية",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              Text(
                                  "رقم الحجز : ${snapshot.data!.id.toString()}"),
                              Text(
                                  "حالة الحجز : ${snapshot.data!.status.toString()}"),
                              Text(
                                  "تاريخ بداية الحجز : ${snapshot.data!.from.toString()}"),
                              Text(
                                  "تاريخ نهاية الحجز : ${snapshot.data!.to.toString()}"),
                              Text(
                                  "التكلفة الاجمالية للحجز : ${snapshot.data!.total.toString()}"),
                              Text("عدد ايام الحجز : ${xx.toString()} يوم"),
                              Text("معلومات  السيارة",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              Text(
                                  "اسم السيارة : ${snapshot.data!.cars!.name.toString()}"),
                              Text(
                                  "موديل السيارة : ${snapshot.data!.cars!.model.toString()}"),
                              Text(
                                  "سعر السيارة لليوم الواحد : ${snapshot.data!.cars!.price.toString()}"),
                              Text("معلومات صاحب الفرع",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              Text(
                                  "الايميل : ${snapshot.data!.cars!.users!.email.toString()}"),
                              Text(
                                  "الاسم : ${snapshot.data!.cars!.users!.fullName.toString()}"),
                              Text(
                                  "رقم الهاتف : ${snapshot.data!.cars!.users!.phone.toString()}"),
                              Text(
                                  "العنوان : ${snapshot.data!.cars!.users!.location.toString()}"),
                              Text("الصورة للسيارة",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              snapshot.data!.cars!.imageCarBrands!.length == 0
                                  ? Text("لاتوجد صورة")
                                  : snapshot.data!.cars!.imageCarBrands!
                                              .length >
                                          1
                                      ? Image.network(snapshot
                                          .data!.cars!.imageCarBrands![0].url
                                          .toString())
                                      : Image.network(snapshot
                                          .data!.cars!.imageCarBrands![0].url
                                          .toString()),
                              Text("معلومات العميل الذي قام بعملية الحجز",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              Text(
                                  "الايميل : ${snapshot.data!.user!.email.toString()}"),
                              Text(
                                  "الاسم : ${snapshot.data!.user!.fullName.toString()}"),
                              Text(
                                  "رقم الهاتف : ${snapshot.data!.user!.phone.toString()}"),
                              Text(
                                  "العنوان : ${snapshot.data!.user!.location.toString()}"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
