import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/features/Models/Transaction/TransactionHistoreyDiposit.dart';
import 'package:booking_car_project_flutter/features/ViewModels/TransactionVM.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageDipositPage extends StatefulWidget {
  const ManageDipositPage({super.key});

  @override
  State<ManageDipositPage> createState() => _ManageDipositPageState();
}

class _ManageDipositPageState extends State<ManageDipositPage> {
  int x = 0;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final transactionProvider = Provider.of<TransactionVM>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    x = 0;
                    transactionProvider.notifyListeners();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: x == 1
                            ? Color.fromARGB(255, 218, 221, 223)
                            : Color.fromARGB(255, 5, 19, 215),
                        borderRadius: BorderRadius.circular(10)),
                    child: SizedBox(
                      width: (w / 2) - 25,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "كل عمليات الايداع",
                            style: TextStyle(
                                color:
                                    x == 1 ? Colors.black : colorprimarywhite,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 30,
                            width: 50,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  left: 7,
                                  child: Icon(
                                    Icons.notification_add_sharp,
                                    size: 30,
                                    color: x == 1
                                        ? Colors.black
                                        : colorprimarywhite,
                                  ),
                                ),
                                Positioned(
                                  top: 3.5,
                                  child: FutureBuilder(
                                    future: transactionProvider
                                        .getConutTransactionHistory(id: '3'),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          "${snapshot.data!.toString()}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: x == 1
                                                  ? Colors.black
                                                  : colorprimarywhite,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }
                                      return Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('في انتضار الانترنت',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    x = 1;
                    transactionProvider.notifyListeners();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: x == 0
                            ? Color.fromARGB(255, 218, 221, 223)
                            : Color.fromARGB(255, 5, 19, 215),
                        borderRadius: BorderRadius.circular(10)),
                    child: SizedBox(
                      width: (w / 2) - 25,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " الايداع الجديدة",
                            style: TextStyle(
                                color:
                                    x == 0 ? Colors.black : colorprimarywhite,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 30,
                            width: 50,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  left: 7,
                                  child: Icon(
                                    Icons.notification_add_sharp,
                                    size: 30,
                                    color: x == 0
                                        ? Colors.black
                                        : colorprimarywhite,
                                  ),
                                ),
                                Positioned(
                                  top: 3.5,
                                  child: FutureBuilder(
                                    future: transactionProvider
                                        .getConutTransactionHistoryDipositStatusFalse(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          "${snapshot.data!.toString()}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: x == 0
                                                  ? Colors.black
                                                  : colorprimarywhite,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }
                                      return Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('في انتضار الانترنت',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            x == 0
                ? SizedBox(
                    height: h - 315,
                    width: w,
                    child: FutureBuilder(
                      //transactionHistoryNotTransfer(id: '3'),
                      //id =3 for Diposit responce
                      future: transactionProvider.transactionHistoryNotTransfer(
                          id: '3'),
                      builder: (context, snapshot) {
                        //List<TransactionHistoryDiposit> listx = snapshot.data!;
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: snapshot.data![index].status!
                                          // Color.fromARGB(255, 185, 197, 198)
                                          ? Color.fromARGB(255, 176, 249, 191)
                                          : Color.fromARGB(255, 252, 197, 197)),
                                  child: Column(
                                    children: [
                                      Text(
                                          "رقم العملية : ${snapshot.data![index].id!.toString()}"),
                                      Text(
                                          "اسم حساب العميل : ${snapshot.data![index].wallet!.user!.username!.toString()}"),
                                      Text(
                                          "اسم العميل : ${snapshot.data![index].wallet!.user!.fullName!.toString()}"),
                                      Text(
                                          "ايميل العميل : ${snapshot.data![index].wallet!.user!.email!.toString()}"),
                                      Text(
                                          "رقم العميل : ${snapshot.data![index].wallet!.user!.phone!.toString()}"),
                                      Text(
                                          "المبلغ الذي تم ايداعه : ${snapshot.data![index].amount!.toString()}"),
                                      Text(snapshot.data![index].status!
                                          ? ' حالة العملية : تم التأكيد'
                                          : " حالة العملية : لم يتم التأكيد"),
                                      Text(
                                          "رقم حساب العميل : ${snapshot.data![index].wallet!.code!.toString()}"),
                                      Text(
                                          "المبلغ الذي في محفظته : ${snapshot.data![index].wallet!.balance!.toString()}"),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      snapshot.data![index].status!
                                          ? Container()
                                          : ElevatedButton(
                                              onPressed: () {
                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType:
                                                      DialogType.question,
                                                  headerAnimationLoop: false,
                                                  animType:
                                                      AnimType.bottomSlide,
                                                  title: 'هل حقا تريد التأكيد',
                                                  desc:
                                                      '''سوف يتم ايداع مبلغ من المال وقدره 
                                            ${snapshot.data![index].amount!}
${snapshot.data![index].wallet!.code!}  الى محفظة العميل   ${snapshot.data![index].wallet!.user!.fullName} لصاحبها''',
                                                  buttonsTextStyle:
                                                      const TextStyle(
                                                          color: Colors.black),
                                                  showCloseIcon: true,
                                                  btnCancelOnPress: () {},
                                                  btnOkOnPress: () async {
                                                    var code =
                                                        await transactionProvider
                                                            .updateDiposit(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .id!);
                                                    if (code == 200) {
                                                      AwesomeDialog(
                                                        context: context,
                                                        animType:
                                                            AnimType.leftSlide,
                                                        headerAnimationLoop:
                                                            false,
                                                        dialogType:
                                                            DialogType.success,
                                                        showCloseIcon: true,
                                                        title: 'نجحت العملية',
                                                        desc:
                                                            'تم تأكيد الايداع بنجاح',
                                                        btnOkOnPress: () {
                                                          debugPrint('OnClcik');
                                                        },
                                                        btnOkIcon:
                                                            Icons.check_circle,
                                                        onDismissCallback:
                                                            (type) {
                                                          debugPrint(
                                                              'Dialog Dissmiss from callback $type');
                                                        },
                                                      ).show();
                                                    }
                                                  },
                                                ).show();
                                              },
                                              child: Text(
                                                  "هل تريد التأكيد على عملية الأيداع"))
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('في انتضار الانترنت',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Center(child: CircularProgressIndicator()),
                          ],
                        );
                      },
                    ),
                  )
                : x == 1
                    ? SizedBox(
                        height: h - 315,
                        width: w,
                        child: FutureBuilder(
                          //transactionHistoryNotTransfer(id: '3'),
                          //id =3 for Diposit responce
                          future: transactionProvider
                              .getonlyTransactionHistoryDipositWithStatusFalse(),
                          builder: (context, snapshot) {
                            //List<TransactionHistoryDiposit> listx = snapshot.data!;
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: snapshot.data![index].status!
                                              // Color.fromARGB(255, 185, 197, 198)
                                              ? Color.fromARGB(
                                                  255, 176, 249, 191)
                                              : Color.fromARGB(
                                                  255, 252, 197, 197)),
                                      child: Column(
                                        children: [
                                          Text(
                                              "رقم العملية : ${snapshot.data![index].id!.toString()}"),
                                          Text(
                                              "اسم حساب العميل : ${snapshot.data![index].wallet!.user!.username!.toString()}"),
                                          Text(
                                              "اسم العميل : ${snapshot.data![index].wallet!.user!.fullName!.toString()}"),
                                          Text(
                                              "ايميل العميل : ${snapshot.data![index].wallet!.user!.email!.toString()}"),
                                          Text(
                                              "رقم العميل : ${snapshot.data![index].wallet!.user!.phone!.toString()}"),
                                          Text(
                                              "المبلغ الذي تم ايداعه : ${snapshot.data![index].amount!.toString()}"),
                                          Text(snapshot.data![index].status!
                                              ? ' حالة العملية : تم التأكيد'
                                              : " حالة العملية : لم يتم التأكيد"),
                                          Text(
                                              "رقم حساب العميل : ${snapshot.data![index].wallet!.code!.toString()}"),
                                          Text(
                                              "المبلغ الذي في محفظته : ${snapshot.data![index].wallet!.balance!.toString()}"),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          snapshot.data![index].status!
                                              ? Container()
                                              : ElevatedButton(
                                                  onPressed: () {
                                                    AwesomeDialog(
                                                      context: context,
                                                      dialogType:
                                                          DialogType.question,
                                                      headerAnimationLoop:
                                                          false,
                                                      animType:
                                                          AnimType.bottomSlide,
                                                      title:
                                                          'هل حقا تريد التأكيد',
                                                      desc:
                                                          '''سوف يتم ايداع مبلغ من المال وقدره 
                                            ${snapshot.data![index].amount!}
${snapshot.data![index].wallet!.code!}  الى محفظة العميل   ${snapshot.data![index].wallet!.user!.fullName} لصاحبها''',
                                                      buttonsTextStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.black),
                                                      showCloseIcon: true,
                                                      btnCancelOnPress: () {},
                                                      btnOkOnPress: () async {
                                                        var code =
                                                            await transactionProvider
                                                                .updateDiposit(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .id!);
                                                        if (code == 200) {
                                                          AwesomeDialog(
                                                            context: context,
                                                            animType: AnimType
                                                                .leftSlide,
                                                            headerAnimationLoop:
                                                                false,
                                                            dialogType:
                                                                DialogType
                                                                    .success,
                                                            showCloseIcon: true,
                                                            title:
                                                                'نجحت العملية',
                                                            desc:
                                                                'تم تأكيد الايداع بنجاح',
                                                            btnOkOnPress: () {
                                                              debugPrint(
                                                                  'OnClcik');
                                                            },
                                                            btnOkIcon: Icons
                                                                .check_circle,
                                                            onDismissCallback:
                                                                (type) {
                                                              debugPrint(
                                                                  'Dialog Dissmiss from callback $type');
                                                            },
                                                          ).show();
                                                        }
                                                      },
                                                    ).show();
                                                  },
                                                  child: Text(
                                                      "هل تريد التأكيد على عملية الأيداع"))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            return Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('في انتضار الانترنت',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Center(child: CircularProgressIndicator()),
                              ],
                            );
                          },
                        ),
                      )
                    : Container(
                        child: Text("يرجى التحديد"),
                      )
          ],
        )),
      ),
    );
  }
}
