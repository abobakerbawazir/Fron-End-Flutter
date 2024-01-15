import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField(
      {super.key,
      this.validator,
      this.controller,
      required this.hintText,
      this.readOnly,
      this.suffixIcon,this.maxLines=1,
      this.obscureText,
      this.keyboardType,
      this.inputFormatters});
  late String hintText;
  String? Function(String?)? validator;
  TextEditingController? controller;
  bool? readOnly;
  Widget? suffixIcon;
  bool? obscureText = false;
  TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  int? maxLines = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xfff8f9fb), borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
            maxLines: maxLines,
            inputFormatters: inputFormatters,
            validator: validator,
            keyboardType: keyboardType,
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
