import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/core/Constans/Api_Url.dart';
import 'package:booking_car_project_flutter/features/Models/Users/Profile.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MangeUserPage extends StatefulWidget {
  const MangeUserPage({super.key});

  @override
  State<MangeUserPage> createState() => _MangeUserPageState();
}

class _MangeUserPageState extends State<MangeUserPage> {
  int x = 1;
  int y = 1;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserVM>(context);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          //appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: colorprimarygrey,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 90,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: x != 1
                                      ? colorprimarywhite
                                      : const Color.fromARGB(255, 19, 74, 120)),
                              onPressed: () {
                                x = 1;
                                // y = 0;
                                setState(() {});
                              },
                              child: Text(
                                "الكل",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: x != 1
                                        ? Colors.black
                                        : colorprimarywhite),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 110,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: x != 2
                                      ? colorprimarywhite
                                      : const Color.fromARGB(255, 19, 74, 120)),
                              onPressed: () {
                                x = 2;
                                // y = 0;
                                setState(() {});
                              },
                              child: Text(
                                "الفروع",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: x != 2
                                        ? Colors.black
                                        : colorprimarywhite),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 110,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: x != 3
                                      ? colorprimarywhite
                                      : const Color.fromARGB(255, 19, 74, 120)),
                              onPressed: () {
                                x = 3;
                                // y = 0;
                                setState(() {});
                              },
                              child: Text(
                                "العملاء",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: x != 3
                                        ? Colors.black
                                        : colorprimarywhite),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(8)),
                x == 1
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "جميع الحسابات",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: (MediaQuery.of(context).size.height - 275),
                            width: MediaQuery.of(context).size.width,
                            child: FutureBuilder(
                              future: userProvider
                                  .getAllBranchesActiveOrAllUserFromAPi(
                                      url: APIurl.viewAlluserDoesNotAdmin),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.isEmpty) {
                                    return Center(child: Text("Empty"));
                                  }
                                  return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 213, 208, 192),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          margin: EdgeInsets.all(5),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () async {
                                                        AwesomeDialog(
                                                          context: context,
                                                          dialogType: DialogType
                                                              .warning,
                                                          headerAnimationLoop:
                                                              false,
                                                          animType:
                                                              AnimType.topSlide,
                                                          showCloseIcon: true,
                                                          closeIcon: const Icon(
                                                              Icons
                                                                  .close_fullscreen_outlined),
                                                          title: 'تحذير',
                                                          desc:
                                                              '''${snapshot.data![index].username} : هل تريد حذف المستخدم   
                                                              \nاذا تم حذفه لايمكنه الرجوع بهذا الحساب مرة اخرى''',
                                                          btnCancelOnPress:
                                                              () {},
                                                          onDismissCallback:
                                                              (type) {
                                                            debugPrint(
                                                                'Dialog Dismiss from callback $type');
                                                          },
                                                          btnOkOnPress:
                                                              () async {
                                                            final code = await userProvider
                                                                .deleteUser(
                                                                    id: snapshot
                                                                        .data![
                                                                            index]
                                                                        .id!);
                                                            if (code == 200) {
                                                              AwesomeDialog(
                                                                context:
                                                                    context,
                                                                animType: AnimType
                                                                    .leftSlide,
                                                                headerAnimationLoop:
                                                                    false,
                                                                dialogType:
                                                                    DialogType
                                                                        .success,
                                                                showCloseIcon:
                                                                    true,
                                                                title: 'نجاح',
                                                                desc:
                                                                    'تم الحذف بنجاح',
                                                                btnOkOnPress:
                                                                    () {
                                                                  debugPrint(
                                                                      'OnClcik');
                                                                },
                                                                btnOkIcon: Icons
                                                                    .check_circle,
                                                              ).show();
                                                            } else {
                                                              AwesomeDialog(
                                                                context:
                                                                    context,
                                                                dialogType:
                                                                    DialogType
                                                                        .error,
                                                                animType: AnimType
                                                                    .rightSlide,
                                                                headerAnimationLoop:
                                                                    false,
                                                                title: 'فشل',
                                                                desc:
                                                                    'فشلت عملية الحذف',
                                                                btnOkOnPress:
                                                                    () {},
                                                                btnOkIcon: Icons
                                                                    .cancel,
                                                                btnOkColor:
                                                                    Colors.red,
                                                              ).show();
                                                            }
                                                          },
                                                        ).show();

                                                        print(
                                                            "${snapshot.data![index].id}");
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      )),
                                                  snapshot.data![index]
                                                                  .active ==
                                                              0 &&
                                                          snapshot.data![index]
                                                                  .roles ==
                                                              'branch'
                                                      ? SizedBox(
                                                          width: 40,
                                                        )
                                                      : SizedBox(
                                                          width: 75,
                                                        ),
                                                  snapshot.data![index]
                                                                  .active ==
                                                              0 &&
                                                          snapshot.data![index]
                                                                  .roles ==
                                                              'branch'
                                                      ? ElevatedButton(
                                                          onPressed: () async {
                                                            var x = snapshot
                                                                .data![index]
                                                                .active;
                                                            var y = snapshot
                                                                .data![index]
                                                                .roles;
                                                            if (x == 0 &&
                                                                y == 'branch') {
                                                              x = 1;
                                                            }
                                                            await AwesomeDialog(
                                                              context: context,
                                                              animType: AnimType
                                                                  .leftSlide,
                                                              headerAnimationLoop:
                                                                  false,
                                                              dialogType:
                                                                  DialogType
                                                                      .question,
                                                              showCloseIcon:
                                                                  true,
                                                              title:
                                                                  "هل أنت متأكد",
                                                              desc:
                                                                  '''حساب نشط ${snapshot.data![index].username} هل تريد ان يكون  ''',
                                                              btnOkOnPress:
                                                                  () async {
                                                                await userProvider.confirmBranchFromAdmin(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .id!
                                                                        .toString(),
                                                                    Profile(
                                                                        active:
                                                                            x),
                                                                    context);
                                                              },
                                                              btnCancelOnPress:
                                                                  () {},
                                                              btnOkIcon: Icons
                                                                  .check_circle,
                                                              btnCancelIcon:
                                                                  Icons.cancel,
                                                              onDismissCallback:
                                                                  (type) {
                                                                debugPrint(
                                                                    'Dialog Dissmiss from callback $type');
                                                              },
                                                            ).show();
                                                          },
                                                          child: Text(
                                                              "تأكيد الحساب كحساب نشط"))
                                                      : ElevatedButton(
                                                          child: Text(
                                                              "الحساب نشط"),
                                                          onPressed: () {},
                                                        ),
                                                ],
                                              ),
                                              Text((index + 1).toString()),
                                              Text(
                                                  "أسم المستخدم : ${snapshot.data![index].username!}"),
                                              Text(
                                                  "الاسم الكامل : ${snapshot.data![index].fullName!}"),
                                              Text(
                                                  "الايميل : ${snapshot.data![index].email!}"),
                                              Text(
                                                  "نوع المستخدم : ${snapshot.data![index].roles!}"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("حالة الحساب"),
                                                  Text(" : "),
                                                  Text(snapshot.data![index]
                                                                  .active ==
                                                              1 &&
                                                          snapshot.data![index]
                                                                  .roles ==
                                                              'branch'
                                                      ? "حساب فرع نشط"
                                                      : snapshot.data![index]
                                                                      .active ==
                                                                  0 &&
                                                              snapshot
                                                                      .data![
                                                                          index]
                                                                      .roles ==
                                                                  'branch'
                                                          ? "حساب فرع غير نشط"
                                                          : "حساب عميل"),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          )
                        ],
                      )
                    : x == 2
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: y != 1
                                              ? colorprimarywhite
                                              : const Color.fromARGB(
                                                  255, 19, 74, 120)),
                                      onPressed: () {
                                        y = 1;
                                        setState(() {});
                                      },
                                      child: Text(
                                        'الفروع النشطة',
                                        style: TextStyle(
                                            color: y != 1
                                                ? Colors.black
                                                : colorprimarywhite),
                                      )),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: y != 2
                                              ? colorprimarywhite
                                              : const Color.fromARGB(
                                                  255, 19, 74, 120)),
                                      onPressed: () {
                                        y = 2;
                                        setState(() {});
                                      },
                                      child: Text(
                                        'الفروع الغير النشطة',
                                        style: TextStyle(
                                            color: y != 2
                                                ? Colors.black
                                                : colorprimarywhite),
                                      )),
                                ],
                              ),
                              y == 1
                                  ? SizedBox(
                                      height:
                                          (MediaQuery.of(context).size.height -
                                              280),
                                      width: MediaQuery.of(context).size.width,
                                      child: FutureBuilder(
                                        future:
                                            userProvider.viewAlluserByRoleName(
                                                name: 'branch', id: 1),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data!.isEmpty) {
                                              return Center(
                                                  child: Text("Empty"));
                                            }
                                            return ListView.builder(
                                              itemCount: snapshot.data!.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              213,
                                                              208,
                                                              192),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  margin: EdgeInsets.all(5),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                              onPressed:
                                                                  () async {
                                                                AwesomeDialog(
                                                                  context:
                                                                      context,
                                                                  dialogType:
                                                                      DialogType
                                                                          .warning,
                                                                  headerAnimationLoop:
                                                                      false,
                                                                  animType: AnimType
                                                                      .topSlide,
                                                                  showCloseIcon:
                                                                      true,
                                                                  closeIcon:
                                                                      const Icon(
                                                                          Icons
                                                                              .close_fullscreen_outlined),
                                                                  title:
                                                                      'تحذير',
                                                                  desc:
                                                                      '''${snapshot.data![index].username} : هل تريد حذف المستخدم   
                                                              \nاذا تم حذفه لايمكنه الرجوع بهذا الحساب مرة اخرى''',
                                                                  btnCancelOnPress:
                                                                      () {},
                                                                  onDismissCallback:
                                                                      (type) {
                                                                    debugPrint(
                                                                        'Dialog Dismiss from callback $type');
                                                                  },
                                                                  btnOkOnPress:
                                                                      () async {
                                                                    final code = await userProvider.deleteUser(
                                                                        id: snapshot
                                                                            .data![index]
                                                                            .id!);
                                                                    if (code ==
                                                                        200) {
                                                                      AwesomeDialog(
                                                                        context:
                                                                            context,
                                                                        animType:
                                                                            AnimType.leftSlide,
                                                                        headerAnimationLoop:
                                                                            false,
                                                                        dialogType:
                                                                            DialogType.success,
                                                                        showCloseIcon:
                                                                            true,
                                                                        title:
                                                                            'نجاح',
                                                                        desc:
                                                                            'تم الحذف بنجاح',
                                                                        btnOkOnPress:
                                                                            () {
                                                                          debugPrint(
                                                                              'OnClcik');
                                                                        },
                                                                        btnOkIcon:
                                                                            Icons.check_circle,
                                                                      ).show();
                                                                    } else {
                                                                      AwesomeDialog(
                                                                        context:
                                                                            context,
                                                                        dialogType:
                                                                            DialogType.error,
                                                                        animType:
                                                                            AnimType.rightSlide,
                                                                        headerAnimationLoop:
                                                                            false,
                                                                        title:
                                                                            'فشل',
                                                                        desc:
                                                                            'فشلت عملية الحذف',
                                                                        btnOkOnPress:
                                                                            () {},
                                                                        btnOkIcon:
                                                                            Icons.cancel,
                                                                        btnOkColor:
                                                                            Colors.red,
                                                                      ).show();
                                                                    }
                                                                  },
                                                                ).show();

                                                                print(
                                                                    "${snapshot.data![index].id}");
                                                              },
                                                              icon: Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                              )),
                                                          snapshot.data![index]
                                                                          .active ==
                                                                      0 &&
                                                                  snapshot
                                                                          .data![
                                                                              index]
                                                                          .roles ==
                                                                      'branch'
                                                              ? SizedBox(
                                                                  width: 40,
                                                                )
                                                              : SizedBox(
                                                                  width: 75,
                                                                ),
                                                          snapshot.data![index]
                                                                          .active ==
                                                                      0 &&
                                                                  snapshot
                                                                          .data![
                                                                              index]
                                                                          .roles ==
                                                                      'branch'
                                                              ? ElevatedButton(
                                                                  onPressed:
                                                                      () async {
                                                                    var x = snapshot
                                                                        .data![
                                                                            index]
                                                                        .active;
                                                                    var y = snapshot
                                                                        .data![
                                                                            index]
                                                                        .roles;
                                                                    if (x ==
                                                                            0 &&
                                                                        y ==
                                                                            'branch') {
                                                                      x = 1;
                                                                    }
                                                                    await AwesomeDialog(
                                                                      context:
                                                                          context,
                                                                      animType:
                                                                          AnimType
                                                                              .leftSlide,
                                                                      headerAnimationLoop:
                                                                          false,
                                                                      dialogType:
                                                                          DialogType
                                                                              .question,
                                                                      showCloseIcon:
                                                                          true,
                                                                      title:
                                                                          "هل أنت متأكد",
                                                                      desc:
                                                                          '''حساب نشط ${snapshot.data![index].username} هل تريد ان يكون  ''',
                                                                      btnOkOnPress:
                                                                          () async {
                                                                        await userProvider.confirmBranchFromAdmin(
                                                                            snapshot.data![index].id!.toString(),
                                                                            Profile(active: x),
                                                                            context);
                                                                      },
                                                                      btnCancelOnPress:
                                                                          () {},
                                                                      btnOkIcon:
                                                                          Icons
                                                                              .check_circle,
                                                                      btnCancelIcon:
                                                                          Icons
                                                                              .cancel,
                                                                      onDismissCallback:
                                                                          (type) {
                                                                        debugPrint(
                                                                            'Dialog Dissmiss from callback $type');
                                                                      },
                                                                    ).show();
                                                                  },
                                                                  child: Text(
                                                                      "تأكيد الحساب كحساب نشط"))
                                                              : ElevatedButton(
                                                                  child: Text(
                                                                      "الحساب نشط"),
                                                                  onPressed:
                                                                      () {},
                                                                ),
                                                        ],
                                                      ),
                                                      Text((index + 1)
                                                          .toString()),
                                                      Text(
                                                          "أسم المستخدم : ${snapshot.data![index].username!}"),
                                                      Text(
                                                          "الاسم الكامل : ${snapshot.data![index].fullName!}"),
                                                      Text(
                                                          "الايميل : ${snapshot.data![index].email!}"),
                                                      Text(
                                                          "نوع المستخدم : ${snapshot.data![index].role!}"),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text("حالة الحساب"),
                                                          Text(" : "),
                                                          Text(snapshot
                                                                          .data![
                                                                              index]
                                                                          .active ==
                                                                      1 &&
                                                                  snapshot
                                                                          .data![
                                                                              index]
                                                                          .roles ==
                                                                      'branch'
                                                              ? "حساب فرع نشط"
                                                              : snapshot.data![index].active ==
                                                                          0 &&
                                                                      snapshot.data![index]
                                                                              .roles ==
                                                                          'branch'
                                                                  ? "حساب فرع غير نشط"
                                                                  : "حساب عميل"),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        },
                                      ),
                                    )
                                  : y == 2
                                      ? SizedBox(
                                          height: (MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              280),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: FutureBuilder(
                                            future: userProvider
                                                .viewAlluserByRoleName(
                                                    name: 'branch'),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                if (snapshot.data!.isEmpty) {
                                                  return Center(
                                                      child: Text("Empty"));
                                                }
                                                return ListView.builder(
                                                  itemCount:
                                                      snapshot.data!.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              213, 208, 192),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      margin: EdgeInsets.all(5),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    AwesomeDialog(
                                                                      context:
                                                                          context,
                                                                      dialogType:
                                                                          DialogType
                                                                              .warning,
                                                                      headerAnimationLoop:
                                                                          false,
                                                                      animType:
                                                                          AnimType
                                                                              .topSlide,
                                                                      showCloseIcon:
                                                                          true,
                                                                      closeIcon:
                                                                          const Icon(
                                                                              Icons.close_fullscreen_outlined),
                                                                      title:
                                                                          'تحذير',
                                                                      desc:
                                                                          '''${snapshot.data![index].username} : هل تريد حذف المستخدم   
                                                              \nاذا تم حذفه لايمكنه الرجوع بهذا الحساب مرة اخرى''',
                                                                      btnCancelOnPress:
                                                                          () {},
                                                                      onDismissCallback:
                                                                          (type) {
                                                                        debugPrint(
                                                                            'Dialog Dismiss from callback $type');
                                                                      },
                                                                      btnOkOnPress:
                                                                          () async {
                                                                        final code =
                                                                            await userProvider.deleteUser(id: snapshot.data![index].id!);
                                                                        if (code ==
                                                                            200) {
                                                                          AwesomeDialog(
                                                                            context:
                                                                                context,
                                                                            animType:
                                                                                AnimType.leftSlide,
                                                                            headerAnimationLoop:
                                                                                false,
                                                                            dialogType:
                                                                                DialogType.success,
                                                                            showCloseIcon:
                                                                                true,
                                                                            title:
                                                                                'نجاح',
                                                                            desc:
                                                                                'تم الحذف بنجاح',
                                                                            btnOkOnPress:
                                                                                () {
                                                                              debugPrint('OnClcik');
                                                                            },
                                                                            btnOkIcon:
                                                                                Icons.check_circle,
                                                                          ).show();
                                                                        } else {
                                                                          AwesomeDialog(
                                                                            context:
                                                                                context,
                                                                            dialogType:
                                                                                DialogType.error,
                                                                            animType:
                                                                                AnimType.rightSlide,
                                                                            headerAnimationLoop:
                                                                                false,
                                                                            title:
                                                                                'فشل',
                                                                            desc:
                                                                                'فشلت عملية الحذف',
                                                                            btnOkOnPress:
                                                                                () {},
                                                                            btnOkIcon:
                                                                                Icons.cancel,
                                                                            btnOkColor:
                                                                                Colors.red,
                                                                          ).show();
                                                                        }
                                                                      },
                                                                    ).show();

                                                                    print(
                                                                        "${snapshot.data![index].id}");
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .red,
                                                                  )),
                                                              snapshot.data![index].active ==
                                                                          0 &&
                                                                      snapshot.data![index]
                                                                              .roles ==
                                                                          'branch'
                                                                  ? SizedBox(
                                                                      width: 40,
                                                                    )
                                                                  : SizedBox(
                                                                      width: 75,
                                                                    ),
                                                              snapshot.data![index].active ==
                                                                          0 &&
                                                                      snapshot.data![index].roles ==
                                                                          'branch'
                                                                  ? ElevatedButton(
                                                                      onPressed:
                                                                          () async {
                                                                        var x = snapshot
                                                                            .data![index]
                                                                            .active;
                                                                        var y = snapshot
                                                                            .data![index]
                                                                            .roles;
                                                                        if (x ==
                                                                                0 &&
                                                                            y ==
                                                                                'branch') {
                                                                          x = 1;
                                                                        }
                                                                        await AwesomeDialog(
                                                                          context:
                                                                              context,
                                                                          animType:
                                                                              AnimType.leftSlide,
                                                                          headerAnimationLoop:
                                                                              false,
                                                                          dialogType:
                                                                              DialogType.question,
                                                                          showCloseIcon:
                                                                              true,
                                                                          title:
                                                                              "هل أنت متأكد",
                                                                          desc:
                                                                              '''حساب نشط ${snapshot.data![index].username} هل تريد ان يكون  ''',
                                                                          btnOkOnPress:
                                                                              () async {
                                                                            await userProvider.confirmBranchFromAdmin(
                                                                                snapshot.data![index].id!.toString(),
                                                                                Profile(active: x),
                                                                                context);
                                                                          },
                                                                          btnCancelOnPress:
                                                                              () {},
                                                                          btnOkIcon:
                                                                              Icons.check_circle,
                                                                          btnCancelIcon:
                                                                              Icons.cancel,
                                                                          onDismissCallback:
                                                                              (type) {
                                                                            debugPrint('Dialog Dissmiss from callback $type');
                                                                          },
                                                                        ).show();
                                                                      },
                                                                      child: Text(
                                                                          "تأكيد الحساب كحساب نشط"))
                                                                  : ElevatedButton(
                                                                      child: Text(
                                                                          "الحساب نشط"),
                                                                      onPressed:
                                                                          () {},
                                                                    ),
                                                            ],
                                                          ),
                                                          Text((index + 1)
                                                              .toString()),
                                                          Text(
                                                              "أسم المستخدم : ${snapshot.data![index].username!}"),
                                                          Text(
                                                              "الاسم الكامل : ${snapshot.data![index].fullName!}"),
                                                          Text(
                                                              "الايميل : ${snapshot.data![index].email!}"),
                                                          Text(
                                                              "نوع المستخدم : ${snapshot.data![index].role!}"),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  "حالة الحساب"),
                                                              Text(" : "),
                                                              Text(snapshot.data![index].active ==
                                                                          1 &&
                                                                      snapshot.data![index].roles ==
                                                                          'branch'
                                                                  ? "حساب فرع نشط"
                                                                  : snapshot.data![index].active ==
                                                                              0 &&
                                                                          snapshot.data![index].roles ==
                                                                              'branch'
                                                                      ? "حساب فرع غير نشط"
                                                                      : "حساب عميل"),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            },
                                          ),
                                        )
                                      : Container(
                                          child: Text(
                                            "يرجى اختيار احد الفروع",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        )
                            ],
                          )
                        : x == 3
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "حسابات العملاء فقط",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        (MediaQuery.of(context).size.height -
                                            270),
                                    width: MediaQuery.of(context).size.width,
                                    child: FutureBuilder(
                                      future:
                                          userProvider.viewAlluserByRoleName(
                                              name: 'customer'),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data!.isEmpty) {
                                            return Center(child: Text("Empty"));
                                          }
                                          return ListView.builder(
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 213, 208, 192),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                margin: EdgeInsets.all(5),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed:
                                                                () async {
                                                              AwesomeDialog(
                                                                context:
                                                                    context,
                                                                dialogType:
                                                                    DialogType
                                                                        .warning,
                                                                headerAnimationLoop:
                                                                    false,
                                                                animType: AnimType
                                                                    .topSlide,
                                                                showCloseIcon:
                                                                    true,
                                                                closeIcon:
                                                                    const Icon(Icons
                                                                        .close_fullscreen_outlined),
                                                                title: 'تحذير',
                                                                desc:
                                                                    '''${snapshot.data![index].username} : هل تريد حذف المستخدم   
                                                              \nاذا تم حذفه لايمكنه الرجوع بهذا الحساب مرة اخرى''',
                                                                btnCancelOnPress:
                                                                    () {},
                                                                onDismissCallback:
                                                                    (type) {
                                                                  debugPrint(
                                                                      'Dialog Dismiss from callback $type');
                                                                },
                                                                btnOkOnPress:
                                                                    () async {
                                                                  final code = await userProvider.deleteUser(
                                                                      id: snapshot
                                                                          .data![
                                                                              index]
                                                                          .id!);
                                                                  if (code ==
                                                                      200) {
                                                                    AwesomeDialog(
                                                                      context:
                                                                          context,
                                                                      animType:
                                                                          AnimType
                                                                              .leftSlide,
                                                                      headerAnimationLoop:
                                                                          false,
                                                                      dialogType:
                                                                          DialogType
                                                                              .success,
                                                                      showCloseIcon:
                                                                          true,
                                                                      title:
                                                                          'نجاح',
                                                                      desc:
                                                                          'تم الحذف بنجاح',
                                                                      btnOkOnPress:
                                                                          () {
                                                                        debugPrint(
                                                                            'OnClcik');
                                                                      },
                                                                      btnOkIcon:
                                                                          Icons
                                                                              .check_circle,
                                                                    ).show();
                                                                  } else {
                                                                    AwesomeDialog(
                                                                      context:
                                                                          context,
                                                                      dialogType:
                                                                          DialogType
                                                                              .error,
                                                                      animType:
                                                                          AnimType
                                                                              .rightSlide,
                                                                      headerAnimationLoop:
                                                                          false,
                                                                      title:
                                                                          'فشل',
                                                                      desc:
                                                                          'فشلت عملية الحذف',
                                                                      btnOkOnPress:
                                                                          () {},
                                                                      btnOkIcon:
                                                                          Icons
                                                                              .cancel,
                                                                      btnOkColor:
                                                                          Colors
                                                                              .red,
                                                                    ).show();
                                                                  }
                                                                },
                                                              ).show();

                                                              print(
                                                                  "${snapshot.data![index].id}");
                                                            },
                                                            icon: Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                            )),
                                                        snapshot.data![index]
                                                                        .active ==
                                                                    0 &&
                                                                snapshot
                                                                        .data![
                                                                            index]
                                                                        .roles ==
                                                                    'branch'
                                                            ? SizedBox(
                                                                width: 40,
                                                              )
                                                            : SizedBox(
                                                                width: 75,
                                                              ),
                                                        snapshot.data![index]
                                                                        .active ==
                                                                    0 &&
                                                                snapshot
                                                                        .data![
                                                                            index]
                                                                        .roles ==
                                                                    'branch'
                                                            ? ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  var x = snapshot
                                                                      .data![
                                                                          index]
                                                                      .active;
                                                                  var y = snapshot
                                                                      .data![
                                                                          index]
                                                                      .roles;
                                                                  if (x == 0 &&
                                                                      y ==
                                                                          'branch') {
                                                                    x = 1;
                                                                  }
                                                                  await AwesomeDialog(
                                                                    context:
                                                                        context,
                                                                    animType:
                                                                        AnimType
                                                                            .leftSlide,
                                                                    headerAnimationLoop:
                                                                        false,
                                                                    dialogType:
                                                                        DialogType
                                                                            .question,
                                                                    showCloseIcon:
                                                                        true,
                                                                    title:
                                                                        "هل أنت متأكد",
                                                                    desc:
                                                                        '''حساب نشط ${snapshot.data![index].username} هل تريد ان يكون  ''',
                                                                    btnOkOnPress:
                                                                        () async {
                                                                      await userProvider.confirmBranchFromAdmin(
                                                                          snapshot
                                                                              .data![index]
                                                                              .id!
                                                                              .toString(),
                                                                          Profile(active: x),
                                                                          context);
                                                                    },
                                                                    btnCancelOnPress:
                                                                        () {},
                                                                    btnOkIcon: Icons
                                                                        .check_circle,
                                                                    btnCancelIcon:
                                                                        Icons
                                                                            .cancel,
                                                                    onDismissCallback:
                                                                        (type) {
                                                                      debugPrint(
                                                                          'Dialog Dissmiss from callback $type');
                                                                    },
                                                                  ).show();
                                                                },
                                                                child: Text(
                                                                    "تأكيد الحساب كحساب نشط"))
                                                            : ElevatedButton(
                                                                child: Text(
                                                                    "الحساب نشط"),
                                                                onPressed:
                                                                    () {},
                                                              ),
                                                      ],
                                                    ),
                                                    Text(
                                                        (index + 1).toString()),
                                                    Text(
                                                        "أسم المستخدم : ${snapshot.data![index].username!}"),
                                                    Text(
                                                        "الاسم الكامل : ${snapshot.data![index].fullName!}"),
                                                    Text(
                                                        "الايميل : ${snapshot.data![index].email!}"),
                                                    Text(
                                                        "نوع المستخدم : ${snapshot.data![index].role!}"),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text("حالة الحساب"),
                                                        Text(" : "),
                                                        Text(snapshot
                                                                        .data![
                                                                            index]
                                                                        .active ==
                                                                    1 &&
                                                                snapshot
                                                                        .data![
                                                                            index]
                                                                        .roles ==
                                                                    'branch'
                                                            ? "حساب فرع نشط"
                                                            : snapshot.data![index].active ==
                                                                        0 &&
                                                                    snapshot.data![index]
                                                                            .roles ==
                                                                        'branch'
                                                                ? "حساب فرع غير نشط"
                                                                : "حساب عميل"),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        }
                                        return Center(
                                            child: CircularProgressIndicator());
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                child: Text("يرجى أختيار احد الخيارات الثلاثة"),
                              )
              ],
            )),
          ),
        ));
  }
}
