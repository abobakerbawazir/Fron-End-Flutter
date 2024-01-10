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

class HoemCustomerPage extends StatefulWidget {
  const HoemCustomerPage({super.key});

  @override
  State<HoemCustomerPage> createState() => _HoemCustomerPageState();
}

class _HoemCustomerPageState extends State<HoemCustomerPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserVM>(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final x =
        'محل الاسطورة لزينة السيارات   الحديثة والقديمة والمستعملة وكل ماتريد ياصديقي';
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // appBar: AppBar(
        //   actions: [
        //     Row(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         IconButton(
        //             onPressed: () async {
        //               await showDialog(
        //                 context: context,
        //                 builder: (context) {
        //                   return AlertDialog(
        //                     content: Text("back from Home Page"),
        //                     title: Text("Are you sure"),
        //                     actions: [
        //                       ElevatedButton(
        //                           onPressed: () async {
        //                             userProvider.logout();
        //                             final prefs =
        //                                 await SharedPreferences.getInstance();
        //                             prefs.setBool('token', false);
        //                             Navigator.pushReplacement(context,
        //                                 MaterialPageRoute(
        //                               builder: (context) {
        //                                 return SignupPage();
        //                               },
        //                             ));
        //                           },
        //                           child: Text("OK")),
        //                       ElevatedButton(
        //                           onPressed: () {
        //                             Navigator.pop(context);
        //                           },
        //                           child: Text("Cancel"))
        //                     ],
        //                   );
        //                 },
        //               );
        //             },
        //             icon: Icon(Icons.logout)),
        //         SizedBox(
        //           width: 14,
        //         ),
        //         Text(' صفحة العملاء الرئيسية ', style: TextStyle(fontSize: 20)),
        //         SizedBox(
        //           width: 22,
        //         ),
        //         TextButton(
        //             onPressed: () {
        //               setState(() {});
        //             },
        //             child: Text(
        //               "تحديث",
        //               style: TextStyle(color: colorprimarywhite),
        //             )),
        //         SizedBox(
        //           width: 6,
        //         )
        //       ],
        //     ),
        //   ],
        //   backgroundColor: colorprimarygreen,
        // ),

        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 150,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                    future: userProvider.getAllBranchesActiveOrAllUserFromAPi(
                        url: APIurl.viewAllBranchActive),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return Center(child: Text("Empty"));
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            // List<Profile> profiles = snapshot.data!;
                            // for (Profile profile in profiles) {
                            //   Widget profileWidget;
                            //   if (profile.fullName!.length > 5) {
                            //     List<String> parts = [];
                            //     int i = 0;
                            //     while (i < profile.fullName!.length) {
                            //       int endI = i + 5;
                            //       if (endI > profile.fullName!.length) {
                            //         String part =
                            //             profile.fullName!.substring(i, endI);
                            //         parts.add(part);
                            //         i = endI;
                            //       }
                            //       String formattedFullName = parts.join('\n');
                            //       profileWidget = Column(
                            //         children: [
                            //           Text(profile.fullName!),
                            //           Text(formattedFullName),
                            //         ],
                            //       );
                            //     }
                            //   } else {
                            //     profileWidget = Column(
                            //       children: [Text(profile.fullName!)],
                            //     );
                            //   }
                            //}
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
                                                  child: Text(
                                                      " : ${snapshot.data![index].phone!}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15)),
                                                ),
                                                Positioned(
                                                    // right: 30,
                                                    top: 230,
                                                    child: Icon(Icons.phone)),
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
                                                  child: Text(
                                                      " : ${snapshot.data![index].email!}",
                                                      style: TextStyle(
                                                          fontSize: 17)),
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
