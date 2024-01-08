import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/SignupPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/customerpage/editProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCustomerPage extends StatefulWidget {
  const ProfileCustomerPage({super.key});

  @override
  State<ProfileCustomerPage> createState() => _ProfileCustomerPageState();
}

class _ProfileCustomerPageState extends State<ProfileCustomerPage> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserVM>(context);
    final username = box.read('username');
    final full_name = box.read('full_name');
    final email = box.read('email');
    final phone = box.read('phone');
    final location = box.read('location');

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(username ?? "Abobaker2020aa",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 150,
                      width: w,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(
                                  'assets/images/2021_4_16_14_20_38_182.jpg'),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Expanded(
                                child: Text(
                                    "الاسم الكامل : ${full_name}" ??
                                        "Abobaker Bawazer",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ),
                              Expanded(
                                child: Text("الايميل : ${email}" ??
                                    "Abobaker@gmail.com"),
                              ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              Expanded(
                                  child: Text(
                                      "رقم الهاتف : ${phone}" ?? "7756301")),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              Expanded(
                                  child:
                                      Text("الموقع : ${location}" ?? "7756301"))
                            ],
                          )
                        ],
                      ))
                ],
              ),
            ),
            ListTile_me(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return EdtiProfileCoustomer();
                    },
                  ));
                },
                Name_icon: Icons.person,
                title: "ادراة حسابي",
                pageNameRoute: "v"),
            ListTile_me(
                Name_icon: Icons.person,
                title: "حول التطبيق",
                pageNameRoute: "v"),
            ListTile_me(
                Name_icon: Icons.person, title: "من نحن", pageNameRoute: "v"),
            ListTile_me(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text("هل حقا تريد تسحيل الخروج"),
                        title: Text("هل أنت متأكد"),
                        actions: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("غير موافق")),
                          ElevatedButton(
                              onPressed: () async {
                                final x = await userProvider.logout();
                                if(x[0]=='تم تسجيل الخروج بنجاح'){
                                  await AwesomeDialog(
                                  context: context,
                                  animType: AnimType.leftSlide,
                                  headerAnimationLoop: false,
                                  dialogType: DialogType.success,
                                  showCloseIcon: true,
                                  title: 'نجاح',
                                  desc: x[0],
                                  btnOkOnPress: () {
                                    debugPrint('OnClcik');
                                  },
                                  btnOkIcon: Icons.check_circle,
                                ).show();

                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool('token', false);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return SignupPage();
                                  },
                                ));
                                }
                                
                                  //   await userProvider.logout(context: context);
                                  // final prefs =
                                  //     await SharedPreferences.getInstance();
                                  // prefs.setBool('token', false);
                                  // Navigator.pushReplacement(context,
                                  //     MaterialPageRoute(
                                  //   builder: (context) {
                                  //     return SignupPage();
                                  //   },
                                  // ));
                                
                              },
                              child: Text("موافق")),
                        ],
                      );
                    },
                  );
                },
                Name_icon: Icons.person,
                title: "تسجيل الخروج",
                pageNameRoute: "v"),
            // ListTile_me(
            //     Name_icon: Icons.person,
            //     context: context,
            //     title: "ادراة حسابي",
            //     pageNameRoute: "v")
          ],
        ),
      ),
    );
  }
}

ListTile_me(
    {required IconData Name_icon,
    void Function()? onTap,
    required String title,
    required String pageNameRoute}) {
  return ListTile(
      leading: Icon(
        Name_icon,
      ),
      title: Text(
        title,
        style: const TextStyle(),
      ),
      onTap: onTap);
}
