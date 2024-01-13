import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/features/ViewModels/TransactionVM.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class GetInfoAllTransactionHistoryToTransferOnePage extends StatefulWidget {
  const GetInfoAllTransactionHistoryToTransferOnePage({super.key});

  @override
  State<GetInfoAllTransactionHistoryToTransferOnePage> createState() =>
      _GetInfoAllTransactionHistoryToTransferOnePageState();
}

class _GetInfoAllTransactionHistoryToTransferOnePageState
    extends State<GetInfoAllTransactionHistoryToTransferOnePage> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final transactionProvider = Provider.of<TransactionVM>(context);
    int transactionId = box.read('transactionId');
    return Scaffold(
      appBar: AppBar(
        title: Text("TransferOne"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Column(
                children: [
                  Center(
                      child: Text(
                    "ادارة الاموال",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                  Text("عمليات التحويل من حساب الى اخر"),
                  SizedBox(
                    width: w,
                    child: FutureBuilder(
                      future: transactionProvider
                          .getTransactionHistoryToTransferOne(
                              id: transactionId),
                      builder: (context, snapshot) {
                        //List<TransactionHistoryDiposit> listx = snapshot.data!;
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: snapshot.data!.treansaction!.status!
                                      // Color.fromARGB(255, 185, 197, 198)
                                      ? Color.fromARGB(255, 176, 249, 191)
                                      : Color.fromARGB(255, 252, 197, 197)),
                              child: Column(
                                children: [
                                  Text(
                                      "رقم العملية : ${snapshot.data!.treansaction!.id!.toString()}"),
                                  Text(
                                      "اسم حساب العميل : ${snapshot.data!.userCustomer!.username!.toString()}"),
                                  Text(
                                      "اسم العميل : ${snapshot.data!.userCustomer!.fullName!.toString()}"),
                                  Text(
                                      "ايميل العميل : ${snapshot.data!.userCustomer!.email!.toString()}"),
                                  Text(
                                      "رقم العميل : ${snapshot.data!.userCustomer!.phone!.toString()}"),
                                  Text(
                                    "المبلغ الذي تم ايداعه : ${snapshot.data!.treansaction!.amount!.toString()}",
                                  ),
                                  Text(snapshot.data!.treansaction!.status!
                                      ? ' حالة العملية : تم التأكيد'
                                      : " حالة العملية : لم يتم التأكيد"),
                                  Text('''رقم حساب العميل : 
                                      ${snapshot.data!.walletCustomer!.code!.toString()}'''),
                                  Text(
                                      "المبلغ الذي في محفظته : ${snapshot.data!.walletCustomer!.balance!.toString()}"),
                                  Text(
                                      "نوع العملية : ${snapshot.data!.transactionType!.name!.toString()}"),
                                  Text(
                                      "المبلغ الذي في محفظته : ${snapshot.data!.walletBranch!.balance!.toString()}"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      snapshot.data!.userBranch!.image
                                          .toString(),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      snapshot.data!.userBooking!.image
                                          .toString(),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      snapshot.data!.userCars!.image.toString(),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      snapshot.data!.userCustomer!.image
                                          .toString(),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
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
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
