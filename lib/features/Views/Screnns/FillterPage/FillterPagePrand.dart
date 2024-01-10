import 'dart:io';

import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/ViewModels/PrandVM.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyTextFormField.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FillterPagePrand extends StatefulWidget {
  const FillterPagePrand({super.key});

  @override
  State<FillterPagePrand> createState() => _FillterPagePrandState();
}

class _FillterPagePrandState extends State<FillterPagePrand> {
  final _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final prandProvider = Provider.of<PrandVM>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Form(
            child: Column(
              children: [
                SizedBox(height: 40),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          prandProvider.myNotifyListeners();

                          // prandProvider.clearControlle(_titleController);
                        },
                        icon: Icon(Icons.search)),
                    SizedBox(
                        width: 250,
                        child: Card(
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                controller: _titleController,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                // controller: _titleController,
                                onChanged: (value) {
                                  print(_titleController.text);
                                  if(_titleController.text==''){
                                    prandProvider.myNotifyListeners();
                                  }
                                  // _titleController.text = value;
                                  // prandProvider.filtterPrandName(
                                  //     fultterName: _titleController.text);
                                  //prandProvider.myNotifyListeners();
                                  // _titleController.text = value;
                                },
                              )),
                        )),
                    IconButton(
                        onPressed: () {
                          prandProvider.clearControlle(_titleController);
                        },
                        icon: Icon(Icons.clear))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: prandProvider.filtterPrandName(
                          fultterName: _titleController.text),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isEmpty) {
                            return Text("Empty");
                          }
                          return SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                              child: GridView.builder(
                                clipBehavior: Clip.none,
                                itemCount: snapshot.data!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.75,
                                        crossAxisSpacing: 30,
                                        mainAxisSpacing: 30,
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 210, 215, 216),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )),
                                          Positioned(
                                            top: 25,
                                            left: 10,
                                            child: SizedBox(
                                              height: 140,
                                              width: 140,
                                              child: ClipOval(
                                                clipBehavior: Clip.antiAlias,
                                                child: Image.network(
                                                    fit: BoxFit.cover,
                                                    snapshot
                                                        .data![index].path!),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 15,
                                            left: 20,
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
                                  );
                                },
                              ));
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
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
