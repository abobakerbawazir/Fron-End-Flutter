import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/features/ViewModels/TransactionVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/Mony/GetInfoAllTransactionHistoryToTransferOnePage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class GetInfoAllTransactionHistoryToTransferPage extends StatefulWidget {
  const GetInfoAllTransactionHistoryToTransferPage({super.key});

  @override
  State<GetInfoAllTransactionHistoryToTransferPage> createState() =>
      _GetInfoAllTransactionHistoryToTransferPageState();
}

class _GetInfoAllTransactionHistoryToTransferPageState
    extends State<GetInfoAllTransactionHistoryToTransferPage> {
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
            Text(
              "عمليات التحويل من حساب الى اخر",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: h - 270,
              width: w,
              child: FutureBuilder(
                future: transactionProvider
                    .getInfoAllTransactionHistoryToTransfer(),
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
