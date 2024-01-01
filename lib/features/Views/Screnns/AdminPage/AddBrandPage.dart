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

    return Scaffold(
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
                                  ElevatedButton(
                                      onPressed: () {
                                        getImagegallery();
                                        Navigator.pop(context);
                                      },
                                      child: Text("أضف من المعرض")),
                                  ElevatedButton(
                                      onPressed: () {
                                        getImageCamera();
                                        Navigator.pop(context);
                                      },
                                      child: Text("اضف من الكاميرا"))
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
                  child: FutureBuilder(
                    future: prandProvider.getAllPrandsFromAPi(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return Text("Empty");
                        }
                        return GridView.builder(
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
                              height: MediaQuery.of(context).size.height,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 54, 140, 75),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.favorite,
                                          color: colorprimarywhite,
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
                                              snapshot.data![index].path!),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 15,
                                      left: 20,
                                      child: Wrap(
                                        children: [
                                          Text(snapshot.data![index].name!,
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
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
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
