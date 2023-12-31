import 'dart:io';

import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/ViewModels/PrandVM.dart';
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
                Text(' صفحة أضافة الماركات '),
                MyTextFormField(
                  controller: _titleController,
                  hintText: 'الماركة',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter الماركة';
                    }
                    return null;
                  },
                ),
                Container(
                    child: ElevatedButton(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        getImagegallery();
                                      },
                                      child: Text("gallery")),
                                  ElevatedButton(
                                      onPressed: () {
                                        getImageCamera();
                                      },
                                      child: Text("camera"))
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
                  onPressed: () {
                    if (_addFormKey.currentState!.validate()) {
                      _addFormKey.currentState!.save();
                      Map<String, String> body = {
                        'name': _titleController.text
                      };
                      service.addImage(body, _image!.path);
                    }
                  },
                  child: Text('Save'),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(_image == null ? "" : _image!.path),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      _pickImageDio(_titleController.text);
                    },
                    child: Text("dio")),
                SizedBox(
                  height: 40,
                ),
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
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 300,
                                  width: 200,
                                  child: Image.network(
                                      snapshot.data![index].path!,
                                      scale: 1.0),
                                ),
                                Text("${snapshot.data![index].name}"),
                              ],
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
