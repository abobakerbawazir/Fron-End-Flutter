import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/ViewModels/CarVM.dart';
import 'package:booking_car_project_flutter/features/ViewModels/PrandVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/customerpage/ImageCarBYCarIDPage.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyTextFormField.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddCarScrrens extends StatefulWidget {
  const AddCarScrrens({super.key});

  @override
  State<AddCarScrrens> createState() => _AddCarScrrensState();
}

class _AddCarScrrensState extends State<AddCarScrrens> {
  final box = GetStorage();

  final _addFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _modelController = TextEditingController();
  final _priceController = TextEditingController();
  final _activeController = TextEditingController();
  final ImagePicker _pickercar = ImagePicker();
  XFile? PickedFilecar;
  List<int> imageBytescar = [];
  int? type;
  List<int> modelList = List.generate(26, (index) => index + 2000);
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
    final token = box.read('token_login');

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
    Response response = await dio.post(APIurl.storeCarsUlrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ));
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

  // Future<List<dynamic>> getCarsWithIdUserAndIdPrandWithApi(
  //     {required int user_id, prand_id}) async {
  //   print(
  //       '${APIurl.getCarWithUserAndPrand}?user_id=$user_id&prand_id=$prand_id');
  //   Dio dio = DioSingelton.getInstance();

  //   Response response = await dio.get(
  //       '${APIurl.getCarWithUserAndPrand}?user_id=$user_id&prand_id=$prand_id');
  //   xxx = response.data['data'];
  //   print(xxx);
  //   return xxx;
  // }

  @override
  Widget build(BuildContext context) {
    final prandProvider = Provider.of<PrandVM>(context);
    final carProvider = Provider.of<CarVM>(context);
    final prand_id = box.read('prand_id_branch');
    final user_id = box.read('user_id');
    // final prand_id = box.read('prand_id_forAddCar');
    // final user_id = box.read('user_id');

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
          //backgroundColor: colorprimarygreen,
          title: Center(child: Text(' صفحة أضافة السيارات ')),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(12),
          child: Form(
            key: _addFormKey,
            child: Column(
              children: [
                Image.asset('assets/images/best1.png'),
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
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return SingleChildScrollView(
                                child: Padding(
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
                                                          color:
                                                              Colors.black)));
                                            },
                                          ).toList(),
                                          onChanged: (value) {
                                            type = value!;
                                            _modelController.text =
                                                type!.toString();
                                          },
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: StatefulBuilder(
                                            builder: (context, setState) {
                                              return InkWell(
                                                onTap: () async {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        actions: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  PickedFilecar =
                                                                      await _picker.pickImage(
                                                                          source:
                                                                              ImageSource.gallery);
                                                                  imageBytescar =
                                                                      await PickedFilecar!
                                                                          .readAsBytes();
                                                                  carProvider
                                                                      .notifyListeners();
                                                                  setState(
                                                                      () {});
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                icon: Icon(
                                                                  Icons.photo,
                                                                  size: 50,
                                                                )),
                                                          ),
                                                          Text("           "),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  PickedFilecar =
                                                                      await _picker.pickImage(
                                                                          source:
                                                                              ImageSource.camera);
                                                                  imageBytescar =
                                                                      await PickedFilecar!
                                                                          .readAsBytes();
                                                                  carProvider
                                                                      .notifyListeners();
                                                                  setState(
                                                                      () {});
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .camera_alt,
                                                                  size: 50,
                                                                )),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text("اضافة صورة"),
                                                        Text(
                                                          'اختياري',
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Icon(
                                                      Icons.photo,
                                                      size: 50,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          )),
                                      PickedFilecar != null
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                    width: 200,
                                                    height: 200,
                                                    child: Image.file(File(
                                                        PickedFilecar!.path))),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      PickedFilecar = null;
                                                      setState(() {});
                                                      //carProvider.notifyListeners();
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text("حذف الصورة"),
                                                        Icon(Icons.cancel)
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          : StatefulBuilder(
                                              builder: (context, setState) {
                                                return Container();
                                              },
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
                                          if (_addFormKey.currentState!
                                              .validate()) {
                                            _addFormKey.currentState!.save();
                                            if (PickedFilecar != null) {
                                              print(imageBytescar);
                                              FormData formData =
                                                  await FormData.fromMap({
                                                'name': _nameController.text,
                                                'price': _priceController.text,
                                                'model': _modelController.text,
                                                'user_id': user_id,
                                                'prand_id': prand_id,
                                                'image_car_of_brands':
                                                    MultipartFile.fromBytes(
                                                        imageBytescar,
                                                        filename:
                                                            "image_car_of_brands.${PickedFilecar?.path.split('.').last}")
                                              });
                                              final x = await carProvider
                                                  .addCarWithImage(
                                                      formData: formData);
                                              Navigator.of(context).pop();
                                            } else {
                                              var x = await addCarWithApi(
                                                  name: _nameController.text,
                                                  model: _modelController.text,
                                                  price: int.parse(
                                                      _priceController.text),
                                                  prand_id: prand_id,
                                                  user_id: user_id);
                                              if (x == 200) {
                                                print("Succesffuly");
                                              } else {
                                                print("Faield");
                                              }
                                              carProvider.notifyListeners();
                                              Navigator.of(context).pop();
                                            }
                                          }
                                        },
                                        child: Text(
                                          'حفظ',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Text(
                      "اضافة سيارة جديدة",
                      style: TextStyle(color: colorprimarywhite, fontSize: 20),
                    )),
                // SizedBox(
                //   height: 20,
                // ),
                // Text(_image == null ? "" : _image!.path),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.9,
                    width: MediaQuery.of(context).size.width,
                    child: FutureBuilder(
                      future: carProvider.getCarsWithIdUserAndIdPrandWithApi(
                          user_id: user_id, prand_id: prand_id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isEmpty) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  "الرجاء اضافة سيارة",
                                  style: TextStyle(fontSize: 30),
                                ),
                              ],
                            );
                          } else {
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(snapshot.data!.length,
                                      (index) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.3,
                                      width: MediaQuery.of(context).size.width,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 213, 210, 200),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        margin: EdgeInsets.all(10),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Positioned(
                                              right: 10,
                                              top: 40,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () async {
                                                    AwesomeDialog(
                                                      context: context,
                                                      animType:
                                                          AnimType.leftSlide,
                                                      headerAnimationLoop:
                                                          false,
                                                      dialogType:
                                                          DialogType.question,
                                                      showCloseIcon: true,
                                                      title:
                                                          'هل فعلا تريد حذف السيارة',
                                                      desc:
                                                          ' سوف تقوم بحذف ${snapshot.data![index].name!}',
                                                      btnCancelOnPress: () {
                                                        Navigator.of(context);
                                                      },
                                                      btnOkOnPress: () async {
                                                        final data =
                                                            await carProvider
                                                                .deleteCar(
                                                                    id: snapshot
                                                                        .data![
                                                                            index]
                                                                        .id!);
                                                        if (data['code'] ==
                                                            405) {
                                                          AwesomeDialog(
                                                            context: context,
                                                            dialogType:
                                                                DialogType
                                                                    .error,
                                                            animType: AnimType
                                                                .rightSlide,
                                                            headerAnimationLoop:
                                                                false,
                                                            title: 'خطأ',
                                                            desc:
                                                                '${data['message']}',
                                                            btnOkOnPress: () {},
                                                            btnOkIcon:
                                                                Icons.cancel,
                                                            btnOkColor:
                                                                Colors.red,
                                                          ).show();
                                                        } else if (data[
                                                                'code'] ==
                                                            404) {
                                                          AwesomeDialog(
                                                            context: context,
                                                            dialogType:
                                                                DialogType
                                                                    .error,
                                                            animType: AnimType
                                                                .rightSlide,
                                                            headerAnimationLoop:
                                                                false,
                                                            title: 'خطأ',
                                                            desc:
                                                                '${data['message']}',
                                                            btnOkOnPress: () {},
                                                            btnOkIcon:
                                                                Icons.cancel,
                                                            btnOkColor:
                                                                Colors.red,
                                                          ).show();
                                                        }
                                                        if (data['code'] ==
                                                            200) {
                                                          AwesomeDialog(
                                                            context: context,
                                                            animType: AnimType
                                                                .leftSlide,
                                                            headerAnimationLoop:
                                                                false,
                                                            dialogType:
                                                                DialogType
                                                                    .success,
                                                            showCloseIcon: true,
                                                            title: 'نجاح',
                                                            desc:
                                                                '${data['message']}',
                                                            btnOkOnPress: () {
                                                              debugPrint(
                                                                  'OnClcik');
                                                            },
                                                            btnOkIcon: Icons
                                                                .check_circle,
                                                            onDismissCallback:
                                                                (type) {
                                                              debugPrint(
                                                                  'Dialog Dissmiss from callback $type');
                                                            },
                                                          ).show();
                                                        }
                                                      },
                                                      btnOkIcon:
                                                          Icons.check_circle,
                                                      onDismissCallback:
                                                          (type) {},
                                                    ).show();
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'حذف السيارة',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 10,
                                              right: 10,
                                              child: InkWell(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(children: [
                                                    Text(
                                                      "أضف صورة جديدة لهذه السيارة",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Icon(Icons.add_a_photo)
                                                  ]),
                                                ),
                                                onTap: () async {
                                                  await showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                            ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                        backgroundColor:
                                                                            colorprimarygreen),
                                                                onPressed:
                                                                    () async {
                                                                  //getImageCamera();
                                                                  _pickImageDio(
                                                                      source: ImageSource
                                                                          .camera,
                                                                      car_id: snapshot
                                                                          .data![
                                                                              index]
                                                                          .id!);
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
                                                                onPressed:
                                                                    () async {
                                                                  //getImagegallery();
                                                                  _pickImageDio(
                                                                      source: ImageSource
                                                                          .gallery,
                                                                      car_id: snapshot
                                                                          .data![
                                                                              index]
                                                                          .id!);
                                                                },
                                                                child: Text(
                                                                    "اضف صورة من المعرض"))
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 15,
                                                left: 15,
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: colorprimarygreen),
                                                  child: Center(
                                                    child: Text(
                                                      "${index + 1}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 25,
                                                          color:
                                                              colorprimarywhite),
                                                    ),
                                                  ),
                                                )),
                                            Positioned(
                                                top: 250,
                                                right: 15,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "اسم السيارة",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      " : ",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      "${snapshot.data![index].name}",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                )),
                                            Positioned(
                                                top: 280,
                                                right: 15,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "موديل السيارة",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      " : ",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      "${snapshot.data![index].model}",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                )),
                                            Positioned(
                                                top: 310,
                                                right: 15,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "السعر لليوم الواحد",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      " : ",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      "RY ${snapshot.data![index].price}",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                )),
                                            Positioned(
                                                top: 220,
                                                left: 20,
                                                child: InkWell(
                                                  onTap: () {
                                                    final car_id_Image =
                                                        box.write(
                                                            "car_id_ImageAll",
                                                            snapshot
                                                                .data![index]
                                                                .id);
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return ImageCarByCarIdPage();
                                                      },
                                                    ));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons
                                                          .photo_filter_outlined),
                                                      Text(
                                                        " : شاهد بقية الصور",
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            Positioned(
                                              top: 80,
                                              left: 20,
                                              child: SizedBox(
                                                height: 130,
                                                child: Container(
                                                  height: 130,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: InkWell(
                                                      onTap: () {
                                                        box.write(
                                                            'car_id_ImageAll',
                                                            snapshot
                                                                .data![index]
                                                                .id);
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            return ImageCarByCarIdPage();
                                                          },
                                                        ));
                                                      },
                                                      child: Image.network(
                                                        snapshot.data![index]
                                                            .imageCarOfBrands!,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            );
                          }
                        }
                        return Center(child: CircularProgressIndicator());
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
