import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/features/Models/Transaction/TransactionHistoreyDiposit.dart';
import 'package:booking_car_project_flutter/features/ViewModels/TransactionVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/Mony/GetInfoAllTransactionHistoryToTransferPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/Mony/ManageAllTransactionPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/Mony/ManageDipositPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/Mony/MangeWithdrawPage.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageMonyScreens extends StatefulWidget {
  const ManageMonyScreens({super.key});

  @override
  State<ManageMonyScreens> createState() => _ManageMonyScreensState();
}

class _ManageMonyScreensState extends State<ManageMonyScreens> {
  List<String> nameTransations = ['الكل', 'السحب', 'التحويل', 'الايداع'];
  String selectedName = 'الكل';
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final transactionProvider = Provider.of<TransactionVM>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(
                child: Column(
              children: [
                Center(
                    child: Text(
                  "ادارة الاموال",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
                Container(
                  decoration: BoxDecoration(
                      color: colorprimarygrey,
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
                                    color:
                                        selectedName == nameTransations[index]
                                            ? Color.fromARGB(255, 5, 19, 215)
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
                        child: ManageDipositPage(),
                      )
                    : selectedName == 'السحب'
                        ? SizedBox(
                            height: h - 224,
                            width: w,
                            child: MangeWithdrawPage(),
                          )
                        : selectedName == 'التحويل'
                            ? SizedBox(
                                height: h - 224,
                                width: w,
                                child:
                                    GetInfoAllTransactionHistoryToTransferPage())
                            : SizedBox(
                                height: h - 224,
                                width: w,
                                child: ManageAllTransactionPage())
              ],
            )),
          ),
        ),
      ),
    );
  }
}
