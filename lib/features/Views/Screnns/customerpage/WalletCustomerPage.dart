import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/features/Models/Transaction/TransactionHistoreyDiposit.dart';
import 'package:booking_car_project_flutter/features/ViewModels/TransactionVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/Mony/GetInfoAllTransactionHistoryToTransferPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/Mony/ManageAllTransactionPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/Mony/ManageDipositPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/Mony/MangeWithdrawPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/customerpage/monyCustomer.dart/Allcustomerwallet.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/customerpage/monyCustomer.dart/TransferCustomerPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/customerpage/monyCustomer.dart/dipsitOfCustomerpage.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class WalletCustomerPage extends StatefulWidget {
  const WalletCustomerPage({super.key});

  @override
  State<WalletCustomerPage> createState() => _WalletCustomerPageState();
}

class _WalletCustomerPageState extends State<WalletCustomerPage> {
  final box = GetStorage();
  List<String> nameTransations = ['الكل', 'الدفع', 'الايداع'];
  String selectedName = 'الكل';
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
              Center(
                  child: Text(
                "محفظتي",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              Container(
                decoration: BoxDecoration(
                    color: colorprimaryA1,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        nameTransations.length,
                        (index) => InkWell(
                              onTap: () {
                                selectedName = nameTransations[index];
                                transactionProvider.notifyListeners();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: selectedName == nameTransations[index]
                                      ? Color.fromARGB(255, 3, 59, 79)
                                      : Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    nameTransations[index],
                                    style: TextStyle(
                                        color: selectedName ==
                                                nameTransations[index]
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )),
                  ),
                ),
              ),
              selectedName == 'الايداع'
                  ? SizedBox(
                      height: h - 224,
                      width: w,
                      child: DipostitOfCustomerPage(),
                    )
                  : selectedName == 'الدفع'
                      ? SizedBox(
                          height: h - 224,
                          width: w,
                          child: TransferCustomerPage())
                      : SizedBox(
                          height: h - 224,
                          width: w,
                          child: AllcustomerwalletPage())
            ],
          )),
        ),
      ),
    );
  }
}
