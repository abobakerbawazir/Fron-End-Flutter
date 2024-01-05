import 'package:booking_car_project_flutter/features/Models/Booking/Booking.dart';
import 'package:booking_car_project_flutter/features/ViewModels/BookingVM.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class AddAddBookingHomePage extends StatefulWidget {
  const AddAddBookingHomePage({super.key});

  @override
  State<AddAddBookingHomePage> createState() => _AddAddBookingHomePageState();
}

class _AddAddBookingHomePageState extends State<AddAddBookingHomePage> {
  TextEditingController fromTxt = TextEditingController();
  TextEditingController toTxt = TextEditingController();
  DateTime? startDate;
  DateTime? lastDate;
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int userId=box.read('user_id');
    int carId=box.read('car_id');
    final bookingProvider = Provider.of<BookingVM>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(8),
            width: 180,
            decoration: BoxDecoration(
                color: colorprimarygreen,
                borderRadius: BorderRadius.circular(20)),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Center(child: Text("اضف التاريخ")),
                      actions: [
                        MyTextFormField(
                          hintText: 'تاريخ بداية الحجز',
                          controller: fromTxt,
                          readOnly: true,
                          suffixIcon: IconButton(
                              onPressed: () async {
                                DateTime? startDate = await showDatePicker(
                                    builder: (context, child) {
                                      return Theme(
                                          data: ThemeData.dark(),
                                          child: child!);
                                    },
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2023),
                                    lastDate: DateTime(2100));
                                this.startDate = startDate;
                                fromTxt.text = this.startDate.toString();
                                setState(() {});
                              },
                              icon: Icon(Icons.calendar_month)),
                        ),
                        MyTextFormField(
                          hintText: 'تاريخ نهاية الحجز',
                          controller: toTxt,
                          readOnly: true,
                          suffixIcon: IconButton(
                              onPressed: () async {
                                DateTime? startDate = await showDatePicker(
                                    builder: (context, child) {
                                      return Theme(
                                          data: ThemeData.dark(),
                                          child: child!);
                                    },
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2023),
                                    lastDate: DateTime(2100));
                                this.lastDate = startDate;
                                toTxt.text = this.lastDate.toString();
                                setState(() {});
                              },
                              icon: Icon(Icons.calendar_month)),
                        ),
                        InkWell(
                          onTap: () async {
                            print("545");
                            await bookingProvider
                                .addBookingwithObjectByUserIdAndCarId(context: context,b: Booking(
                                    from: fromTxt.text, to: toTxt.text),carId: carId,userId: userId);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: colorprimarygreen,
                              ),
                              width: 280,
                              height: 60,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("حفظ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: colorprimarywhite)),
                                  Padding(padding: EdgeInsets.all(8)),
                                  Icon(
                                    size: 25,
                                    Icons.add,
                                    color: colorprimarywhite,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 159,
                  height: 35,
                  child: Row(
                    children: [
                      Text("اضف حجز جديد",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorprimarywhite)),
                      Padding(padding: EdgeInsets.all(6)),
                      Icon(
                        Icons.add,
                        color: colorprimarywhite,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
            backgroundColor: colorprimarygreen,
            title: Center(child: Text(' صفحة عرض جميع الحجوزات '))),
        body: SizedBox(
          height: height - 200,
          width: width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: height - 100,
                      width: width,
                      child: FutureBuilder(
                        future:
                            bookingProvider.getAllBookingsFromAPiwithObject(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.isEmpty) {
                              return Center(child: Text("لا توجد اي بيانات"));
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 190, 186, 186),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        children: [
                                          Text(
                                              " تاريخ بداية الحجز : ${snapshot.data![index].from.toString()}"),
                                          Text(
                                              "تاريخ نهاية الحجز : ${snapshot.data![index].to.toString()}"),
                                          Text(
                                              "التكلفة الاجمالية للحجز : ${snapshot.data![index].total.toString()}"),
                                          Text(
                                              "العميل صاحب الحجز : ${snapshot.data![index].carId.toString()}"),
                                          Text(
                                              "السيارة التي تم حجزها : ${snapshot.data![index].userId.toString()}"),
                                          Text(
                                              "عدد ايام الحجز : ${snapshot.data![index].days.toString()}")
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
