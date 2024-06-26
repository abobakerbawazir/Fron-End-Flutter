import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/features/Models/Transaction/TransactionHistoreyDiposit.dart';
import 'package:booking_car_project_flutter/features/Models/Transaction/TransactionHistory.dart';
import 'package:booking_car_project_flutter/features/ViewModels/TransactionVM.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class DipostitOfCustomerPage extends StatefulWidget {
  const DipostitOfCustomerPage({super.key});

  @override
  State<DipostitOfCustomerPage> createState() => _DipostitOfCustomerPageState();
}

class _DipostitOfCustomerPageState extends State<DipostitOfCustomerPage> {
  TextEditingController amountTxt = TextEditingController();
  TextEditingController descriptionTxt = TextEditingController();
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final transactionProvider = Provider.of<TransactionVM>(context);
    final walletId = box.read("walletId");
    return Scaffold(
      body: Padding(
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
                      "كل العمليات",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                            left: 0,
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
                                  .getInfoAllTransactionHistoryforCustomer(
                                      walletId: walletId, id: '3'),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    "${snapshot.data!.length.toString()}",
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
                                    Center(child: CircularProgressIndicator()),
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
              height: 12,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Center(child: Text("يرجى اضافة المبلغ المطلوب")),
                      actions: [
                        MyTextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            hintText: 'المبلغ',
                            controller: amountTxt,
                            readOnly: false,
                            suffixIcon: Icon(Icons.attach_money)),
                        MyTextFormField(
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          hintText: 'الوصف ان امكن',
                          controller: descriptionTxt,
                          readOnly: false,
                          suffixIcon: Icon(Icons.description),
                        ),
                        InkWell(
                          onTap: () async {
                            Treansaction t = Treansaction(
                                walletId: walletId,
                                amount: double.parse(amountTxt.text),
                                description: descriptionTxt.text);
                            final x = await transactionProvider.diposit(t);
                            print(x);
                            if (x == 200) {
                              Navigator.pop(context);
                            }
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
                                  Text("ايداع",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: colorprimarywhite)),
                                  Padding(padding: EdgeInsets.all(8)),
                                  Icon(
                                    size: 25,
                                    Icons.transfer_within_a_station,
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
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: colorprimarygrey,
                            borderRadius: BorderRadius.circular(6)),
                        child: Icon(
                          Icons.add,
                          color: colorprimarywhite,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "اضافة عملية ايداع",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: h - 330,
              width: w,
              child: FutureBuilder(
                //transactionHistoryNotTransfer(id: '1'),
                //id =3 for Withdraw responce
                future:
                    transactionProvider.getInfoAllTransactionHistoryforCustomer(
                        walletId: walletId, id: '3'),
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
                                    ? colorprimaryA1
                                    : Color.fromARGB(255, 252, 197, 197)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                      "رقم العملية : ${snapshot.data![index].id!.toString()}"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                      "اسم حساب العميل : ${snapshot.data![index].wallet!.user!.username!.toString()}"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                      "اسم العميل : ${snapshot.data![index].wallet!.user!.fullName!.toString()}"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                      "ايميل العميل : ${snapshot.data![index].wallet!.user!.email!.toString()}"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                      "رقم العميل : ${snapshot.data![index].wallet!.user!.phone!.toString()}"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                      "المبلغ الذي تم ايداعه : ${snapshot.data![index].amount!.toString()}"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(snapshot.data![index].status!
                                      ? ' حالة العملية : تم التأكيد'
                                      : " حالة العملية : لم يتم التأكيد"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                      "رقم حساب العميل : ${snapshot.data![index].wallet!.code!.toString()}"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                      "المبلغ الذي في محفظته : ${snapshot.data![index].wallet!.balance!.toString()}"),
                                ),
                                snapshot.data![index].transactionType!.name ==
                                        'تحويل'
                                    ? Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                            "المبلغ الذي  تم تحويله : ${snapshot.data![index].amount!.toString()}"),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                            "المبلغ الذي تم إيداعه : ${snapshot.data![index].amount!.toString()}"),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                      "  الوصف : ${snapshot.data![index].description!.toString()}"),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
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
    );
  }
}
