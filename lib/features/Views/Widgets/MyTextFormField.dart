import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField(
      {super.key,
      this.controller,
      required this.hintText,
      this.readOnly,
      this.suffixIcon,
      this.obscureText});
  late String hintText;
  TextEditingController? controller;
  bool? readOnly;
  Widget? suffixIcon;
  bool? obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xfff8f9fb), borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
            obscureText: obscureText ?? false,
            controller: controller,
            readOnly: readOnly ?? false,
            decoration: InputDecoration(
                suffixIcon: suffixIcon,
                hintText: hintText,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)))),
      ),
    );
  }
}
