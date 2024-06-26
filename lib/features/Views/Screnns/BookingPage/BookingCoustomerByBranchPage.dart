import 'package:booking_car_project_flutter/features/ViewModels/BookingCoustomerByBranchVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/BookingPage/getByIDInformationBookingForAllCustomerPage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class BookingCoustomerByBranchPage extends StatefulWidget {
  BookingCoustomerByBranchPage({super.key});

  @override
  State<BookingCoustomerByBranchPage> createState() =>
      _BookingCoustomerByBranchPageState();
}

class _BookingCoustomerByBranchPageState
    extends State<BookingCoustomerByBranchPage> {
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

  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w=MediaQuery.of(context).size.width;
    final bookingCoustomerByBranchProvider =
        Provider.of<BookingCoustomerByBranchVM>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("BookingCoustomerByBranchPage"),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              // SizedBox(
              //   height: 200,
              // ),
              SizedBox(
                child: FutureBuilder(
                  future: bookingCoustomerByBranchProvider
                      .getBookingCoustomerByBranch(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return Center(child: Text("Empty"));
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          int x = (snapshot.data![index].total! /
                                      snapshot.data![index].cars!.price!)
                                  .toInt() ??
                              0;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    final box = GetStorage();
                                    box.write(
                                        'getByIDInformationBookingForAllCustomerPage',
                                        snapshot.data![index].id);
                                    box.write(
                                        'id_getByIDInformationBookingForAllCustomerPage',
                                        x);
                                    return getByIDInformationBookingForAllCustomerPage();
                                  },
                                ));
                              },
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
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        Text(
                                            "رقم الحجز : ${snapshot.data![index].id.toString()}"),
                                        Text(
                                            "حالة الحجز : ${snapshot.data![index].status.toString()}"),
                                        Text(
                                            "تاريخ بداية الحجز : ${snapshot.data![index].from.toString()}"),
                                        Text(
                                            "تاريخ نهاية الحجز : ${snapshot.data![index].to.toString()}"),
                                        Text(
                                            "التكلفة الاجمالية للحجز : ${snapshot.data![index].total.toString()}"),
                                        Text(
                                            "عدد ايام الحجز : ${x.toString()} يوم"),
                                        Text("معلومات  السيارة",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                        Text(
                                            "اسم السيارة : ${snapshot.data![index].cars!.name.toString()}"),
                                        Text(
                                            "موديل السيارة : ${snapshot.data![index].cars!.model.toString()}"),
                                        Text(
                                            "سعر السيارة لليوم الواحد : ${snapshot.data![index].cars!.price.toString()}"),
                                        Text("معلومات صاحب الفرع",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                        Text(
                                            "الايميل : ${snapshot.data![index].cars!.users!.email.toString()}"),
                                        Text(
                                            "الاسم : ${snapshot.data![index].cars!.users!.fullName.toString()}"),
                                        Text(
                                            "رقم الهاتف : ${snapshot.data![index].cars!.users!.phone.toString()}"),
                                        Text(
                                            "العنوان : ${snapshot.data![index].cars!.users!.location.toString()}"),
                                        Text("الصورة للسيارة",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                        snapshot.data![index].cars!
                                                    .imageCarBrands!.length ==
                                                0
                                            ? Text("لاتوجد صورة")
                                            : snapshot.data![index].cars!
                                                        .imageCarBrands!.length >
                                                    1
                                                ? Image.network(snapshot
                                                    .data![index]
                                                    .cars!
                                                    .imageCarBrands![0]
                                                    .url
                                                    .toString())
                                                : Image.network(snapshot
                                                    .data![index]
                                                    .cars!
                                                    .imageCarBrands![0]
                                                    .url
                                                    .toString()),
                                        Text(
                                            "معلومات العميل الذي قام بعملية الحجز",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                        Text(
                                            "الايميل : ${snapshot.data![index].user!.email.toString()}"),
                                        Text(
                                            "الاسم : ${snapshot.data![index].user!.fullName.toString()}"),
                                        Text(
                                            "رقم الهاتف : ${snapshot.data![index].user!.phone.toString()}"),
                                        Text(
                                            "العنوان : ${snapshot.data![index].user!.location.toString()}"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
