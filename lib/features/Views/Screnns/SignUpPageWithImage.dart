import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/LoginPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/Login_Page_Ui.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyTextFormField.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUpPageWithImage extends StatefulWidget {
  const SignUpPageWithImage({super.key});

  @override
  State<SignUpPageWithImage> createState() => _SignUpPageWithImageState();
}

class _SignUpPageWithImageState extends State<SignUpPageWithImage> {
  TextEditingController usernameTxt = TextEditingController();
  TextEditingController phoneTxt = TextEditingController();
  TextEditingController full_nameTxt = TextEditingController();
  TextEditingController user_typeTxt = TextEditingController();
  TextEditingController emailTxt = TextEditingController();
  TextEditingController passwordTxt = TextEditingController();
  TextEditingController password_confirmationTxt = TextEditingController();
  bool is_Active = false;
  final ImagePicker _picker = ImagePicker();
  XFile? PickedFile;
  List<int> imageBytes = [];

  pickImageDio({required FormData formData}) async {
    print(APIurl.baseUrl + 'addUserAndAddImage');
    Dio dio = DioSingelton.getInstance();
    Response response =
        await dio.post(APIurl.baseUrl + 'addUserAndAddImage', data: formData);
    var x = response.data;
    print(x);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserVM>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                                image: AssetImage("assets/Cars/2.png"),
                                fit: BoxFit.cover),
                            color: Colors.black,
                          )),
                    ),
                    Positioned(
                        left: 30,
                        top: 110,
                        child: Text(
                          "إنشاء حساب",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorprimarywhite,
                              fontSize: 50),
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
                                    color: colorprimarygrey,
                                  ),
                                ),
                                MyTextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.number,
                                  hintText: "رقم الهاتف",
                                  controller: phoneTxt,
                                  suffixIcon: Icon(
                                    Icons.phone,
                                    color: colorprimarygrey,
                                  ),
                                ),
                                MyTextFormField(
                                  hintText: "الاسم الكامل",
                                  controller: full_nameTxt,
                                  suffixIcon: Icon(
                                    Icons.person,
                                    color: colorprimarygrey,
                                  ),
                                ),
                                MyTextFormField(
                                  hintText: "الايميل",
                                  controller: emailTxt,
                                  suffixIcon: Icon(
                                    Icons.email,
                                    color: colorprimarygrey,
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
                                        color: colorprimarygrey,
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
                                        color: colorprimarygrey,
                                        userProvider.iconObsecure3 == false
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "التسجيل كفرع جديد",
                                      style: TextStyle(
                                          color: colorprimarygreen,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 2,
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
                                                size: 30,
                                                Icons
                                                    .check_box_outline_blank_sharp,
                                                color: colorprimarygreen,
                                              )
                                            : Icon(
                                                Icons.check_box,
                                                color: colorprimarygreen,
                                                size: 35,
                                              )),
                                    SizedBox(
                                      width: 20,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            actions: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: IconButton(
                                                    onPressed: () async {
                                                      PickedFile = await _picker
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);
                                                      imageBytes =
                                                          await PickedFile!
                                                              .readAsBytes();
                                                      userProvider
                                                          .notifyListeners();
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(
                                                      Icons.photo,
                                                      size: 50,
                                                    )),
                                              ),
                                              Text("           "),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: IconButton(
                                                    onPressed: () async {
                                                      PickedFile = await _picker
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .camera);
                                                      imageBytes =
                                                          await PickedFile!
                                                              .readAsBytes();
                                                      userProvider
                                                          .notifyListeners();
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(
                                                      Icons.camera_alt,
                                                      size: 50,
                                                    )),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text("اضافة صورة"),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Icon(Icons.photo)
                                      ],
                                    ),
                                  ),
                                ),
                                // ElevatedButton(
                                //     onPressed: () async {
                                //       PickedFile = await _picker.pickImage(
                                //           source: ImageSource.gallery);
                                //       imageBytes =
                                //           await PickedFile!.readAsBytes();
                                //       setState(() {});
                                //     },
                                //     child: Text("add image")),

                                PickedFile != null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: 200,
                                              height: 200,
                                              child: Image.file(
                                                  File(PickedFile!.path))),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                PickedFile = null;
                                                userProvider.notifyListeners();
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("حذف الصورة"),
                                                  Icon(Icons.cancel)
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : Container(),
                                // ElevatedButton(
                                //     onPressed: () async {
                                //       print(imageBytes);
                                //       FormData formData =
                                //           await FormData.fromMap({
                                //         'username': usernameTxt.text,
                                //         'email': emailTxt.text,
                                //         'full_name': full_nameTxt.text,
                                //         'phone': phoneTxt.text,
                                //         'user_type':
                                //             is_Active ? 'branch' : "customer",
                                //         'role':
                                //             is_Active ? 'branch' : "customer",
                                //         'active': true,
                                //         'password': passwordTxt.text,
                                //         'password_confirmation':
                                //             password_confirmationTxt.text,
                                //         'image_path': MultipartFile.fromBytes(
                                //             imageBytes,
                                //             filename:
                                //                 "image_path.${PickedFile?.path.split('.').last}")
                                //       });
                                //       pickImageDio(formData: formData);
                                //     },
                                //     child: Text("save")),

                                SizedBox(
                                  height: 10,
                                ),
                                AnimatedButton(
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                    text: "أضافة حساب جديد",
                                    color: colorprimarygreen,
                                    pressEvent: () async {
                                      if (PickedFile != null) {
                                        print(imageBytes);
                                        FormData formData =
                                            await FormData.fromMap({
                                          'username': usernameTxt.text,
                                          'email': emailTxt.text,
                                          'full_name': full_nameTxt.text,
                                          'phone': phoneTxt.text,
                                          'user_type':
                                              is_Active ? 'branch' : "customer",
                                          'role':
                                              is_Active ? 'branch' : "customer",
                                          'active': true,
                                          'password': passwordTxt.text,
                                          'password_confirmation':
                                              password_confirmationTxt.text,
                                          'image_path': MultipartFile.fromBytes(
                                              imageBytes,
                                              filename:
                                                  "image_path.${PickedFile?.path.split('.').last}")
                                        });
                                        final x =
                                            await userProvider.SignUpWithImage(
                                                formData: formData,
                                                context: context);
                                        print(x);
                                        if (x == 400) {
                                          Future.delayed(
                                            Duration(seconds: 5),
                                            () {
                                              print(x + 404);
                                            },
                                          );
                                        } else if (x == 200) {
                                          Future.delayed(
                                            Duration(seconds: 5),
                                            () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return Login_Page_Ui();
                                                },
                                              ));
                                            },
                                          );
                                        }
                                        //pickImageDio(formData: formData);
                                      } else {
                                        final x = await userProvider.signUP(
                                            context: context,
                                            username: usernameTxt.text,
                                            email: emailTxt.text,
                                            full_name: full_nameTxt.text,
                                            phone: phoneTxt.text,
                                            user_type: is_Active
                                                ? 'branch'
                                                : "customer",
                                            roles: is_Active
                                                ? 'branch'
                                                : "customer",
                                            password: passwordTxt.text,
                                            password_confirmation:
                                                password_confirmationTxt.text);
                                        print(x);
                                        if (x == 400) {
                                          Future.delayed(
                                            Duration(seconds: 5),
                                            () {
                                              print(x + 404);
                                            },
                                          );
                                        } else if (x == 200) {
                                          Future.delayed(
                                            Duration(seconds: 5),
                                            () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return Login_Page_Ui();
                                                },
                                              ));
                                            },
                                          );
                                        }
                                      }
                                    }),
                                SizedBox(
                                  height: 14,
                                ),
                                AnimatedButton(
                                  width: MediaQuery.of(context).size.width - 40,
                                  color: colorprimarygreen,
                                  text: "الانتقال لصفحة تسجيل الدخول",
                                  pressEvent: () {
                                    print("dsdfgh");
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return Login_Page_Ui();
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
      ),
    );
  }
}
