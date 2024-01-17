import 'package:booking_car_project_flutter/features/Models/Transaction/TransactionHistory.dart';
import 'package:booking_car_project_flutter/features/ViewModels/BookingCoustomerByBranchVM.dart';
import 'package:booking_car_project_flutter/features/ViewModels/TransactionVM.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController amountTxt = TextEditingController();
  TextEditingController descriptionTxt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final bookingCoustomerByBranchProvider =
        Provider.of<BookingCoustomerByBranchVM>(context);
    final id = box.read('getByIDInformationBookingForAllCustomerPage') ?? 294;
    //final xx = box.read('id_getByIDInformationBookingForAllCustomerPage') ?? 0;
    final days_booking =
        box.read('id_getByIDInformationBookingForAllCustomerPage') ?? 0;
    final role_user = box.read('role_user');
    final walletId = box.read("walletId");
    final transactionProvider = Provider.of<TransactionVM>(context);

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
                              snapshot.data!.status == "معلق" &&
                                      role_user == "customer"
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        amountTxt.text =
                                            snapshot.data!.total.toString();

                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Center(
                                                  child: Text(
                                                      "المبلغ الاجمالي للحجزهو : ${snapshot.data!.total.toString()} RY")),
                                              actions: [
                                                MyTextFormField(
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    hintText: 'المبلغ',
                                                    controller: amountTxt,
                                                    readOnly: true,
                                                    suffixIcon: Icon(
                                                        Icons.attach_money)),
                                                MyTextFormField(
                                                  maxLines: null,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  hintText: 'الوصف ان امكن',
                                                  controller: descriptionTxt,
                                                  readOnly: false,
                                                  suffixIcon:
                                                      Icon(Icons.description),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    Treansaction t =
                                                        Treansaction(
                                                            bookingId: snapshot
                                                                .data!.id,
                                                            walletId: walletId,
                                                            description:
                                                                descriptionTxt
                                                                    .text);
                                                    final x =
                                                        await transactionProvider
                                                            .transfer(t);
                                                    print(x);
                                                    if (x == 200) {
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
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
                                                          Text("تحويل",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18,
                                                                  color:
                                                                      colorprimarywhite)),
                                                          Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8)),
                                                          Icon(
                                                            size: 25,
                                                            Icons
                                                                .transfer_within_a_station,
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
                                      },
                                      child: Text("أدفع عبر المحفظة"))
                                  : Container(),
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
                              Text(
                                  "عدد ايام الحجز : ${days_booking.toString()} يوم"),
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
                              // Text("معلومات صاحب الفرع",
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: 17)),
                              // Text(
                              //     "الايميل : ${snapshot.data!.cars!.users!.email.toString()}"),
                              // Text(
                              //     "الاسم : ${snapshot.data!.cars!.users!.fullName.toString()}"),
                              // Text(
                              //     "رقم الهاتف : ${snapshot.data!.cars!.users!.phone.toString()}"),
                              // Text(
                              //     "العنوان : ${snapshot.data!.cars!.users!.location.toString()}"),
                              Text("الصورة للسيارة",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              snapshot.data!.cars!.imageCarBrands!.length == 0
                                  ? Text("لاتوجد صورة")
                                  : snapshot.data!.cars!.imageCarBrands!
                                              .length >
                                          1
                                      ? SizedBox(
                                          height: h / 3,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: Image.network(
                                                snapshot.data!.cars!
                                                    .imageCarBrands![0].url
                                                    .toString(),
                                                fit: BoxFit.fill,
                                              )),
                                        )
                                      : SizedBox(
                                          height: h / 3,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: Image.network(
                                                snapshot.data!.cars!
                                                    .imageCarBrands![0].url
                                                    .toString(),
                                                fit: BoxFit.fill,
                                              )),
                                        ),
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
                              Text("صورة الزبون",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              SizedBox(
                                height: h / 3,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                      snapshot.data!.user!.image!,
                                      fit: BoxFit.fill,
                                    )),
                              )
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
