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
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserVM>(context);

    final prandProvider = Provider.of<PrandVM>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text("الماركات")),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 209, 221, 227)),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                prandProvider.myNotifyListeners();
                              },
                              icon: Icon(Icons.search)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 1.55,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(255, 209, 221, 227)),
                                child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      //controller: _titleController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "ابحث هنا"),
                                      controller: _titleController,
                                      onChanged: (value) {
                                        print(_titleController.text);
                                        if (_titleController.text == '') {
                                          prandProvider.myNotifyListeners();
                                        }
                                      },
                                    )),
                              )),
                          IconButton(
                              onPressed: () {
                                _titleController.clear();
                                prandProvider.clearControlle(_titleController);
                              },
                              icon: Icon(Icons.clear))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 240,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FutureBuilder(
                          future: prandProvider.filtterPrandName(
                              fultterName: _titleController.text),
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
                                        Navigator.push(context,
                                            MaterialPageRoute(
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
                                            color: colorprimaryA1,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
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
                                              left: 12,
                                              child: Wrap(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        "${snapshot.data![index].name!}",
                                                        style: TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 20,
                                                        )),
                                                  ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
