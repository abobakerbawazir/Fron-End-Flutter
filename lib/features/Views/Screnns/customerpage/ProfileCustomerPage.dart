import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/SignUpPageWithImage.dart';
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
    final walletCode = box.read('walletCode');
    final walletId = box.read('walletId');

    final full_name = box.read('full_name');
    final email = box.read('email');
    final phone = box.read('phone');
    final image = box.read('image');
    final location = box.read('location');

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 223, 218, 218)),
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 207, 203, 203),
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text("اسم المستخدم",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(username ?? "Abobaker2020aa",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text("كود المحفظة",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(walletCode ?? "ليس لديك محفظة",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("الرصيد : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              FutureBuilder(
                                future: userProvider.getBalanceByIDWallet(
                                    id: walletId),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          "${snapshot.data!.balance!.toString()} RY" ??
                                              "لايوجد",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    );
                                  }
                                  return Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('في انتضار الانترنت',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Center(
                                          child: CircularProgressIndicator()),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 150,
                        width: w,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 12,
                            ),
                            image == null
                                ? Expanded(
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                          'assets/images/user-profile-icon-front-side.jpg'),
                                    ),
                                  )
                                : Expanded(
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(image),
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
                                    child: Text(
                                        "الموقع : ${location}" ?? "7756301"))
                              ],
                            )
                          ],
                        ))
                  ],
                ),
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
                Name_icon: Icons.accessibility_new_sharp,
                title: "حول التطبيق",
                pageNameRoute: "v"),
            ListTile_me(
                Name_icon: Icons.contact_support_rounded,
                title: "من نحن",
                pageNameRoute: "v"),
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
                                if (x[0] == 'تم تسجيل الخروج بنجاح') {
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
                                      return SignUpPageWithImage();
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
                Name_icon: Icons.logout,
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
