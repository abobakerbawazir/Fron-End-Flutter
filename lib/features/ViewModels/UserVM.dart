import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/core/Constans/Api_Url_Wallet.dart';
import 'package:booking_car_project_flutter/core/Constans/Api_url_Update.dart';
import 'package:booking_car_project_flutter/core/Helpers/Messge.dart';
import 'package:booking_car_project_flutter/features/Models/Booking/Booking.dart';
import 'package:booking_car_project_flutter/features/Models/Users/Balance.dart';
import 'package:booking_car_project_flutter/features/Models/Users/Profile.dart';
import 'package:booking_car_project_flutter/features/Models/Users/User.dart';
import 'package:booking_car_project_flutter/features/ViewModels/BookingVM.dart';
import 'package:booking_car_project_flutter/features/ViewModels/PrandVM.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/DialogMessage.dart';
import 'package:booking_car_project_flutter/core/Helpers/DioSingelton.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyTextFormField.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyWidgwtShowDialogLogin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class UserVM with ChangeNotifier {
  static UserVM? _objectDio;
  static UserVM getInstanceSinglton() {
    if (_objectDio == null) _objectDio = UserVM();
    return _objectDio!;
  }

  final box = GetStorage();

  bool iconObsecure = false;
  bool iconObsecure2 = false;
  bool iconObsecure3 = false;

  Dio connect = DioSingelton.getInstance();
  List<dynamic> _usersRole = [];
  List<dynamic> get usersRole => _usersRole;

  List<Profile> _allUsers = [];
  List<Profile> get allUsers => _allUsers;
  List<ProfileBranch> _allUsersBranches = [];
  List<ProfileBranch> get allUsersBranches => _allUsersBranches;
  List<Branch> _allBranch = [];
  List<Branch> get allBranch => _allBranch;

  changeIconStateLogin() {
    if (iconObsecure == false) {
      iconObsecure = true;
    } else {
      iconObsecure = false;
    }
    notifyListeners();
  }
  clearControlle(TextEditingController textEditingController) {
    textEditingController.clear();
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
        final token = box.read('token_login');

    Response responce = await connect.get(APIurl.indexByAdminUrl,options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
    var x = await responce.data['data'];
    var y = x[0]['username'];
    print(y);
    _usersRole = responce.data['data'];

    //print(_usersRole);
    return _usersRole;
  }

  //delete user By Admin
  Future deleteUser({required int id}) async {
            final token = box.read('token_login');

    Response response =
        await connect.delete(APIurl.deleteuserUrl + id.toString(),options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
    print(response.data);
    final code = response.data['code'];
    print(code);
    notifyListeners();
    return code;
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

  Future<List<Branch>> getAllBranchesActiveOrAllUserFromAPi(
      {required String url}) async {
    try {
      print(url);
      Response responce = await connect.get(url);
      print(responce.data['data']);
      List<dynamic> dataProfile = responce.data['data'];
      print(responce.data['data']);
      _allBranch = dataProfile
          .map((e) => Branch.fromJson(e as Map<String, dynamic>))
          .toList();
      print(_allBranch);
      return _allBranch;
    } catch (e) {
      return _allBranch;
    }
  }
  Future<List<Branch>> getAllBranchesActiveOrAllUserFromAPiSearch(
      {required String url,String? fultterName}) async {
    try {
      print(url);
      Response responce = await connect.get(url);
      print(responce.data['data']);
      List<dynamic> dataProfile = responce.data['data'];
      print(responce.data['data']);
      _allBranch = dataProfile
          .map((e) => Branch.fromJson(e as Map<String, dynamic>))
          .toList();
      print(_allBranch);
      return _allBranch;
    } catch (e) {
      return _allBranch;
    }
  }

  Future<List<ProfileBranch>> viewAlluserByRoleName(
      {required String name, int id = 0}) async {
    print(APIurl.viewAllBranchActive);
    Response responce = await connect
        .get(APIurl.viewAlluserByRoleNameUrl + name + '/' + id.toString());
    print(responce.data['data']);
    List<dynamic> dataProfile = responce.data['data'];
    print(responce.data['data']);
    _allUsersBranches = dataProfile
        .map((e) => ProfileBranch.fromJson(e as Map<String, dynamic>))
        .toList();
    print(_allUsersBranches);
    return _allUsersBranches;
  }

  Future SignUpWithImage(
      {required FormData formData, required BuildContext context}) async {
    print(APIurl.baseUrl + 'addUserAndAddImage');
    Dio dio = DioSingelton.getInstance();
    Response responce =
        await dio.post(APIurl.baseUrl + 'addUserAndAddImage', data: formData);
    var x = responce.data;
    print(x);
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
            description: "",
            context: context,
            email: '',
            password: '',
            title: messageSignupInTitleSeccues);
      } else if (responce.data['code'] == 400) {
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
    notifyListeners();
    return x;
  }

  Future signUP(
      {required String username,
      required String phone,
      required String full_name,
      required String email,
      required String password,
      required String password_confirmation,
      required String roles,
      required BuildContext context}) async {
    print(APIurl.SignupUrl);
    try {
      final responce = await connect.post(
        APIurl.SignupUrl,
        data: UserSignUp(
                username: username,
                phone: phone,
                fullName: full_name,
                email: email,
                password: password,
                passwordConfirmation: password_confirmation,
                role: roles)
            .toJson(),
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
              title: messageSignupInTitleSeccues);
        } else if (responce.data['code'] == 400) {
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
      notifyListeners();
      print(responce.data['code']);
      return responce.data['code'];
    } catch (e) {
      throw Exception("Failed to add User $e");
    }
    notifyListeners();
  }
  // Future signUPImage(
  //     {required String username,
  //     phone,
  //     full_name,
  //     user_type,
  //     email,
  //     password,
  //     password_confirmation,
  //     roles,
  //     required BuildContext context}) async {
  //   print(APIurl.SignupUrl);
  //   try {
  //     final responce = await connect.post(
  //       APIurl.SignupUrl,
  //       data: Profile(
  //               username: username,
  //               phone: phone,
  //               fullName: full_name,
  //               userType: user_type,
  //               email: email,
  //               password: password,
  //               password_confirmation: password_confirmation,
  //               roles: roles)
  //           .toJson(),
  //     );
  //     if (responce.statusCode == 200) {
  //       var code = responce.data['code'];
  //       var usernamemessage = responce.data['data']['username'] ?? "";
  //       var emailmessage = responce.data['data']['email'] ?? "";
  //       var phonemessage = responce.data['data']['phone'] ?? "";
  //       var passwordmessage = responce.data['data']['password'] ?? "";
  //       //var data = responce.data;
  //       if (responce.data['code'] == 200) {
  //         print(responce.data);
  //         print("User added Successfully $code");
  //         SuceessLoginDialog(
  //             description: "Email = $email and Password = $password",
  //             context: context,
  //             email: email,
  //             password: password,
  //             title: messageLoginInTitleSeccues);
  //       } else if (responce.data['code'] == 400) {
  //         print(responce.data);

  //         print(
  //             "User added Faield $code $usernamemessage $emailmessage $phonemessage $passwordmessage");
  //         errorLoginDialog(
  //             context: context,
  //             title: "خطا $code",
  //             description: '''تأكد من المعلومات المدخلة
  //              $code $usernamemessage $emailmessage $phonemessage $passwordmessage''');
  //       }
  //     } else {
  //       throw Exception('Failed to add User');
  //     }
  //     notifyListeners();
  //     print(responce.data['code']);
  //     return responce.data['code'];
  //   } catch (e) {
  //     throw Exception("Failed to add User $e");
  //   }
  //   notifyListeners();
  // }

  Future<int> login(
      {required String email, password, required BuildContext context}) async {
    print(APIurl.loginUrl);
    final responce = await connect.post(
      APIurl.loginUrl,
      data: Profile(email: email, password: password).toJson(),
    );
    final code = responce.data['code'];
    try {
      print(responce.data);
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
        var walletCode = responce.data['data']['wallet']['code'];
        var walletId = responce.data['data']['wallet']['id'];
        var user_id = responce.data['data']['id'];
        var role_user = responce.data['data']['roles'];
        var active_user = responce.data['data']['active'];
        var username = responce.data['data']['username'];
        var full_name = responce.data['data']['full_name'];
        var email = responce.data['data']['email'];
        var phone = responce.data['data']['phone'];
        var image = responce.data['data']['image'];
        var location = responce.data['data']['location'];
        box.write('username', username);
        box.write('full_name', full_name);
        box.write('email', email);
        box.write('phone', phone);
        box.write('image', image);
        box.write('location', location);
        box.write('token_login', token_login);
        box.write('role_user', role_user);
        box.write('user_id', user_id);
        box.write('active_user', active_user);
        box.write('walletCode', walletCode);
        box.write('walletId', walletId);
        print(box.read('walletCode'));
        print(box.read('walletId'));
        print(token_login);
        print(user_id);
        print(role_user);
        print(active_user);
        print(box.read('token_login'));
        print(box.read('role_user'));
        print(box.read('user_id'));
        print(box.read('active_user'));
        print(responce.data);
        print("Login Successfully ${responce.data['data']['token']}");
        // SuceessLoginDialog(
        //     context: context,
        //     email: email,
        //     password: password,
        //     title: messageLoginInTitleSeccues);
        notifyListeners();
        return code;
      } else {
        print("########### ${responce.data}");
        throw Exception('Failed to login@@@@@@@@@@@@');
      }
    } catch (e) {
      notifyListeners();
      return code;
      throw Exception("Failed to Login $e");
    }
    notifyListeners();
  }

  Future<int> updateProfile(int id, Profile p) async {
    int code = 0;
    try {
      final responce = await connect.put("${APIurl.updateProfile}$id",
          data: p.toJsonProfile());
      print("${APIurl.updateProfile}$id");
      print(responce.data);
      print(responce.data['data']);

      code = responce.data!['code'];
      print(code);
      if (code == 200) {
        print(code);
        box.write('username', p.username);
        box.write('full_name', p.fullName);
        box.write('email', p.email);
        box.write('phone', p.phone);
        print(code);
        return code;
      }
      return code;
    } catch (e) {
      return code;
    }
    // box.write('location', p.location);
  }

  Future logout({BuildContext? context}) async {
    //int code = 0;
    final token = box.read('token_login');
    print(token);
    try {
      final responce = await connect.post(APIurl.logoutUrl,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      box.remove('token_login');
      // code = responce.data['code'];
      // if (code == 200) {
      //   return successDialog(context: context!);
      // }
      print(responce.data);
      print(box.read('token_login'));
      print(responce.data['data']);
      return responce.data['data'];
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

  Balance _oneBalance = Balance();
  Balance get oneBalance => _oneBalance;
  Future<Balance> getBalanceByIDWallet({required int id}) async {
    print('${APIUrlWallet.getBalanceByIdWalletUrl}$id');
    Dio dio = DioSingelton.getInstance();

    Response response =
        await dio.get('${APIUrlWallet.getBalanceByIdWalletUrl}$id');
    try {
      Map<String, dynamic> dtatBalance = response.data;
      _oneBalance = Balance.fromJson(dtatBalance);
      print(_oneBalance);
      print(dtatBalance);
      return _oneBalance;
    } catch (e) {
      return _oneBalance;
    }
  }

  Future updateImageUserProfileURL(
      {required FormData formData, required int id}) async {
    print(API_URL_Update.updateImageUserProfileURL + id.toString());
    Dio dio = DioSingelton.getInstance();
    Response responce = await dio.post(
        API_URL_Update.updateImageUserProfileURL + id.toString(),
        data: formData);
    final x = responce.data['data']['image'];
    box.write('image', x);
    notifyListeners();
    return responce.data['data']['image'];
  }
}
