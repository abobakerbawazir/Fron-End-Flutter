import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();
_pickImageDio() async {
  XFile? PickedFile = await _picker.pickImage(source: ImageSource.gallery);
  List<int> imageBytes = await PickedFile!.readAsBytes();
  FormData formData = FormData.fromMap({
    'name': "asdfgdfghjhj",
    'image_path': MultipartFile.fromBytes(imageBytes,
        filename: DateTime.now().toIso8601String())
  });
  Dio dio = DioSingelton.getInstance();
  Response response =
      await dio.post(APIurl.baseUrl + 'uploadImage', data: formData);
}
