import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/features/ViewModels/BookingCoustomerByBranchVM.dart';
import 'package:booking_car_project_flutter/features/ViewModels/PrandVM.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/BookingPage/getByIDInformationBookingForAllCustomerPage.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class getBookingByBranchIdByCustomerIdForCoustomerPage extends StatefulWidget {
  const getBookingByBranchIdByCustomerIdForCoustomerPage({super.key});
  @override
  State<getBookingByBranchIdByCustomerIdForCoustomerPage> createState() =>
      _getBookingByBranchIdByCustomerIdForCoustomerPageState();
}

class _getBookingByBranchIdByCustomerIdForCoustomerPageState
    extends State<getBookingByBranchIdByCustomerIdForCoustomerPage> {
  int x = 0;
  int z = -1;
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final user_id = box.read('user_id');
    final branch_id = box.read('branch_id') ?? 0;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final userProvider = Provider.of<UserVM>(context);

    final prandProvider = Provider.of<PrandVM>(context);

    final bookingCoustomerByBranchProvider =
        Provider.of<BookingCoustomerByBranchVM>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("getBookingByBranchIdByCustomerIdForCoustomerPage"),
        // ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Container(
                // color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: x != 0
                              ? colorprimarywhite
                              : const Color.fromARGB(255, 19, 74, 120)),
                      onPressed: () {
                        x = 0;

                        setState(() {});
                      },
                      child: Text(
                        "عرض جميع الحجوزات",
                        style: TextStyle(
                            color: x != 0 ? Colors.black : colorprimarywhite),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: x != 1
                                ? colorprimarywhite
                                : const Color.fromARGB(255, 19, 74, 120)),
                        onPressed: () {
                          x = 1;

                          setState(() {});
                        },
                        child: Text(
                          "الحجوزات حسب الفرع",
                          style: TextStyle(
                              color: x != 1 ? Colors.black : colorprimarywhite),
                        ))
                  ],
                ),
              ),
              x == 0
                  ? Column(
                      children: [
                        // SizedBox(
                        //   height: 100,
                        // ),
                        SizedBox(
                          child: FutureBuilder(
                            future: bookingCoustomerByBranchProvider
                                .getAllInformationBookingForOnlyCustomer(
                                    user_id: user_id),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.isEmpty) {
                                  return Center(child: Text("لاتوجد حجوزات"));
                                }
                                return SizedBox(
                                  height: h - 200,
                                  width: w,
                                  child: ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      int x = (snapshot.data![index].total! /
                                                  snapshot.data![index].cars!
                                                      .price!)
                                              .toInt() ??
                                          0;
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                //margin: EdgeInsets.all(8),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          "${index + 1}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17),
                                                        ),
                                                        SizedBox(
                                                          width: 70,
                                                        ),
                                                        Text(
                                                          "معلومات الحجز الاولية",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17),
                                                        ),
                                                      ],
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
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17)),
                                                    Text(
                                                        "اسم السيارة : ${snapshot.data![index].cars!.name.toString()}"),
                                                    Text(
                                                        "موديل السيارة : ${snapshot.data![index].cars!.model.toString()}"),
                                                    Text(
                                                        "سعر السيارة لليوم الواحد : ${snapshot.data![index].cars!.price.toString()}"),
                                                    Text("معلومات صاحب الفرع",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17)),
                                                    snapshot
                                                                .data![index]
                                                                .cars!
                                                                .imageCarBrands!
                                                                .length ==
                                                            0
                                                        ? Text("لاتوجد صورة")
                                                        : snapshot
                                                                    .data![
                                                                        index]
                                                                    .cars!
                                                                    .imageCarBrands!
                                                                    .length >
                                                                1
                                                            ? Image.network(snapshot
                                                                .data![index]
                                                                .cars!
                                                                .imageCarBrands![
                                                                    0]
                                                                .url
                                                                .toString())
                                                            : Image.network(snapshot
                                                                .data![index]
                                                                .cars!
                                                                .imageCarBrands![
                                                                    0]
                                                                .url
                                                                .toString()),
                                                    Text(
                                                        "معلومات العميل الذي قام بعملية الحجز",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                  ),
                                );
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "جاري التحميل",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Center(child: CircularProgressIndicator()),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : x == 1
                      ? Column(
                          children: [
                            Text("الرجاء أختيار احد الفرع"),
                            SizedBox(
                              height: 150,
                              width: w,
                              child: FutureBuilder(
                                  future: userProvider
                                      .getAllBranchesActiveOrAllUserFromAPi(
                                          url: APIurl.viewAllBranchActive),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        //clipBehavior: Clip.none,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            width: 300,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child: InkWell(
                                              onTap: () {
                                                z = index;
                                                final box = GetStorage();
                                                box.write('branch_id',
                                                    snapshot.data![index].id);
                                                print(box.read('branch_id'));
                                                setState(() {});
                                                // Navigator.push(context, MaterialPageRoute(
                                                //   builder: (context) {
                                                //     var x = box.read('role_user');
                                                //     if (x == 'branch') {
                                                //       return AddCarScrrens();
                                                //     } else {
                                                //       return ViewCarsCustomer();
                                                //     }
                                                //   },
                                                // ));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: z == index
                                                          ? Color.fromARGB(255,
                                                              166, 216, 234)
                                                          : const Color
                                                                  .fromARGB(255,
                                                              219, 214, 214),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Positioned(
                                                        top: 15,
                                                        left: 12,
                                                        child: SizedBox(
                                                          height: 100,
                                                          width: 100,
                                                          child: Image.network(
                                                            snapshot
                                                                .data![index]
                                                                .image!,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 15,
                                                        right: 12,
                                                        child: Wrap(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  "${snapshot.data![index].fullName!}",
                                                                  style:
                                                                      TextStyle(
                                                                    // fontWeight: FontWeight.bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        20,
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 40,
                                                        right: 12,
                                                        child: Wrap(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  "${snapshot.data![index].email!}",
                                                                  style:
                                                                      TextStyle(
                                                                    // fontWeight: FontWeight.bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12,
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 60,
                                                        right: 12,
                                                        child: Wrap(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  "${snapshot.data![index].phone!}",
                                                                  style:
                                                                      TextStyle(
                                                                    // fontWeight: FontWeight.bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15,
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "جاري التحميل",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Center(
                                            child: CircularProgressIndicator()),
                                      ],
                                    );
                                  }),
                            ),
                            // SizedBox(
                            //   height: 100,
                            // ),
                            SizedBox(
                              child: FutureBuilder(
                                future: bookingCoustomerByBranchProvider
                                    .getBookingByBranchIdByCustomerIdForCoustomer(
                                        branch_id: branch_id, user_id: user_id),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data!.isEmpty) {
                                      return Center(
                                          child: Text("لاتوجد حجوزات"));
                                    }
                                    return SizedBox(
                                      height: h - 400,
                                      width: w,
                                      child: ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          int x =
                                              (snapshot.data![index].total! /
                                                          snapshot.data![index]
                                                              .cars!.price!)
                                                      .toInt() ??
                                                  0;
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                  builder: (context) {
                                                    final box = GetStorage();
                                                    box.write(
                                                        'getByIDInformationBookingForAllCustomerPage',
                                                        snapshot
                                                            .data![index].id);
                                                    box.write(
                                                        'id_getByIDInformationBookingForAllCustomerPage',
                                                        x);
                                                    return getByIDInformationBookingForAllCustomerPage();
                                                  },
                                                ));
                                              },
                                              child: Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    //margin: EdgeInsets.all(8),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "معلومات الحجز الاولية",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17)),
                                                        Text(
                                                            "اسم السيارة : ${snapshot.data![index].cars!.name.toString()}"),
                                                        Text(
                                                            "موديل السيارة : ${snapshot.data![index].cars!.model.toString()}"),
                                                        Text(
                                                            "سعر السيارة لليوم الواحد : ${snapshot.data![index].cars!.price.toString()}"),
                                                        Text(
                                                            "معلومات صاحب الفرع",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17)),
                                                        snapshot
                                                                    .data![
                                                                        index]
                                                                    .cars!
                                                                    .imageCarBrands!
                                                                    .length ==
                                                                0
                                                            ? Text(
                                                                "لاتوجد صورة")
                                                            : snapshot
                                                                        .data![
                                                                            index]
                                                                        .cars!
                                                                        .imageCarBrands!
                                                                        .length >
                                                                    1
                                                                ? Image.network(snapshot
                                                                    .data![
                                                                        index]
                                                                    .cars!
                                                                    .imageCarBrands![
                                                                        0]
                                                                    .url
                                                                    .toString())
                                                                : Image.network(snapshot
                                                                    .data![
                                                                        index]
                                                                    .cars!
                                                                    .imageCarBrands![
                                                                        0]
                                                                    .url
                                                                    .toString()),
                                                        Text(
                                                            "معلومات العميل الذي قام بعملية الحجز",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                      ),
                                    );
                                  }
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "جاري التحميل",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Center(
                                          child: CircularProgressIndicator()),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : Container()
            ],
          ),
        ),
      ),
    );
  }
}
