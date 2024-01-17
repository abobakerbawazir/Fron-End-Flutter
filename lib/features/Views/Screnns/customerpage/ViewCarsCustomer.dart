import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/Models/Booking/Booking.dart';
import 'package:booking_car_project_flutter/features/Enum/enumStatus.dart';
import 'package:booking_car_project_flutter/features/Models/Transaction/TransactionBooking.dart';
import 'package:booking_car_project_flutter/features/ViewModels/BookingVM.dart';
import 'package:booking_car_project_flutter/features/ViewModels/CarVM.dart';
import 'package:booking_car_project_flutter/features/ViewModels/PrandVM.dart';
import 'package:booking_car_project_flutter/features/ViewModels/TransactionVM.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/BookingPage/BookingHomePage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/awasome_dialog_page.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/DialogMessage.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyTextFormField.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewCarsCustomer extends StatefulWidget {
  const ViewCarsCustomer({super.key});

  @override
  State<ViewCarsCustomer> createState() => _ViewCarsCustomerState();
}

class _ViewCarsCustomerState extends State<ViewCarsCustomer> {
  final box = GetStorage();
  List<dynamic> xxxx = [];
  TextEditingController fromTxt = TextEditingController();
  TextEditingController toTxt = TextEditingController();
  TextEditingController emailTxt = TextEditingController();
  TextEditingController passwordTxt = TextEditingController();

  DateTime? startDate;
  DateTime? lastDate;
  Future<List<dynamic>> getCarsWithIdUserAndIdPrandWithApi(
      {required int user_id, prand_id}) async {
    print(
        '${APIurl.getCarWithUserAndPrand}?user_id=$user_id&prand_id=$prand_id');
    Dio dio = DioSingelton.getInstance();

    Response response = await dio.get(
        '${APIurl.getCarWithUserAndPrand}?user_id=$user_id&prand_id=$prand_id');
    try {
      xxxx = response.data['data'];
      print(xxxx);
      print(user_id);
      print(prand_id);
      return xxxx;
    } catch (e) {
      return xxxx;
    }
  }

  TextEditingController amountTxt = TextEditingController();
  TextEditingController descriptionTxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarVM>(context);

    final userProvider = Provider.of<UserVM>(context);

    final prandProvider = Provider.of<PrandVM>(context);
    final bookingProvider = Provider.of<BookingVM>(context);
    final transactionProvider = Provider.of<TransactionVM>(context);

