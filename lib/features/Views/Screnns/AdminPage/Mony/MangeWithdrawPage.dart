import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/features/Models/Transaction/TransactionHistoreyDiposit.dart';
import 'package:booking_car_project_flutter/features/Models/Transaction/TransactionHistory.dart';
import 'package:booking_car_project_flutter/features/ViewModels/TransactionVM.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MangeWithdrawPage extends StatefulWidget {
  const MangeWithdrawPage({super.key});

  @override
  State<MangeWithdrawPage> createState() => _MangeWithdrawPageState();
}

class _MangeWithdrawPageState extends State<MangeWithdrawPage> {
  TextEditingController amountTxt = TextEditingController();
  TextEditingController codeTxt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final transactionProvider = Provider.of<TransactionVM>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: Column(
            children: [
              Container(
                // color: Colors.grey,
                child: SizedBox(
                  width: w,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "عمليات السحب",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              top: 3.5,
                              child: FutureBuilder(
                                future: transactionProvider
                                    .getConutTransactionHistory(id: '1'),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      "${snapshot.data!.toString()}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
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
                                      Center(
                                          child: CircularProgressIndicator()),
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
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(actions: [
                          Material(
                              elevation: 0,
                              color: Colors.blueGrey.withAlpha(40),
                              child: TextFormField(
                                controller: codeTxt,
                                
                                keyboardType: TextInputType.text,
                                autofocus: true,
                                minLines: 1,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'رقم المحفظة',
                                  prefixIcon: Icon(Icons.text_fields),
                                ),
                              )),SizedBox(height: 10,),
                              Material(
                              elevation: 0,
                              color: Colors.blueGrey.withAlpha(40),
                              child: TextFormField(
                                controller: amountTxt,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                autofocus: true,
                                minLines: 1,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'المبلغ',
                                  prefixIcon: Icon(Icons.text_fields),
                                ),
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                Treansaction t = Treansaction(
                                    code: codeTxt.text,
                                    amount: double.parse(amountTxt.text),
                                    status: true);
                                final x = await transactionProvider.withdraw(t);
                                print(x);
                                if (x == 200) {
                                  Navigator.pop(context);
                                }
                              },
                              child: Text("اضافة"))
                        ]);
                      },
                    );
                  },
                  child: Text("اضافة سحب"),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                height: h - 350,
                width: w,
                child: FutureBuilder(
                  //transactionHistoryNotTransfer(id: '1'),
                  //id =3 for Withdraw responce
                  future: transactionProvider.transactionHistoryNotTransfer(
                      id: '1'),
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
                                              dialogType: DialogType.question,
                                              headerAnimationLoop: false,
                                              animType: AnimType.bottomSlide,
                                              title: 'هل حقا تريد التأكيد',
                                              desc:
                                                  '''سوف يتم ايداع مبلغ من المال وقدره 
                                              ${snapshot.data![index].amount!}
      ${snapshot.data![index].wallet!.code!}  الى محفظة العميل   ${snapshot.data![index].wallet!.user!.fullName} لصاحبها''',
                                              buttonsTextStyle: const TextStyle(
                                                  color: Colors.black),
                                              showCloseIcon: true,
                                              btnCancelOnPress: () {},
                                              btnOkOnPress: () async {
                                                var code =
                                                    await transactionProvider
                                                        .updateDiposit(snapshot
                                                            .data![index].id!);
                                                if (code == 200) {
                                                  AwesomeDialog(
                                                    context: context,
                                                    animType:
                                                        AnimType.leftSlide,
                                                    headerAnimationLoop: false,
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
                                                    onDismissCallback: (type) {
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
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Center(child: CircularProgressIndicator()),
                      ],
                    );
                  },
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
