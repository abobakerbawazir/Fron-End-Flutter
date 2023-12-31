import 'dart:io';

import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/ViewModels/PrandVM.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyTextFormField.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddCarScrrens extends StatefulWidget {
  const AddCarScrrens({super.key});

  @override
  State<AddCarScrrens> createState() => _AddCarScrrensState();
}

class _AddCarScrrensState extends State<AddCarScrrens> {
  final _addFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _modelController = TextEditingController();
  final _priceController = TextEditingController();
  final _activeController = TextEditingController();
  int? type;
  List<int> modelList = List.generate(25, (index) => index + 2000);
  File? _image;
  final picker = ImagePicker();
  Future getImagegallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageCamera() async {
    final pickedCamera = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedCamera != null) {
        _image = File(pickedCamera.path);
      } else {
        print('No image selected.');
      }
    });
  }

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

  addCarWithApi(
      {String? name,
      String? model,
      int? price,
      int? user_id,
      int? prand_id}) async {
    // XFile? PickedFile = await _picker.pickImage(source: ImageSource.gallery);
    // List<int> imageBytes = await PickedFile!.readAsBytes();
    FormData formData = FormData.fromMap({
      'name': name,
      'model': model,
      'price': price,
      'user_id': user_id,
      'prand_id': prand_id,
    });
    Dio dio = DioSingelton.getInstance();
    Response response = await dio.post(APIurl.storeCarsUlrl, data: formData);
    var x = response.data['code'];
    print(x);
    print(response.data);
    return x;
  }

  List<dynamic> xxx = [];
  Future<List<dynamic>> getCarsWithApi() async {
    print(APIurl.viewAllCarsUlrl);
    Dio dio = DioSingelton.getInstance();

    Response response = await dio.get(APIurl.viewAllCarsUlrl);
    xxx = response.data['data'];
    print(xxx);
    return xxx;
  }

  @override
  Widget build(BuildContext context) {
    final prandProvider = Provider.of<PrandVM>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                await getCarsWithApi();
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
            key: _addFormKey,
            child: Column(
              children: [
                Image.asset('assets/images/home.png'),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorprimarygreen),
                    onPressed: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                MyTextFormField(
                                  controller: _nameController,
                                  hintText: 'اسم السيارة',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter اسم السيارة';
                                    }
                                    return null;
                                  },
                                ),
                                MyTextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.number,
                                  controller: _priceController,
                                  hintText: 'سعر السيارة',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter سعر السيارة';
                                    }
                                    return null;
                                  },
                                ),
                                MyTextFormField(
                                  readOnly: true,
                                  controller: _modelController,
                                  hintText: 'موديل السيارة',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter موديل السيارة';
                                    }
                                    return null;
                                  },
                                  suffixIcon: DropdownButton(
                                    // icon: Icon(Icons
                                    //     .arrow_drop_down_circle_outlined),
                                    value: type,
                                    items: modelList.map(
                                      (e) {
                                        return DropdownMenuItem(
                                            value: e,
                                            child: Text(e.toString(),
                                                style: TextStyle(
                                                    color: Colors.black)));
                                      },
                                    ).toList(),
                                    onChanged: (value) {
                                      type = value!;
                                      _modelController.text = type!.toString();
                                    },
                                  ),
                                ),
                                // Container(
                                //     child: ElevatedButton(
                                //         onPressed: () async {
                                //           await showDialog(
                                //             context: context,
                                //             builder: (context) {
                                //               return AlertDialog(
                                //                 actions: [
                                //                   ElevatedButton(
                                //                       onPressed: () {
                                //                         getImagegallery();
                                //                       },
                                //                       child: Text("gallery")),
                                //                   ElevatedButton(
                                //                       onPressed: () {
                                //                         getImageCamera();
                                //                       },
                                //                       child: Text("camera"))
                                //                 ],
                                //               );
                                //             },
                                //           );
                                //         },
                                //         child: _buildImage())),

                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: colorprimarygreen),
                                  onPressed: () async {
                                    if (_addFormKey.currentState!.validate()) {
                                      _addFormKey.currentState!.save();
                                      var x = await addCarWithApi(
                                          name: _nameController.text,
                                          model: _modelController.text,
                                          price:
                                              int.parse(_priceController.text),
                                          prand_id: 1,
                                          user_id: 1);
                                      if (x == 200) {
                                        print("Succesffuly");
                                      } else {
                                        print("Faield");
                                      }
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text(
                                    'Save',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      "اضافة سيارة جديدة",
                      style: TextStyle(color: colorprimarywhite, fontSize: 20),
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(_image == null ? "" : _image!.path),

                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                    future: getCarsWithApi(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      await showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                colorprimarygreen),
                                                    onPressed: () async {
                                                      //getImageCamera();
                                                      _pickImageDio(
                                                          source: ImageSource
                                                              .camera,
                                                          car_id: snapshot
                                                                  .data![index]
                                                              ['id']);
                                                    },
                                                    child: Text(
                                                        "اضف صورة من الكاميرا")),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                colorprimarygreen),
                                                    onPressed: () async {
                                                      //getImagegallery();
                                                      _pickImageDio(
                                                          source: ImageSource
                                                              .gallery,
                                                          car_id: snapshot
                                                                  .data![index]
                                                              ['id']);
                                                    },
                                                    child: Text(
                                                        "اضف صورة من المعرض"))
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      "أضف صورة جديدة لهذه السيارة",
                                      style:
                                          TextStyle(color: colorprimarygreen),
                                    )),
                                Text("${snapshot.data![index]['id']}"),
                                Text("${snapshot.data![index]['name']}"),
                                SizedBox(
                                  child: Image.network(snapshot.data![index]
                                      ['image_car_brands']),
                                )
                              ],
                            );
                          },
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                )
                // SizedBox(
                //   height: MediaQuery.of(context).size.height / 2,
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
                //                   child: Image.network(
                //                       snapshot.data![index].path!,
                //                       scale: 1.0),
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

  Widget _buildImage() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Text(" اضف من المتصفح"),
          Icon(
            Icons.add,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