    int prand_id_branch = box.read('prand_id_branch');
    int id_user_branch = box.read('id_user_branch');
    int userId = box.read('user_id');
    int carId = box.read('car_id') ?? 0;
    final new_booking_id = box.read('new_booking_id') ?? 0;
    final new_total = box.read('new_total') ?? 0;
    final walletId = box.read("walletId") ?? 0;

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                await carProvider.getCarsWithIdUserAndIdPrandWithApi(
                    user_id: id_user_branch, prand_id: prand_id_branch);
                setState(() {});
              },
              child: Text(
                "تحديث",
                style: TextStyle(color: colorprimarywhite),
              )),
        ],
        backgroundColor: colorprimarygreen,
        title: Center(child: Text(' صفحة أضافة السيارات ')),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Form(
            child: Column(
              children: [
                Image.asset('assets/images/home.png'),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.7,
                    width: MediaQuery.of(context).size.width,
                    child: FutureBuilder(
                      future: carProvider.getCarsWithIdUserAndIdPrandWithApi(
                          user_id: id_user_branch, prand_id: prand_id_branch),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isEmpty) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  "لم يتم اضافة اي سيارة",
                                  style: TextStyle(fontSize: 30),
                                ),
                              ],
                            );
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2.3,
                                  width: MediaQuery.of(context).size.width,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 213, 210, 200),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    margin: EdgeInsets.all(10),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Positioned(
                                          left: 20,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              colorprimarygrey),
                                                  onPressed: () {
                                                    final box = GetStorage();
                                                    box.write(
                                                        'car_id',
                                                        snapshot
                                                            .data![index].id);
                                                    print(
                                                        "car_id = ${box.read('car_id')}");
                                                    final token =
                                                        box.read('token_login');
                                                    print(box
                                                        .read('token_login'));
                                                    if (token == null) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Center(
                                                                child: Text(
                                                                    "يرجى تسجيل الدخول")),
                                                            actions: [
                                                              MyTextFormField(
                                                                  hintText:
                                                                      'الايميل',
                                                                  controller:
                                                                      emailTxt,
                                                                  readOnly:
                                                                      false,
                                                                  suffixIcon:
                                                                      Icon(Icons
                                                                          .email)),
                                                              MyTextFormField(
                                                                hintText:
                                                                    'كلمة المرور',
                                                                controller:
                                                                    passwordTxt,
                                                                readOnly: false,
                                                                suffixIcon:
                                                                    Icon(Icons
                                                                        .visibility),
                                                              ),
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  final code =
                                                                      await userProvider
                                                                          .login(
                                                                    context:
                                                                        context,
                                                                    email:
                                                                        emailTxt
                                                                            .text,
                                                                    password:
                                                                        passwordTxt
                                                                            .text,
                                                                  );
                                                                  print(code);
                                                                  if (code ==
                                                                      200) {
                                                                    final prefs =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    prefs.setBool(
                                                                        'token',
                                                                        true);
                                                                    Navigator.pop(
                                                                        context);

                                                                    // showDialogBooking(
                                                                    //     context:
                                                                    //         context,
                                                                    //     carId:
                                                                    //         carId,
                                                                    //     fromTxt:
                                                                    //         fromTxt,
                                                                    //     toTxt:
                                                                    //         toTxt,
                                                                    //     userId:
                                                                    //         userId);

                                                                    return showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              Center(child: Text("اضف التاريخ")),
                                                                          actions: [
                                                                            MyTextFormField(
                                                                              hintText: 'تاريخ بداية الحجز',
                                                                              controller: fromTxt,
                                                                              readOnly: true,
                                                                              suffixIcon: IconButton(
                                                                                  onPressed: () async {
                                                                                    DateTime? startDate = await showDatePicker(
                                                                                        builder: (context, child) {
                                                                                          return Theme(data: ThemeData.dark(), child: child!);
                                                                                        },
                                                                                        context: context,
                                                                                        initialDate: DateTime.now(),
                                                                                        firstDate: DateTime(2023),
                                                                                        lastDate: DateTime(2100));
                                                                                    this.startDate = startDate;
                                                                                    fromTxt.text = this.startDate.toString().split(' 00:00:00.000').join();
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
                                                                                          return Theme(data: ThemeData.dark(), child: child!);
                                                                                        },
                                                                                        context: context,
                                                                                        initialDate: DateTime.now(),
                                                                                        firstDate: DateTime(2023),
                                                                                        lastDate: DateTime(2100));
                                                                                    this.lastDate = startDate;
                                                                                    toTxt.text = this.lastDate.toString().split(' 00:00:00.000').join();
                                                                                    setState(() {});
                                                                                  },
                                                                                  icon: Icon(Icons.calendar_month)),
                                                                            ),
                                                                            InkWell(
                                                                              onTap: () async {
                                                                                print("555");
                                                                                final x = await bookingProvider.addBookingwithObjectByUserIdAndCarId(context: context, b: Booking(from: fromTxt.text, to: toTxt.text), carId: snapshot.data![index].id!, userId: userId);
                                                                                print(x);
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
                                                                                      Text("حفظ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorprimarywhite)),
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
                                                                  }
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color:
                                                                          colorprimarygreen,
                                                                    ),
                                                                    width: 280,
                                                                    height: 60,
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                            "تسجيل الدخول",
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 18,
                                                                                color: colorprimarywhite)),
                                                                        Padding(
                                                                            padding:
                                                                                EdgeInsets.all(8)),
                                                                        Icon(
                                                                          size:
                                                                              25,
                                                                          Icons
                                                                              .login,
                                                                          color:
                                                                              colorprimarywhite,
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
                                                    } else {
                                                      // showDialog(
                                                      //   context: context,
                                                      //   builder: (context) {
                                                      //     return showDialogBooking(
                                                      //         context: context,
                                                      //         carId: carId,
                                                      //         fromTxt: fromTxt,
                                                      //         toTxt: toTxt,
                                                      //         userId: userId);
                                                      //   },
                                                      // );

                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Center(
                                                                child: Text(
                                                                    "اضف التاريخ")),
                                                            actions: [
                                                              MyTextFormField(
                                                                hintText:
                                                                    'تاريخ بداية الحجز',
                                                                controller:
                                                                    fromTxt,
                                                                readOnly: true,
                                                                suffixIcon:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          DateTime? startDate = await showDatePicker(
                                                                              builder: (context, child) {
                                                                                return Theme(data: ThemeData.dark(), child: child!);
                                                                              },
                                                                              context: context,
                                                                              initialDate: DateTime.now(),
                                                                              firstDate: DateTime(2023),
                                                                              lastDate: DateTime(2100));
                                                                          this.startDate =
                                                                              startDate;
                                                                          fromTxt.text = this
                                                                              .startDate
                                                                              .toString()
                                                                              .split(' 00:00:00.000')
                                                                              .join();
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        icon: Icon(
                                                                            Icons.calendar_month)),
                                                              ),
                                                              MyTextFormField(
                                                                hintText:
                                                                    'تاريخ نهاية الحجز',
                                                                controller:
                                                                    toTxt,
                                                                readOnly: true,
                                                                suffixIcon:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          DateTime? startDate = await showDatePicker(
                                                                              builder: (context, child) {
                                                                                return Theme(data: ThemeData.dark(), child: child!);
                                                                              },
                                                                              context: context,
                                                                              initialDate: DateTime.now(),
                                                                              firstDate: DateTime(2023),
                                                                              lastDate: DateTime(2100));
                                                                          this.lastDate =
                                                                              startDate;
                                                                          toTxt.text = this
                                                                              .lastDate
                                                                              .toString()
                                                                              .split(' 00:00:00.000')
                                                                              .join();
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        icon: Icon(
                                                                            Icons.calendar_month)),
                                                              ),
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  print("555");
                                                                  final x = await bookingProvider.addBookingwithObjectByUserIdAndCarId(
                                                                      context:
                                                                          context,
                                                                      b: Booking(
                                                                          from: fromTxt
                                                                              .text,
                                                                          to: toTxt
                                                                              .text,
                                                                          status: BookingStatus
                                                                              .Pending
                                                                              .value),
                                                                      carId: snapshot
                                                                          .data![
                                                                              index]
                                                                          .id!,
                                                                      userId:
                                                                          userId);
                                                                  print(x);
                                                                  if (x ==
                                                                      201) {
                                                                    print(201);
                                                                    // AwesomeDialog(
                                                                    //   context:
                                                                    //       context,
                                                                    //   animType:
                                                                    //       AnimType
                                                                    //           .leftSlide,
                                                                    //   headerAnimationLoop:
                                                                    //       false,
                                                                    //   dialogType:
                                                                    //       DialogType
                                                                    //           .success,
                                                                    //   showCloseIcon:
                                                                    //       true,
                                                                    //   title:
                                                                    //       'هل تريد ان تدفع من المحفظة',
                                                                    //   desc:
                                                                    //       'ماذا تنتظر',
                                                                    //   btnOkOnPress:
                                                                    //       () async {
                                                                    //     amountTxt.text =
                                                                    //         new_total.toString();
                                                                    //     showDialog(
                                                                    //       context:
                                                                    //           context,
                                                                    //       builder:
                                                                    //           (context) {
                                                                    //         return AlertDialog(
                                                                    //           title: Center(child: Text("يرجى اضافة المبلغ المطلوب")),
                                                                    //           actions: [
                                                                    //             MyTextFormField(inputFormatters: [
                                                                    //               FilteringTextInputFormatter.digitsOnly
                                                                    //             ], keyboardType: TextInputType.number, hintText: 'المبلغ', controller: amountTxt, readOnly: false, suffixIcon: Icon(Icons.attach_money)),
                                                                    //             MyTextFormField(
                                                                    //               maxLines: null,
                                                                    //               keyboardType: TextInputType.multiline,
                                                                    //               hintText: 'الوصف ان امكن',
                                                                    //               controller: descriptionTxt,
                                                                    //               readOnly: false,
                                                                    //               suffixIcon: Icon(Icons.description),
                                                                    //             ),
                                                                    //             InkWell(
                                                                    //               onTap: () async {
                                                                    //                 TreansactionBooking t = TreansactionBooking(bookingId: new_booking_id, walletId: walletId, description: descriptionTxt.text);
                                                                    //                 final x = await transactionProvider.transferBooking(t);
                                                                    //                 Navigator.pop(context);

                                                                    //                 print(x);
                                                                    //                 if (x == 200) {
                                                                    //                   Navigator.pop(context);
                                                                    //                 }
                                                                    //               },
                                                                    //               child: Padding(
                                                                    //                 padding: const EdgeInsets.all(8.0),
                                                                    //                 child: Container(
                                                                    //                   decoration: BoxDecoration(
                                                                    //                     borderRadius: BorderRadius.circular(10),
                                                                    //                     color: colorprimarygreen,
                                                                    //                   ),
                                                                    //                   width: 280,
                                                                    //                   height: 60,
                                                                    //                   child: Row(
                                                                    //                     crossAxisAlignment: CrossAxisAlignment.center,
                                                                    //                     mainAxisAlignment: MainAxisAlignment.center,
                                                                    //                     children: [
                                                                    //                       Text("ايداع", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: colorprimarywhite)),
                                                                    //                       Padding(padding: EdgeInsets.all(8)),
                                                                    //                       Icon(
                                                                    //                         size: 25,
                                                                    //                         Icons.transfer_within_a_station,
                                                                    //                         color: colorprimarywhite,
                                                                    //                       )
                                                                    //                     ],
                                                                    //                   ),
                                                                    //                 ),
                                                                    //               ),
                                                                    //             ),
                                                                    //           ],
                                                                    //         );
                                                                    //       },
                                                                    //     );
                                                                    //   },
                                                                    //   btnCancelOnPress:
                                                                    //       () {},
                                                                    //   btnOkIcon:
                                                                    //       Icons
                                                                    //           .check_circle,
                                                                    //   onDismissCallback:
                                                                    //       (type) {},
                                                                    // ).show();

                                                                    // Navigator
                                                                    //     .canPop(
                                                                    //         context);
                                                                    // Navigator
                                                                    //     .pushAndRemoveUntil<
                                                                    //         void>(
                                                                    //   context,
                                                                    //   MaterialPageRoute<
                                                                    //           void>(
                                                                    //       builder: (BuildContext context) =>
                                                                    //           const ViewCarsCustomer()),
                                                                    //   ModalRoute
                                                                    //       .withName(
                                                                    //           '/'),
                                                                    // );
                                                                    // Future
                                                                    //     .delayed(
                                                                    //   Duration(
                                                                    //       seconds:
                                                                    //           5),
                                                                    //   () {
                                                                    //     Navigator.pop(
                                                                    //         context);
                                                                    //   },
                                                                    // );
                                                                  }
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color:
                                                                          colorprimarygreen,
                                                                    ),
                                                                    width: 280,
                                                                    height: 60,
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                            "حفظ",
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 18,
                                                                                color: colorprimarywhite)),
                                                                        Padding(
                                                                            padding:
                                                                                EdgeInsets.all(8)),
                                                                        Icon(
                                                                          size:
                                                                              25,
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              colorprimarywhite,
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
                                                    }

                                                    // Navigator.push(context,
                                                    //     MaterialPageRoute(
                                                    //   builder: (context) {
                                                    //     return BookingHomePage();
                                                    //   },
                                                    // ));
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(
                                                            Icons.car_rental),
                                                      ),
                                                      Text(
                                                        "احجز السيارة",
                                                        style: TextStyle(
                                                            fontSize: 17),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            top: 120,
                                            right: 15,
                                            child: Container(
                                              width: 130,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Color.fromARGB(
                                                      255, 240, 251, 43)),
                                              child: Center(
                                                child: Text(
                                                  "RY ${snapshot.data![index].price}",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            )),
                                        Positioned(
                                            top: 12,
                                            right: 20,
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: colorprimarygreen),
                                              child: Center(
                                                child: Text(
                                                  "${index + 1}",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: colorprimarywhite),
                                                ),
                                              ),
                                            )),
                                        Positioned(
                                            top: 220,
                                            left: 20,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${snapshot.data![index].name}",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                ),
                                              ],
                                            )),
                                        Positioned(
                                            top: 255,
                                            left: 20,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${snapshot.data![index].model}",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ],
                                            )),
                                        Positioned(
                                          top: 70,
                                          left: 20,
                                          child: SizedBox(
                                            width: 150,
                                            height: 150,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                snapshot.data![index]
                                                    .imageCarOfBrands!,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        )
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
                  ),
                )

                // SizedBox(
                //   height: MediaQuery.of(context).size.height / 2.5,
                //   width: MediaQuery.of(context).size.width,
                //   child: FutureBuilder(
                //     future: getCarsWithIdUserAndIdPrandWithApi(
                //         user_id: id_user_branch, prand_id: prand_id_branch),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         return ListView.builder(
                //           scrollDirection: Axis.horizontal,
                //           itemCount: snapshot.data!.length,
                //           itemBuilder: (context, index) {
                //             return SizedBox(
                //               height: MediaQuery.of(context).size.height / 2.5,
                //               width: MediaQuery.of(context).size.width / 1.8,
                //               child: Container(
                //                 decoration: BoxDecoration(
                //                     color: colorprimarygreen,
                //                     borderRadius: BorderRadius.circular(20)),
                //                 margin: EdgeInsets.all(10),
                //                 child: Column(
                //                   children: [
                //                     SizedBox(
                //                       height: 20,
                //                     ),
                //                     Text(
                //                       "${snapshot.data![index]['name']}",
                //                       style: GoogleFonts.aBeeZee(
                //                         color: colorprimarywhite,
                //                         fontSize: 20,
                //                       ),
                //                     ),
                //                     Padding(
                //                       padding: const EdgeInsets.all(8.0),
                //                       child: SizedBox(
                //                         height:
                //                             MediaQuery.of(context).size.height /
                //                                 4,
                //                         width:
                //                             MediaQuery.of(context).size.height /
                //                                 3,
                //                         child: Container(
                //                           child: Image.network(
                //                               snapshot.data![index]
                //                                   ['image_car_brands'],
                //                               fit: BoxFit.contain),
                //                         ),
                //                       ),
                //                     )
                //                   ],
                //                 ),
                //               ),
                //             );
                //           },
                //         );
                //       }
                //       return Center(child: CircularProgressIndicator());
                //     },
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
