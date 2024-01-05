import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/features/Models/Booking/Booking.dart';
import 'package:booking_car_project_flutter/features/ViewModels/BookingVM.dart';
import 'package:booking_car_project_flutter/features/ViewModels/PrandVM.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

errorLoginDialog({
  required BuildContext context,
  required String title,
  String? description,
}) {
  return AwesomeDialog(
    //autoHide: const Duration(seconds: 3),
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.rightSlide,
    headerAnimationLoop: false,
    title: title,
    desc: description ?? "",
    btnOkOnPress: () {},
    btnOkIcon: Icons.cancel,
    btnOkColor: Colors.red,
  ).show();
}

SuceessLoginDialog(
    {required BuildContext context,
    required String title,
    String? description,
    required String email,
    required String password}) {
  return AwesomeDialog(
    context: context,
    animType: AnimType.leftSlide,
    headerAnimationLoop: false,
    dialogType: DialogType.success,
    showCloseIcon: true,
    title: title,
    desc: description ?? "",
    btnOkOnPress: () {
      debugPrint('OnClcik');
    },
    btnOkIcon: Icons.check_circle,
    onDismissCallback: (type) {
      debugPrint('Dialog Dissmiss from callback $type');
    },
  ).show();
}

warningDialog({required BuildContext context, String? data, String? type}) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    headerAnimationLoop: false,
    animType: AnimType.topSlide,
    showCloseIcon: true,
    closeIcon: const Icon(Icons.close_fullscreen_outlined),
    title: type ?? "",
    desc: data ?? "",
    btnCancelOnPress: () {
      //Navigator.pop(context);
    },
    onDismissCallback: (type) {
      debugPrint('Dialog Dismiss from callback $type');
    },
    btnOkOnPress: () {
      //Navigator.pop(context);
    },
  ).show();
}

successDialog({required BuildContext context, String? data, String? type}) {
  return AwesomeDialog(
    context: context,
    animType: AnimType.leftSlide,
    headerAnimationLoop: false,
    dialogType: DialogType.success,
    showCloseIcon: true,
    title: type ?? "",
    desc: data ?? "",
    btnOkOnPress: () {
            Navigator.pop(context);

      // debugPrint('OnClcik');
    },
    btnOkIcon: Icons.check_circle,
    onDismissCallback: (type) {
            // Navigator.pop(context);

      // debugPrint('Dialog Dissmiss from callback $type');
    },
  ).show();
}

showDialogBooking(
    {required BuildContext context,
    required int carId,
    required TextEditingController fromTxt,
    required TextEditingController toTxt,
    required int userId}) {
  final box = GetStorage();
  BookingVM b = BookingVM.getInstanceSinglton();
  DateTime? startDate1;
  DateTime? lastDate1;
  int x = 0;

  return AlertDialog(
    title: Center(child: Text("اضف التاريخ")),
    actions: [
      MyTextFormField(
        hintText: 'تاريخ بداية الحجز',
        controller: fromTxt,
        readOnly: true,
        suffixIcon: IconButton(
            onPressed: () async {
              DateTime? startDate = await showDatePicker(
                  builder: (context, child) {
                    return Theme(data: ThemeData.dark(), child: child!);
                  },
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2100));
              startDate1 = startDate;
              fromTxt.text =
                  startDate1.toString().split(' 00:00:00.000').join();
            },
            icon: Icon(Icons.calendar_month)),
      ),
      MyTextFormField(
        hintText: 'تاريخ نهاية الحجز',
        controller: toTxt,
        readOnly: true,
        suffixIcon: IconButton(
            onPressed: () async {
              DateTime? startDate = await showDatePicker(
                  builder: (context, child) {
                    return Theme(data: ThemeData.dark(), child: child!);
                  },
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2100));
              lastDate1 = startDate;
              toTxt.text = lastDate1.toString().split(' 00:00:00.000').join();
            },
            icon: Icon(Icons.calendar_month)),
      ),
      InkWell(
        onTap: () async {
          print("555");
          x = await b.addBookingwithObjectByUserIdAndCarId(
              context: context,
              b: Booking(from: fromTxt.text, to: toTxt.text),
              carId: carId,
              userId: userId);
          box.write('pop', x);
          print("$x 1324765324");
          print(box.read('pop'));
          
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colorprimarygreen,
            ),
            width: 280,
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("حفظ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: colorprimarywhite)),
                Padding(padding: EdgeInsets.all(8)),
                Icon(
                  size: 25,
                  Icons.add,
                  color: colorprimarywhite,
                )
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
