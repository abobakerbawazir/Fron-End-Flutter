import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/features/Models/Users/Profile.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MangeUserScreens extends StatefulWidget {
  const MangeUserScreens({super.key});

  @override
  State<MangeUserScreens> createState() => _MangeUserScreensState();
}

class _MangeUserScreensState extends State<MangeUserScreens> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserVM>(context);

    return Scaffold(
      body: Container(
        height: (MediaQuery.of(context).size.height / 2),
        color: colorprimarygreen,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              height: (MediaQuery.of(context).size.height / 2) - 25,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: userProvider.getAllUsersFromAPi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(child: Text("Empty"));
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return snapshot.data![index].roles == 'branch'
                            ? Container(
                                decoration: BoxDecoration(
                                    color: colorprimarywhite,
                                    borderRadius: BorderRadius.circular(20)),
                                margin: EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    snapshot.data![index].active == 0
                                        ? ElevatedButton(
                                            onPressed: () async {
                                              var x =
                                                  snapshot.data![index].active;
                                              if (x == 0) {
                                                x = 1;
                                              }
                                              await AwesomeDialog(
                                                context: context,
                                                animType: AnimType.leftSlide,
                                                headerAnimationLoop: false,
                                                dialogType: DialogType.question,
                                                showCloseIcon: true,
                                                title: "هل أنت متأكد",
                                                desc:
                                                    '''حساب نشط ${snapshot.data![index].username} هل تريد ان يكون  ''',
                                                btnOkOnPress: () async {
                                                  await userProvider
                                                      .confirmBranchFromAdmin(
                                                          snapshot
                                                              .data![index].id!
                                                              .toString(),
                                                          Profile(active: x),
                                                          context);
                                                },
                                                btnCancelOnPress: () {},
                                                btnOkIcon: Icons.check_circle,
                                                btnCancelIcon: Icons.cancel,
                                                onDismissCallback: (type) {
                                                  debugPrint(
                                                      'Dialog Dissmiss from callback $type');
                                                },
                                              ).show();
                                            },
                                            child:
                                                Text("تأكيد الحساب كحساب نشط"))

                                        // IconButton(
                                        //     onPressed: () async {
                                        //       var x = snapshot
                                        //           .data![index].active;
                                        //       if (x == 0) {
                                        //         x = 1;
                                        //       }
                                        //       await AwesomeDialog(
                                        //         context: context,
                                        //         animType: AnimType.leftSlide,
                                        //         headerAnimationLoop: false,
                                        //         dialogType:
                                        //             DialogType.success,
                                        //         showCloseIcon: true,
                                        //         title: "هل أنت متأكد",
                                        //         desc:
                                        //             '''حساب نشط ${snapshot.data![index].username} هل تريد ان يكون  ''',
                                        //         btnOkOnPress: () async {
                                        //           await userProvider
                                        //               .confirmBranchFromAdmin(
                                        //                   snapshot
                                        //                       .data![index]
                                        //                       .id!
                                        //                       .toString(),
                                        //                   Profile(active: x),
                                        //                   context);
                                        //         },
                                        //         btnOkIcon: Icons.check_circle,
                                        //         onDismissCallback: (type) {
                                        //           debugPrint(
                                        //               'Dialog Dissmiss from callback $type');
                                        //         },
                                        //       ).show();
                                        //     },
                                        //     icon: Icon(Icons.edit))

                                        : ElevatedButton(
                                            child: Text("الحساب نشط"),
                                            onPressed: () {},
                                          ),
                                    Text(snapshot.data![index].username!),
                                    Text(snapshot.data![index].email!),
                                    Text(snapshot.data![index].roles!),
                                    Text(snapshot.data![index].active!
                                        .toString()),
                                  ],
                                ),
                              )
                            : Container();
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
