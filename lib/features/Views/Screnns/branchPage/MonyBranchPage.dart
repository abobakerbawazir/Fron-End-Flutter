import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/features/Models/Transaction/TransactionHistoreyDiposit.dart';
import 'package:booking_car_project_flutter/features/ViewModels/TransactionVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/Mony/GetInfoAllTransactionHistoryToTransferPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/Mony/ManageAllTransactionPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/Mony/ManageDipositPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/Mony/MangeWithdrawPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/MonyBranch/AllTransactionBranchPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/MonyBranch/TransaferBranchPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/MonyBranch/WithdrawBranchPage.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class MonyBranchPage extends StatefulWidget {
  const MonyBranchPage({super.key});

  @override
  State<MonyBranchPage> createState() => _MonyBranchPageState();
}

class _MonyBranchPageState extends State<MonyBranchPage> {
  List<String> nameTransations = ['الكل', 'السحب', 'التحويل'];
  String selectedName = 'الكل';
  final box = GetStorage();

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
                                color: selectedName == nameTransations[index]
                                    ? Color.fromARGB(255, 5, 19, 215)
                                    : Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  nameTransations[index],
                                  style: TextStyle(
                                      color:
                                          selectedName == nameTransations[index]
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
            selectedName == 'السحب'
                ? SizedBox(
                    height: h - 224,
                    width: w,
                    child: WithdrawBranchPage(),
                  )
                : selectedName == 'التحويل'
                    ? SizedBox(
                        height: h - 224, width: w, child: TransaferBranchPage())
                    : SizedBox(
                        height: h - 224,
                        width: w,
                        child: AllTransactionBranchPage())
          ],
        )),
      ),
    );
  }
}
