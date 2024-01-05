import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/ViewModels/PrandVM.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/SignupPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/AddCars.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/AddCarsByUserAndBrand.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/customerpage/HomeCustomerPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/customerpage/ViewCarsCustomer.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyTextFormField.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewPrandPage extends StatefulWidget {
  const ViewPrandPage({super.key});

  @override
  State<ViewPrandPage> createState() => _ViewPrandPageState();
}

class _ViewPrandPageState extends State<ViewPrandPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserVM>(context);

    final prandProvider = Provider.of<PrandVM>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                                final x = await userProvider.logout();
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
          title: Center(child: Text("الصفحة الماركات")),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: Form(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 130,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FutureBuilder(
                        future: prandProvider.getAllPrandsFromAPi(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return GridView.builder(
                              clipBehavior: Clip.none,
                              itemCount: snapshot.data!.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.75,
                                      crossAxisSpacing: 40,
                                      mainAxisSpacing: 40,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: InkWell(
                                    onTap: () {
                                      final box = GetStorage();
                                      box.write('prand_id_branch',
                                          snapshot.data![index].id);
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          var x = box.read('role_user');
                                          if (x == 'branch') {
                                            return AddCarScrrens();
                                          } else {
                                            return ViewCarsCustomer();
                                          }
                                        },
                                      ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 54, 140, 75),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            left: 100,
                                            top: 14,
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: colorprimarywhite,
                                                )),
                                          ),
                                          Positioned(
                                            top: 35,
                                            left: 20,
                                            child: SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: Image.network(
                                                snapshot.data![index].path!,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 15,
                                            left: 40,
                                            child: Wrap(
                                              children: [
                                                Text(
                                                    snapshot.data![index].name!,
                                                    style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      color: colorprimarywhite,
                                                      fontSize: 20,
                                                    )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        }),
                  ),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height,
                //   width: MediaQuery.of(context).size.width,
                //   child: FutureBuilder(
                //     future: prandProvider.getAllPrandsFromAPi(),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         if (snapshot.data!.isEmpty) {
                //           return Text("Empty");
                //         }
                //         return ListView.builder(
                //           itemCount: snapshot.data!.length,
                //           itemBuilder: (context, index) {
                //             return Column(
                //               children: [
                //                 SizedBox(
                //                   height: 300,
                //                   width: 200,
                //                   child: InkWell(
                //                     onTap: () {
                //                       Navigator.push(context, MaterialPageRoute(
                //                         builder: (context) {
                //                           final box = GetStorage();
                //                           box.write('prand_id_forAddCar',
                //                               snapshot.data![index].id!);
                //                           print(box.read('prand_id_forAddCar'));

                //                           return AddCarsByUserAndBrand();
                //                         },
                //                       ));
                //                     },
                //                     child: Image.network(
                //                         snapshot.data![index].path!,
                //                         scale: 1.0),
                //                   ),
                //                 ),
                //                 Text("${snapshot.data![index].name}"),
                //               ],
                //             );
                //           },
                //         );
                //       }
                //       return Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     },
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
