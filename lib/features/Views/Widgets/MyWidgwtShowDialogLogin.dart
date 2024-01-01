import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialog_shower/flutter_dialog_shower.dart';
import 'package:google_fonts/google_fonts.dart';
myWidgwtShowDialogLogin(
    {required BuildContext context,required String title, String? email, password}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title:
            Text("$title Your Email = $email and Password = $password"),
      );
    },
  );
}
