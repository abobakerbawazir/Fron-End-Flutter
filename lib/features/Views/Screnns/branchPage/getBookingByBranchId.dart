import 'package:booking_car_project_flutter/features/Models/Booking/Booking.dart';
import 'package:booking_car_project_flutter/features/Models/Booking/enumStatus.dart';
import 'package:booking_car_project_flutter/features/ViewModels/BookingCoustomerByBranchVM.dart';
import 'package:booking_car_project_flutter/features/ViewModels/BookingVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/BookingPage/getByIDInformationBookingForAllCustomerPage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class getBookingByBranchIdPage extends StatefulWidget {
  getBookingByBranchIdPage({super.key});

  @override
  State<getBookingByBranchIdPage> createState() =>
      _getBookingByBranchIdPageState();
}

class _getBookingByBranchIdPageState extends State<getBookingByBranchIdPage> {
  BookingStatus? type;
  TextEditingController statusTxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final BookingByBranchIdProvider =
        Provider.of<BookingCoustomerByBranchVM>(context);
    final bookingProvider = Provider.of<BookingVM>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("getBookingByBranchIdPage")),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: FutureBuilder(
            future: BookingByBranchIdProvider.getBookingByBranchId(id: 5),
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
                                  DropdownButton<BookingStatus>(
                                    value: type,
                                    onChanged: (value) {
                                      type = value;
                                      statusTxt.text = type!.value;
                                      //type = null;
                                      setState(() {});

                                      // setState(() {
                                      //   type = null;
                                      // });
                                    },
                                    items: BookingStatus.values
                                        .map<DropdownMenuItem<BookingStatus>>(
                                      (BookingStatus e) {
                                        return DropdownMenuItem<BookingStatus>(
                                          child: Text("${e.value}"),
                                          value: e,
                                        );
                                      },
                                    ).toList(),
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        final x = await bookingProvider
                                            .updateBookingStateByBranch(
                                                snapshot.data![index].id!,
                                                Booking(status: type!.value));
                                        print(
                                            "updateBookingStateByBranch = $x");
                                      },
                                      child: Text("تعديل حالة الحجز")),
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
                                  Text("عدد ايام الحجز : ${x.toString()} يوم"),
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
                                  // Text("معلومات صاحب الفرع",
                                  //     style: TextStyle(
                                  //         fontWeight: FontWeight.bold,
                                  //         fontSize: 17)),
                                  // Text(
                                  //     "الايميل : ${snapshot.data![index].cars!.users!.email.toString()}"),
                                  // Text(
                                  //     "الاسم : ${snapshot.data![index].cars!.users!.fullName.toString()}"),
                                  // Text(
                                  //     "رقم الهاتف : ${snapshot.data![index].cars!.users!.phone.toString()}"),
                                  // Text(
                                  //     "العنوان : ${snapshot.data![index].cars!.users!.location.toString()}"),
                                  Text("الصورة للسيارة",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  snapshot.data![index].cars!.imageCarBrands!
                                              .length ==
                                          0
                                      ? Text("لاتوجد صورة")
                                      : snapshot.data![index].cars!
                                                  .imageCarBrands!.length >
                                              1
                                          ? SizedBox(
                                              height: 200,
                                              width: 200,
                                              child: Image.network(
                                                snapshot.data![index].cars!
                                                    .imageCarBrands![0].url
                                                    .toString(),
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : SizedBox(
                                              height: 200,
                                              width: 200,
                                              child: Image.network(
                                                snapshot.data![index].cars!
                                                    .imageCarBrands![0].url
                                                    .toString(),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                  Text("معلومات العميل الذي قام بعملية الحجز",
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
      ),
    );
  }
}