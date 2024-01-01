import 'dart:io';

import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/ViewModels/PrandVM.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyTextFormField.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ViewCarsCustomer extends StatefulWidget {
  const ViewCarsCustomer({super.key});

  @override
  State<ViewCarsCustomer> createState() => _ViewCarsCustomerState();
}

class _ViewCarsCustomerState extends State<ViewCarsCustomer> {
  final box = GetStorage();
  List<dynamic> xxxx = [];
  Future<List<dynamic>> getCarsWithIdUserAndIdPrandWithApi(
      {required int user_id, prand_id}) async {
    print(
        'http://192.168.179.98:8000/api/car/getCarWithUserAndPrand?user_id=$user_id&prand_id=$prand_id');
    Dio dio = DioSingelton.getInstance();

    Response response = await dio.get(
        'http://192.168.179.98:8000/api/car/getCarWithUserAndPrand?user_id=$user_id&prand_id=$prand_id');
    xxxx = response.data['data'];
    print(xxxx);
    print(user_id);
    print(prand_id);
    return xxxx;
  }

  @override
  Widget build(BuildContext context) {
    final prandProvider = Provider.of<PrandVM>(context);
    int prand_id_branch = box.read('prand_id_branch');
    int id_user_branch = box.read('id_user_branch');

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                await getCarsWithIdUserAndIdPrandWithApi(
                    user_id: id_user_branch, prand_id: prand_id_branch);
                setState(() {});
              },
              child: Text(
                "تحديث",
                style: TextStyle(color: colorprimarywhite),
              )),
        ],
        backgroundColor: colorprimarygreen,
        title: Center(child: Text(' صفحة أضافة السيارات ')),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Form(
            child: Column(
              children: [
                Image.asset('assets/images/home.png'),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: FutureBuilder(
                      future: getCarsWithIdUserAndIdPrandWithApi(
                          user_id: id_user_branch, prand_id: prand_id_branch),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isEmpty) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  "لم يتم اضافة اي سيارة",
                                  style: TextStyle(fontSize: 30),
                                ),
                              ],
                            );
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2.3,
                                  width: MediaQuery.of(context).size.width,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 213, 210, 200),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    margin: EdgeInsets.all(10),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Positioned(
                                            top: 80,
                                            right: 20,
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: colorprimarygreen),
                                              child: Center(
                                                child: Text(
                                                  "${index + 1}",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: colorprimarywhite),
                                                ),
                                              ),
                                            )),
                                        Positioned(
                                            top: 45,
                                            right: 120,
                                            child: Text(
                                              "${snapshot.data![index]['name']}",
                                              style: TextStyle(fontSize: 25),
                                            )),
                                        Positioned(
                                          top: 90,
                                          left: 20,
                                          child: SizedBox(
                                            width: 230,
                                            height: 230,
                                            child: Image.network(
                                              snapshot.data![index]
                                                  ['image_car_brands'],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                )

                // SizedBox(
                //   height: MediaQuery.of(context).size.height / 2.5,
                //   width: MediaQuery.of(context).size.width,
                //   child: FutureBuilder(
                //     future: getCarsWithIdUserAndIdPrandWithApi(
                //         user_id: id_user_branch, prand_id: prand_id_branch),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         return ListView.builder(
                //           scrollDirection: Axis.horizontal,
                //           itemCount: snapshot.data!.length,
                //           itemBuilder: (context, index) {
                //             return SizedBox(
                //               height: MediaQuery.of(context).size.height / 2.5,
                //               width: MediaQuery.of(context).size.width / 1.8,
                //               child: Container(
                //                 decoration: BoxDecoration(
                //                     color: colorprimarygreen,
                //                     borderRadius: BorderRadius.circular(20)),
                //                 margin: EdgeInsets.all(10),
                //                 child: Column(
                //                   children: [
                //                     SizedBox(
                //                       height: 20,
                //                     ),
                //                     Text(
                //                       "${snapshot.data![index]['name']}",
                //                       style: GoogleFonts.aBeeZee(
                //                         color: colorprimarywhite,
                //                         fontSize: 20,
                //                       ),
                //                     ),
                //                     Padding(
                //                       padding: const EdgeInsets.all(8.0),
                //                       child: SizedBox(
                //                         height:
                //                             MediaQuery.of(context).size.height /
                //                                 4,
                //                         width:
                //                             MediaQuery.of(context).size.height /
                //                                 3,
                //                         child: Container(
                //                           child: Image.network(
                //                               snapshot.data![index]
                //                                   ['image_car_brands'],
                //                               fit: BoxFit.contain),
                //                         ),
                //                       ),
                //                     )
                //                   ],
                //                 ),
                //               ),
                //             );
                //           },
                //         );
                //       }
                //       return Center(child: CircularProgressIndicator());
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
