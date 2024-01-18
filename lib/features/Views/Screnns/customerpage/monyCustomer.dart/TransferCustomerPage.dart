import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/features/ViewModels/TransactionVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/Mony/GetInfoAllTransactionHistoryToTransferOnePage.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class TransferCustomerPage extends StatefulWidget {
  const TransferCustomerPage({super.key});

  @override
  State<TransferCustomerPage> createState() => _TransferCustomerPageState();
}

class _TransferCustomerPageState extends State<TransferCustomerPage> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final transactionProvider = Provider.of<TransactionVM>(context);
    final walletId = box.read('walletId');
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
                      "عمليات التحويل",
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
                                  .getCustomerTransactionHistoryToTransfer(
                                      id: walletId),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    "${snapshot.data!.length}",
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
              height: h - 270,
              width: w,
              child: FutureBuilder(
                future: transactionProvider
                    .getCustomerTransactionHistoryToTransfer(id: walletId),
                builder: (context, snapshot) {
                  //List<TransactionHistoryDiposit> listx = snapshot.data!;
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            final box = GetStorage();
                            box.write(
                                'transactionId', snapshot.data![index].id!);
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return GetInfoAllTransactionHistoryToTransferOnePage();
                              },
                            ));
                          },
                          child: Padding(
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
