import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Helpers/Messge.dart';
import 'package:booking_car_project_flutter/features/Models/Users/Profile.dart';
import 'package:booking_car_project_flutter/features/Models/Users/User.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/DialogMessage.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyWidgwtShowDialogLogin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class UserVM with ChangeNotifier {
  final box = GetStorage();

  bool iconObsecure = false;
  bool iconObsecure2 = false;
  bool iconObsecure3 = false;

  Dio connect = DioSingelton.getInstance();
  List<dynamic> _usersRole = [];
  List<dynamic> get usersRole => _usersRole;

  List<Profile> _allUsers = [];
  List<Profile> get allUsers => _allUsers;

  changeIconStateLogin() {
    if (iconObsecure == false) {
      iconObsecure = true;
    } else {
      iconObsecure = false;
    }
    notifyListeners();
  }

  changeIconStateSignUp2() {
    if (iconObsecure2 == false) {
      iconObsecure2 = true;
    } else {
      iconObsecure2 = false;
    }

    notifyListeners();
  }

  changeIconStateSignUp3() {
    if (iconObsecure3 == false) {
      iconObsecure3 = true;
    } else {
      iconObsecure3 = false;
    }
    notifyListeners();
  }

  Future<List<dynamic>> allUserslistOfMap() async {
    Response responce = await connect.get(APIurl.indexByAdminUrl);
    var x = await responce.data['data'];
    var y = x[0]['username'];
    print(y);
    _usersRole = responce.data['data'];

    //print(_usersRole);
    return _usersRole;
  }

  Future<List<Profile>> getAllUsersFromAPi() async {
    Response responce = await connect.get(APIurl.indexByAdminUrl);
    print(responce.data['data']);
    List<dynamic> dataProfile = responce.data['data'];
    print(responce.data['data']);
    _allUsers = dataProfile
        .map((e) => Profile.fromJson(e as Map<String, dynamic>))
        .toList();
    print(_allUsers);
    return _allUsers;
  }

  Future signUP(
      {required String username,
      phone,
      full_name,
      user_type,
      email,
      password,
      password_confirmation,
      role,
      required BuildContext context}) async {
    print(APIurl.SignupUrl);
    try {
      final responce = await connect.post(
        APIurl.SignupUrl,
        data: Profile(
                username: username,
                phone: phone,
                fullName: full_name,
                userType: user_type,
                email: email,
                password: password,
                password_confirmation: password_confirmation,
                role: role)
            .toJson(),

        /*
        {
          "username": username,
          "phone": phone,
          "full_name": full_name,
          "user_type": user_type,
          "email": email,
          "password": password,
          "password_confirmation": password_confirmation
        }
         */
        //options: Options(headers: {})
      );
      if (responce.statusCode == 200) {
        var code = responce.data['code'];
        var usernamemessage = responce.data['data']['username'] ?? "";
        var emailmessage = responce.data['data']['email'] ?? "";
        var phonemessage = responce.data['data']['phone'] ?? "";
        var passwordmessage = responce.data['data']['password'] ?? "";
        //var data = responce.data;
        if (responce.data['code'] == 200) {
          print(responce.data);
          print("User added Successfully $code");
          SuceessLoginDialog(
              description: "Email = $email and Password = $password",
              context: context,
              email: email,
              password: password,
              title: messageLoginInTitleSeccues);
        } else {
          print(responce.data);

          print(
              "User added Faield $code $usernamemessage $emailmessage $phonemessage $passwordmessage");
          errorLoginDialog(
              context: context,
              title: "خطا $code",
              description: '''تأكد من المعلومات المدخلة
               $code $usernamemessage $emailmessage $phonemessage $passwordmessage''');
        }
      } else {
        throw Exception('Failed to add User');
      }
    } catch (e) {
      throw Exception("Failed to add User $e");
    }
    notifyListeners();
  }

  Future login(
      {required String email, password, required BuildContext context}) async {
    print(APIurl.loginUrl);
    try {
      final responce = await connect.post(
        APIurl.loginUrl,
        data: Profile(email: email, password: password).toJson(),
        /* {
          "email": email,
          "password": password,
        } */
      );

      if (responce.statusCode == 200) {
        if (responce.data['code'] == 400) {
          errorLoginDialog(
              context: context,
              title: "خطا",
              description: 'ربما كلمة المرور او البريد الالكتروني غير صحيح');
          print("########### ${responce.data}");
          throw Exception('Failed to login@@@@@@@@@@@@');
        }
        var token_login = responce.data['data']['token'];
        var user_id = responce.data['data']['id'];
        var role_user = responce.data['data']['role'];
        box.write('token_login', token_login);
        box.write('role_user', role_user);
        box.write('user_id', user_id);
        print(token_login);
        print(user_id);
        print(role_user);
        print(box.read('token_login'));
        print(box.read('role_user'));
        print(box.read('user_id'));
        print(responce.data);
        print("Login Successfully ${responce.data['data']['token']}");
        SuceessLoginDialog(
            context: context,
            email: email,
            password: password,
            title: messageSignupInTitleSeccues);
      } else {
        print("########### ${responce.data}");
        throw Exception('Failed to login@@@@@@@@@@@@');
      }
    } catch (e) {
      throw Exception("Failed to Login $e");
    }
    notifyListeners();
  }

  logout() async {
    final token = box.read('token_login');
    print(token);
    try {
      final responce = await connect.post(APIurl.logoutUrl,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      print(responce.data);
    } catch (e) {
      throw Exception("Failed to Logout $e");
    }
  }

  Future confirmBranchFromAdmin(
      String id, Profile p, BuildContext context) async {
    try {
      print(APIurl.updateByAdminUrl + id);
      final responce = await connect.put(APIurl.updateByAdminUrl + id,
          data: p.toJsonActive());
      print(APIurl.updateByAdminUrl + id);
      var code = responce.data['code'];
      print(code);
      if (code == 200) {
        print("Succesfully");
      } else {
        print("Faield");
      }
      notifyListeners();
      return code;
    } catch (e) {
      throw Exception("$e");
    }
  }
}
