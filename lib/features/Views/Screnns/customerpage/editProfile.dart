import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/Models/Users/Profile.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyElevatedButton.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyTextFormField.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EdtiProfileCoustomer extends StatefulWidget {
  const EdtiProfileCoustomer({super.key});

  @override
  State<EdtiProfileCoustomer> createState() => _EdtiProfileCoustomerState();
}

class _EdtiProfileCoustomerState extends State<EdtiProfileCoustomer> {
  TextEditingController emailTxt = TextEditingController();
  TextEditingController full_nameTxt = TextEditingController();
  TextEditingController passwordTxt = TextEditingController();
  TextEditingController confirmPasswordTxt = TextEditingController();
  TextEditingController phoneTxt = TextEditingController();
  bool iconObsecure1 = false;
  final ImagePicker _picker = ImagePicker();
  _pickImageDio({required int car_id, required ImageSource source}) async {
    print(APIurl.uploadImageImageCarUrl);
    XFile? PickedFile = await _picker.pickImage(source: source);
    List<int> imageBytes = await PickedFile!.readAsBytes();
    FormData formData = FormData.fromMap({
      'car_id': car_id,
      'image_path': MultipartFile.fromBytes(imageBytes,
          filename: "image_path.${PickedFile.path.split('.').last}")
    });
    Dio dio = DioSingelton.getInstance();
    Response response =
        await dio.post(APIurl.uploadImageImageCarUrl, data: formData);
    var x = response.data;
    print(x);
    return x;
  }

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserVM>(context);
    final image = box.read('image');

    final user_id = box.read('user_id');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 107, 104, 104),
          title: Text("تعديل الملف الشخصي"),
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Form(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          //borderRadius: BorderRadius.circular(500)
                        ),
                        //color: Colors.black,
                        padding: EdgeInsets.all(20),
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width,
                        child: image == null
                            ? CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/images/2021_4_16_14_20_36_447.jpg"),
                                minRadius: 15,
                              )
                            : CircleAvatar(
                                minRadius: 15,
                                backgroundImage: NetworkImage(image),
                              )),
                    Positioned(
                      top: 27,
                      right: 120,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    Positioned(
                      top: 29,
                      right: 123,
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      MyTextFormField(
                        hintText: "الاسم الكامل",
                        suffixIcon: Icon(Icons.person),
                        controller: full_nameTxt,
                      ),
                      MyTextFormField(
                        suffixIcon: Icon(Icons.email),
                        hintText: "الأيميل",
                        controller: emailTxt,
                      ),
                      MyTextFormField(
                        hintText: "كلمة المرور",
                        controller: passwordTxt,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {});
                            if (iconObsecure1 == false) {
                              iconObsecure1 = true;
                            } else {
                              iconObsecure1 = false;
                            }
                          },
                          icon: Icon(iconObsecure1 == false
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      MyTextFormField(
                        hintText: "تأكيد كلمة المرور",
                        controller: confirmPasswordTxt,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {});
                            if (iconObsecure1 == false) {
                              iconObsecure1 = true;
                            } else {
                              iconObsecure1 = false;
                            }
                          },
                          icon: Icon(iconObsecure1 == false
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      MyTextFormField(
                        suffixIcon: Icon(Icons.phone),
                        hintText: "رقم الهاتف",
                        controller: phoneTxt,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                Container(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: ElevatedButton(
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            animType: AnimType.rightSlide,
                            headerAnimationLoop: true,
                            title:
                                ' : هل حقا تريد تعديل معلومات حسابك ستكون معلومات جسابك حسب المعلومات الاتية',
                            desc: '''الايميل : ${emailTxt.text}
                            الاسم : ${full_nameTxt.text}
                            كلمة المرور : ${passwordTxt.text}
                            تاكيد كلمة المرور : ${confirmPasswordTxt.text}
                            رقم الهاتف : ${phoneTxt.text}''',
                            btnOkOnPress: () async {
                              await userProvider.updateProfile(
                                  user_id,
                                  Profile(
                                      email: emailTxt.text,
                                      fullName: full_nameTxt.text,
                                      password: passwordTxt.text,
                                      password_confirmation:
                                          confirmPasswordTxt.text,
                                      phone: phoneTxt.text));
                            },
                            btnCancelOnPress: () {},
                          ).show();
                        },
                        child: Center(
                            child: Text(
                          "حفظ التغيرات",
                          style: TextStyle(fontSize: 17),
                        ))),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
