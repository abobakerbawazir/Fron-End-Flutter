import 'package:booking_car_project_flutter/features/Views/Screnns/HomePageScreen.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/Login_Page_Ui.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/SignupPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/awasome_dialog_page.dart';
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
    return role_user == "admin"
        ? SignupPage()
        : role_user == "Customer"
            ? HomePageScreen()
            : HomePage();
  }
}
