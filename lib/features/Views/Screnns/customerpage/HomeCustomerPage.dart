import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/features/Models/Users/Profile.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/SignupPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/ViewBrandPage.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HoemCustomerPage extends StatefulWidget {
  const HoemCustomerPage({super.key});

  @override
  State<HoemCustomerPage> createState() => _HoemCustomerPageState();
}

class _HoemCustomerPageState extends State<HoemCustomerPage> {
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserVM>(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Container(
                    width: w - 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 209, 221, 227)),
                    child: Center(
                        child: Text(
                      "يرجى أختيار احد المعارض",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ))),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 209, 221, 227)),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              userProvider.notifyListeners();
                            },
                            icon: Icon(Icons.search)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 1.6,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 209, 221, 227)),
                              child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "ابحث هنا"),
                                    controller: _titleController,
                                    onChanged: (value) {
                                      print(_titleController.text);
                                      if (_titleController.text == '') {
                                        userProvider.notifyListeners();
                                      }
                                    },
                                  )),
                            )),
                        IconButton(
                            onPressed: () {
                              _titleController.clear();
                              userProvider.clearControlle(_titleController);
                            },
                            icon: Icon(Icons.clear))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).size.height / 3.4),
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                    future:
                        userProvider.getAllBranchesActiveOrAllUserFromAPiSearch(
                            fultterName: _titleController.text,
                            url: APIurl.viewAllBranchActiveSearch +
                                _titleController.text),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return Center(child: Text("لاتوجد نتائج للبحث"));
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return snapshot.data![index].roles == 'branch'
                                ? InkWell(
                                    onTap: () {
                                      final box = GetStorage();
                                      box.write('id_user_branch',
                                          snapshot.data![index].id);
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return ViewPrandPage();
                                        },
                                      ));
                                    },
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 209, 221, 224),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
                                                        // color: Colors.grey,
                                                        ),
                                                    width: 300,
                                                    height: 150,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      //clipBehavior: Clip.antiAlias,
                                                      child: Image.network(
                                                        snapshot.data![index]
                                                            .image!,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 30,
                                                  top: 230,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      final Uri url = Uri(
                                                          scheme: 'tel',
                                                          path:
                                                              '${snapshot.data![index].phone!}');
                                                      if (await canLaunchUrl(
                                                          url)) {
                                                        await launchUrl(url);
                                                      } else {
                                                        print(
                                                            'can not launch this url');
                                                      }
                                                    },
                                                    child: Text(
                                                        " : ${snapshot.data![index].phone!}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15)),
                                                  ),
                                                ),
                                                Positioned(
                                                    // right: 30,
                                                    top: 230,
                                                    child: InkWell(
                                                        onTap: () async {
                                                          final Uri url = Uri(
                                                              scheme: 'tel',
                                                              path:
                                                                  '${snapshot.data![index].phone!}');
                                                          if (await canLaunchUrl(
                                                              url)) {
                                                            await launchUrl(
                                                                url);
                                                          } else {
                                                            print(
                                                                'can not launch this url');
                                                          }
                                                        },
                                                        child:
                                                            Icon(Icons.phone))),
                                                Positioned(
                                                  right: 0,
                                                  top: 165,
                                                  child: Text('الفرع : ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15)),
                                                ),
                                                Positioned(
                                                  top: 165,
                                                  right: 55,
                                                  child: Text(
                                                      "${snapshot.data![index].fullName!}",
                                                      style: TextStyle(
                                                          fontSize: 17)),
                                                ),
                                                Positioned(
                                                    top: 195,
                                                    child: Icon(
                                                        Icons.location_on)),
                                                Positioned(
                                                  top: 197,
                                                  right: 30,
                                                  child: Text(
                                                      " : ${snapshot.data![index].location!}",
                                                      style: TextStyle(
                                                          fontSize: 17)),
                                                ),
                                                Positioned(
                                                    top: 260,
                                                    child: Icon(Icons.email)),
                                                Positioned(
                                                  top: 260,
                                                  right: 30,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      String?
                                                          encodeQueryParameters(
                                                              Map<String,
                                                                      String>
                                                                  params) {
                                                        return params.entries
                                                            .map((MapEntry<
                                                                        String,
                                                                        String>
                                                                    e) =>
                                                                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                                            .join('&');
                                                      }

// ···
                                                      final Uri emailLaunchUri =
                                                          Uri(
                                                        scheme: 'mailto',
                                                        path:
                                                            '${snapshot.data![index].email!}',
                                                        query:
                                                            encodeQueryParameters(<String,
                                                                String>{
                                                          'subject':
                                                              'مرحبا ${snapshot.data![index].fullName}',
                                                        }),
                                                      );

                                                      launchUrl(emailLaunchUri);
                                                    },
                                                    child: Text(
                                                        " : ${snapshot.data![index].email!}",
                                                        style: TextStyle(
                                                            fontSize: 17)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container();
                          },
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "جاري التحميل",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Center(child: CircularProgressIndicator()),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
