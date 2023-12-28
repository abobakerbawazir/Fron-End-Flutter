import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyTextFormField.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTxt = TextEditingController();
  TextEditingController passwordTxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserVM>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        backgroundColor: colorprimarygreen,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              MyTextFormField(
                hintText: "email",
                controller: emailTxt,
              ),
              MyTextFormField(hintText: "password", controller: passwordTxt),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await userProvider.login(
                      context: context,
                      email: emailTxt.text,
                      password: passwordTxt.text,
                    );
                  },
                  child: Text("Login")),
            ],
          ),
        ),
      ),
    );
  }
}
