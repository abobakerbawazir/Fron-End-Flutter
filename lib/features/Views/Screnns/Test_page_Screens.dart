import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/AddBrandPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/MangeUserScreens.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/HomePageScreen.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/Login_Page_Ui.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/SignupPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/awasome_dialog_page.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/AddCars.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/BranchPageIsNotActive.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/ViewBrandPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/customerpage/HomeCustomerPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Test_page_Screens extends StatefulWidget {
  const Test_page_Screens({super.key});

  @override
  State<Test_page_Screens> createState() => _Test_page_ScreensState();
}

class _Test_page_ScreensState extends State<Test_page_Screens> {
  final box = GetStorage();

  String role_type = "admfin";
  @override
  Widget build(BuildContext context) {
    final token = box.read('token_login');
    final userId = box.read('user_id');
    final role_user = box.read('role_user');
    final active_user = box.read('active_user');
    return role_user == "admin"
        ? HomePageScreen()
        : role_user == "customer"
            ? HoemCustomerPage()
            : role_user == 'branch' && active_user == 1
                ? ViewPrandPage()
                : BranchpageIsNotActive();
  }
}
