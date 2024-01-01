import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/SignupPage.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BranchpageIsNotActive extends StatefulWidget {
  const BranchpageIsNotActive({super.key});

  @override
  State<BranchpageIsNotActive> createState() => _BranchpageIsNotActiveState();
}

class _BranchpageIsNotActiveState extends State<BranchpageIsNotActive> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserVM>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text("back from Home Page"),
                      title: Text("Are you sure"),
                      actions: [
                        ElevatedButton(
                            onPressed: () async {
                              userProvider.logout();
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('token', false);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return SignupPage();
                                },
                              ));
                            },
                            child: Text("OK")),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"))
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.logout)),
        ],
        backgroundColor: colorprimarygreen,
        title: Center(child: Text("الصفحة الفرع")),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Image.asset('assets/images/home.png'),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 41, 126, 44)),
                child: Text(
                  "الحساب غير مفعل الرجاء الانتضار حتى يتم تفعيل الحساب",
                  style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: colorprimarywhite),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
