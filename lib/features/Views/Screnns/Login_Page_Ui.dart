import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/core/Helpers/Messge.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/Test_page_Screens.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/DialogMessage.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyTextFormField.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/awasome_dialog_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialog_shower/flutter_dialog_shower.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class Login_Page_Ui extends StatefulWidget {
  const Login_Page_Ui({super.key});

  @override
  State<Login_Page_Ui> createState() => _Login_Page_UiState();
}

class _Login_Page_UiState extends State<Login_Page_Ui> {
  TextEditingController emailTxt = TextEditingController();
  TextEditingController passwordTxt = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final localt = AppLocalizations.of(context);
    final userProvider = Provider.of<UserVM>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        2.5,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          opacity: 0.7,
                                          image:
                                              AssetImage("assets/Cars/2.png"),
                                          fit: BoxFit.cover),
                                      color: Colors.black,
                                    )),
                              ),
                              Positioned(
                                  left: 35,
                                  top: 130,
                                  child: Text(
                                    "صفحة تسجيل الدخول",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colorprimarywhite,
                                        fontSize: 30),
                                  )),
                              Positioned(
                                top: 300,
                                child: Container(
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(children: [
                                          MyTextFormField(
                                            hintText: "الايميل",
                                            controller: emailTxt,
                                            suffixIcon: Icon(
                                              Icons.email,
                                              color: colorprimarygrey,
                                            ),
                                          ),
                                          MyTextFormField(
                                              obscureText:
                                                  userProvider.iconObsecure,
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  userProvider
                                                      .changeIconStateLogin();
                                                },
                                                icon: Icon(
                                                    color: colorprimarygrey,
                                                    userProvider.iconObsecure ==
                                                            false
                                                        ? Icons.visibility
                                                        : Icons.visibility_off),
                                              ),
                                              hintText: "كلمة المرور",
                                              controller: passwordTxt),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          AnimatedButton(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                40,
                                            text: 'تسجيل الدخول',
                                            color: colorprimarygreen,
                                            pressEvent: () async {
                                              isLoading = true;
                                              Future.delayed(
                                                Duration(seconds: 3),
                                                () {
                                                  isLoading = false;
                                                  setState(() {});
                                                },
                                              );
                                              final code =
                                                  await userProvider.login(
                                                context: context,
                                                email: emailTxt.text,
                                                password: passwordTxt.text,
                                              );

                                              print(code);
                                              //isLoading = false;
                                              if (code == 200) {
                                                final prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                prefs.setBool('token', true);
                                                if (isLoading == false) {
                                                  await AwesomeDialog(
                                                    context: context,
                                                    animType:
                                                        AnimType.leftSlide,
                                                    headerAnimationLoop: false,
                                                    dialogType:
                                                        DialogType.success,
                                                    showCloseIcon: true,
                                                    title:
                                                        messageLoginInTitleSeccues,
                                                    desc: "",
                                                    btnOkOnPress: () {
                                                      debugPrint('OnClcik');
                                                    },
                                                    btnOkIcon:
                                                        Icons.check_circle,
                                                  ).show();
                                                }
                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                  builder: (context) {
                                                    return Test_page_Screens();
                                                  },
                                                ));
                                              }
                                              ;
                                            },
                                          ),
                                        ])),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: const BoxDecoration(
                                        // image: DecorationImage(
                                        //     opacity: 0.5,
                                        //     image: AssetImage(
                                        //         "assets/images/Tropical- Seascapes_117.jpg"),
                                        //     fit: BoxFit.cover),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20)))),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
      ),
    );
  }
}
