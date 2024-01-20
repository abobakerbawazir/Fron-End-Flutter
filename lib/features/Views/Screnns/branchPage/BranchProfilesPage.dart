import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/SignUpPageWithImage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/SignupPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/customerpage/editProfile.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class BranchProfilesPage extends StatefulWidget {
  const BranchProfilesPage({super.key});

  @override
  State<BranchProfilesPage> createState() => _BranchProfilesPageState();
}

class _BranchProfilesPageState extends State<BranchProfilesPage> {
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
      body: SingleChildScrollView(
        child: Padding(
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
                                      child: Text(
                                          walletCode ?? "ليس لديك محفظة",
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
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
                          height: 300,
                          width: w,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Column(
                                children: [
                                  image == null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                              fit: BoxFit.fill,
                                              'assets/images/user-profile-icon-front-side.jpg'),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(image,
                                              fit: BoxFit.fill)),
                                ],
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 12,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                "رقم الهاتف : ${phone}" ??
                                                    "7756301")),
                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        Expanded(
                                            child: Text(
                                                "الموقع : ${location}" ??
                                                    "7756301"))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
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
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 700,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.cancel)),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "حول التطبيق",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: colorprimaryA1),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              child: Column(
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                            "تطبيق مكلا ستور لتأجير السيارات"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                            "نظام عمل التطبيق"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                            "يستطيع العميل حجز السياراة التي يريدها"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                            "في أي وقت شاء وكيف شاء"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          "يمكن للعميل من تصفح التطبيق وتصفح الماركات",
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                            "والسيارات وحجز السيارة التي يريدها"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Center(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Text(
                                                              "ويوفر التطبيق محفظة الكترونية خاصة"),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          "يقدر من ايداع امواله من اجل عملية حجز السيارات",
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  Name_icon: Icons.accessibility_new_sharp,
                  title: "حول التطبيق",
                  pageNameRoute: "v"),
              ListTile_me(
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 700,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.cancel)),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "مطور التطبيق",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colorprimaryA1),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Text(
                                                    "Zone تم الابتكار والتطوير بواسطة ")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Text(
                                                    "Zone : ماذا تعرف عن مؤسسة ")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Row(
                                              children: [
                                                Text(
                                                    "تعمل لتطوير تطبيقات الموبايل : "),
                                                Text("Zone مؤسسة")
                                              ],
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                child: Text(
                                                    "يمكنك التواصل مع المؤسسة")),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: h / 15,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: colorprimarygreen),
                                      child: InkWell(
                                        onTap: () async {
                                          final Uri url = Uri(
                                              scheme: 'sms',
                                              path: '+967775630183');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(url);
                                          } else {
                                            print('can not launch this url');
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.arrow_back_ios),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "المدير العام",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.call),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: h / 15,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: colorprimarygreen),
                                      child: InkWell(
                                        onTap: () async {
                                          final Uri url = Uri(
                                              scheme: 'sms',
                                              path: '+967777132088');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(url);
                                          } else {
                                            print('can not launch this url');
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.arrow_back_ios),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "الدعم الفني للتطبيق",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.call),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: h / 15,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: colorprimaryA1),
                                      child: InkWell(
                                        onTap: () async {
                                          String? encodeQueryParameters(
                                              Map<String, String> params) {
                                            return params.entries
                                                .map((MapEntry<String, String>
                                                        e) =>
                                                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                                .join('&');
                                          }

                                          // ···
                                          final Uri emailLaunchUri = Uri(
                                            scheme: 'mailto',
                                            path: 'bawazer2017aa@gmail.com',
                                            query:
                                                encodeQueryParameters(<String,
                                                    String>{
                                              'subject':
                                                  'مرحبا فريق الدعم الفني',
                                            }),
                                          );

                                          launchUrl(emailLaunchUri);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.arrow_back_ios),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "bawazer2017aa@gmail.com",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.email),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  Name_icon: Icons.contact_support_rounded,
                  title: "من نحن",
                  pageNameRoute: "v"),
              ListTile_me(
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 700,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.cancel)),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "الدعم الفني",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      child: Text(
                                          "يمكنك التواصل معنا عن طريق أحد الطرق التالية")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: h / 15,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: colorprimarygreen),
                                      child: InkWell(
                                        onTap: () async {
                                          final Uri url = Uri(
                                              scheme: 'sms',
                                              path: '+967775630183');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(url);
                                          } else {
                                            print('can not launch this url');
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.arrow_back_ios),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "خدمة العملاء واتساب",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.call),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: h / 15,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: colorprimarygreen),
                                      child: InkWell(
                                        onTap: () async {
                                          final Uri url = Uri(
                                              scheme: 'sms',
                                              path: '+967777132088');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(url);
                                          } else {
                                            print('can not launch this url');
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.arrow_back_ios),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "خدمة العملاء واتساب",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.call),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: h / 15,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: colorprimaryA1),
                                      child: InkWell(
                                        onTap: () async {
                                          String? encodeQueryParameters(
                                              Map<String, String> params) {
                                            return params.entries
                                                .map((MapEntry<String, String>
                                                        e) =>
                                                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                                .join('&');
                                          }

                                          // ···
                                          final Uri emailLaunchUri = Uri(
                                            scheme: 'mailto',
                                            path: 'bawazer2017aa@gmail.com',
                                            query:
                                                encodeQueryParameters(<String,
                                                    String>{
                                              'subject':
                                                  'مرحبا فريق الدعم الفني',
                                            }),
                                          );

                                          launchUrl(emailLaunchUri);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.arrow_back_ios),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "bawazer2017aa@gmail.com",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.email),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: h / 15,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: colorprimaryA1),
                                      child: InkWell(
                                        onTap: () async {
                                          final Uri url = Uri(
                                              scheme: 'tel', path: '05362318');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(url);
                                          } else {
                                            print('can not launch this url');
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.arrow_back_ios),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "05362318",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.phone),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: h / 15,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: colorprimaryA1),
                                      child: InkWell(
                                        onTap: () async {
                                          final Uri url = Uri(
                                              scheme: 'tel', path: '775630183');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(url);
                                          } else {
                                            print('can not launch this url');
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.arrow_back_ios),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "775630183",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.phone),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  Name_icon: Icons.content_copy,
                  title: "تواصل معنا",
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
