import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/LoginPage.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyTextFormField.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController usernameTxt = TextEditingController();
  TextEditingController phoneTxt = TextEditingController();
  TextEditingController full_nameTxt = TextEditingController();
  TextEditingController user_typeTxt = TextEditingController();
  TextEditingController emailTxt = TextEditingController();
  TextEditingController passwordTxt = TextEditingController();
  TextEditingController password_confirmationTxt = TextEditingController();
  bool is_Active = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserVM>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1.5,
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    child: Container(
                        height: MediaQuery.of(context).size.height / 2.5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              opacity: 0.7,
                              image: AssetImage(
                                  "assets/images/2021_4_16_14_20_38_182.jpg"),
                              fit: BoxFit.cover),
                          color: Colors.black,
                        )),
                  ),
                  Positioned(
                      left: 30,
                      top: 110,
                      child: Text(
                        "انشاء حساب",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorprimarywhite,
                            fontSize: 60),
                      )),
                  Positioned(
                    top: 300,
                    child: Container(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(children: [
                              MyTextFormField(
                                hintText: "اسم المستخدم",
                                controller: usernameTxt,
                                suffixIcon: Icon(
                                  Icons.person,
                                  color: colorprimarygreen,
                                ),
                              ),
                              MyTextFormField(
                                hintText: "رقم الهاتف",
                                controller: phoneTxt,
                                suffixIcon: Icon(
                                  Icons.phone,
                                  color: colorprimarygreen,
                                ),
                              ),
                              MyTextFormField(
                                hintText: "الاسم الكامل",
                                controller: full_nameTxt,
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: colorprimarygreen,
                                ),
                              ),
                              MyTextFormField(
                                hintText: "الايميل",
                                controller: emailTxt,
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: colorprimarygreen,
                                ),
                              ),
                              MyTextFormField(
                                obscureText: userProvider.iconObsecure2,
                                hintText: "كلمة المرور",
                                controller: passwordTxt,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    userProvider.changeIconStateSignUp2();
                                  },
                                  icon: Icon(
                                      color: colorprimarygreen,
                                      userProvider.iconObsecure2 == false
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                ),
                              ),
                              MyTextFormField(
                                obscureText: userProvider.iconObsecure3,
                                hintText: "تاكيد كلمة المرور",
                                controller: password_confirmationTxt,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    userProvider.changeIconStateSignUp3();
                                  },
                                  icon: Icon(
                                      color: colorprimarygreen,
                                      userProvider.iconObsecure3 == false
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "التسجيل كفرع جديد",
                                    style: TextStyle(
                                        color: colorprimarygreen,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (is_Active == false) {
                                          is_Active = true;
                                        } else {
                                          is_Active = false;
                                        }
                                        setState(() {});
                                      },
                                      icon: is_Active == false
                                          ? Icon(
                                              size: 35,
                                              Icons
                                                  .check_box_outline_blank_sharp,
                                              color: colorprimarygreen,
                                            )
                                          : Icon(
                                              Icons.check_box,
                                              color: colorprimarygreen,
                                              size: 35,
                                            ))
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              AnimatedButton(
                                  text: "أصافة حساب جديد",
                                  color: colorprimarygreen,
                                  pressEvent: () async {
                                    await userProvider.signUP(
                                        context: context,
                                        username: usernameTxt.text,
                                        email: emailTxt.text,
                                        full_name: full_nameTxt.text,
                                        phone: phoneTxt.text,
                                        user_type:
                                            is_Active ? 'branch' : "customer",
                                        role: is_Active ? 'branch' : "customer",
                                        password: passwordTxt.text,
                                        password_confirmation:
                                            password_confirmationTxt.text);
                                  }),
                              SizedBox(
                                height: 35,
                              ),
                              AnimatedButton(
                                color: colorprimarygreen,
                                text: "الانتقال لصفحة تسجيل الدخول",
                                pressEvent: () {
                                  print("dsdfgh");
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return LoginPage();
                                    },
                                  ));
                                },
                              ),
                            ])),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 1.5,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20)))),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1.5,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
