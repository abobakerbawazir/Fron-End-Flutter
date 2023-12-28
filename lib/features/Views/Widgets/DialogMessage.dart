import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

errorLoginDialog({required BuildContext context,required String title,String? description,}) {
  return AwesomeDialog(
    autoHide: const Duration(seconds: 3),
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.rightSlide,
    headerAnimationLoop: false,
    title: title,
    desc: description??"",
    btnOkOnPress: () {},
    btnOkIcon: Icons.cancel,
    btnOkColor: Colors.red,
  ).show();
}

SuceessLoginDialog(
    {required BuildContext context,required String title,String? description,  required String email, password}) {
  return AwesomeDialog(
    context: context,
    animType: AnimType.leftSlide,
    headerAnimationLoop: false,
    dialogType: DialogType.success,
    showCloseIcon: true,
    title: title,
    desc: description??"",
    btnOkOnPress: () {
      debugPrint('OnClcik');
    },
    btnOkIcon: Icons.check_circle,
    onDismissCallback: (type) {
      debugPrint('Dialog Dissmiss from callback $type');
    },
  ).show();
}

