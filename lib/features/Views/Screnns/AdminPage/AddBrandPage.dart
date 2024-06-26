import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
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

class Service {
  Future<bool> addImage(Map<String, String> body, String filepath) async {
    String addimageUrl = APIurl.baseUrl + 'uploadImage';
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };
    // var xx = http.post(Uri.parse(addimageUrl),body: {'image_path':filepath,'name':body},headers: headers);
    var request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
      ..fields.addAll(body)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image_path', filepath));
    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

class AddPrandScrrens extends StatefulWidget {
  const AddPrandScrrens({super.key});

  @override
  State<AddPrandScrrens> createState() => _AddPrandScrrensState();
}

class _AddPrandScrrensState extends State<AddPrandScrrens> {
  Service service = Service();
  final _addFormKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
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
  _pickImageDio(String name) async {
    XFile? PickedFile = await _picker.pickImage(source: ImageSource.gallery);
    List<int> imageBytes = await PickedFile!.readAsBytes();
    FormData formData = FormData.fromMap({
      'name': name,
      'image_path': MultipartFile.fromBytes(imageBytes,
          filename: "image_path.${PickedFile.path.split('.').last}")
    });
    Dio dio = DioSingelton.getInstance();
    Response response =
        await dio.post(APIurl.baseUrl + 'uploadImage', data: formData);
  }

  @override
  Widget build(BuildContext context) {
    final prandProvider = Provider.of<PrandVM>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Form(
              key: _addFormKey,
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Text(
                    ' صفحة أضافة الماركات ',
                    style: TextStyle(fontSize: 20),
                  ),
                  MyTextFormField(
                    controller: _titleController,
                    hintText: 'الماركة',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'لو سمحت اضف الماركة ولا تترك حقل فارغ';
                      }
                      return null;
                    },
                  ),
                  Container(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colorprimarygreen),
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actions: [
                                    SizedBox(
                                      height: 120,
                                      width: 120,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  colorprimarywhite),
                                          onPressed: () {
                                            getImagegallery();
                                            Navigator.pop(context);
                                          },
                                          child: Center(
                                            child: Icon(
                                              color: colorprimarygrey,
                                              Icons.photo,
                                              size: 100,
                                            ),
                                          )),
                                    ),
                                    Padding(padding: EdgeInsets.all(8)),
                                    SizedBox(
                                      height: 120,
                                      width: 120,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  colorprimarywhite),
                                          onPressed: () {
                                            getImageCamera();
                                            Navigator.pop(context);
                                          },
                                          child: Center(
                                            child: Icon(
                                              color: colorprimarygrey,
                                              Icons.camera_alt,
                                              size: 100,
                                            ),
                                          )),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: _buildImage())),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorprimarygreen),
                    onPressed: () {
                      if (_addFormKey.currentState!.validate()) {
                        _addFormKey.currentState!.save();
                        Map<String, String> body = {
                          'name': _titleController.text
                        };
                        service.addImage(body, _image!.path);
                        prandProvider.notifyListeners();
                      }
                      setState(() {});
                    },
                    child: Text(
                      'حفظ',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Text(_image == null ? "" : _image!.path),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       _pickImageDio(_titleController.text);
                  //     },
                  //     child: Text("dio")),

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder(
                        future: prandProvider.getAllPrandsFromAPi(),
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
                                          Positioned(
                                            right: 1,
                                            child: IconButton(
                                                onPressed: () async {
                                                  AwesomeDialog(
                                                    context: context,
                                                    animType:
                                                        AnimType.leftSlide,
                                                    headerAnimationLoop: false,
                                                    dialogType:
                                                        DialogType.question,
                                                    showCloseIcon: true,
                                                    title:
                                                        'هل فعلا تريد حذف الماركة',
                                                    desc:
                                                        '${snapshot.data![index].name!} سوف تقوم بحذف ',
                                                    btnCancelOnPress: () {
                                                      Navigator.of(context);
                                                    },
                                                    btnOkOnPress: () async {
                                                      final data =
                                                          await prandProvider
                                                              .deleteBrand(
                                                                  id: snapshot
                                                                      .data![
                                                                          index]
                                                                      .id!);
                                                      if (data['code'] == 405) {
                                                        AwesomeDialog(
                                                          context: context,
                                                          dialogType:
                                                              DialogType.error,
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
                                                      } else if (data['code'] ==
                                                          404) {
                                                        AwesomeDialog(
                                                          context: context,
                                                          dialogType:
                                                              DialogType.error,
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
                                                      if (data['code'] == 200) {
                                                        AwesomeDialog(
                                                          context: context,
                                                          animType: AnimType
                                                              .leftSlide,
                                                          headerAnimationLoop:
                                                              false,
                                                          dialogType: DialogType
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
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                )),
                                          ),
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
                              ),
                            );
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
      ),
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Text(" اضف من الهاتف"),
          Icon(
            Icons.add,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
