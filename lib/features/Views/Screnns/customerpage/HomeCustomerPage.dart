import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/features/Models/Users/Profile.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/SignupPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/ViewBrandPage.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HoemCustomerPage extends StatefulWidget {
  const HoemCustomerPage({super.key});

  @override
  State<HoemCustomerPage> createState() => _HoemCustomerPageState();
}

class _HoemCustomerPageState extends State<HoemCustomerPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserVM>(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // appBar: AppBar(
        //   actions: [
        //     Row(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         IconButton(
        //             onPressed: () async {
        //               await showDialog(
        //                 context: context,
        //                 builder: (context) {
        //                   return AlertDialog(
        //                     content: Text("back from Home Page"),
        //                     title: Text("Are you sure"),
        //                     actions: [
        //                       ElevatedButton(
        //                           onPressed: () async {
        //                             userProvider.logout();
        //                             final prefs =
        //                                 await SharedPreferences.getInstance();
        //                             prefs.setBool('token', false);
        //                             Navigator.pushReplacement(context,
        //                                 MaterialPageRoute(
        //                               builder: (context) {
        //                                 return SignupPage();
        //                               },
        //                             ));
        //                           },
        //                           child: Text("OK")),
        //                       ElevatedButton(
        //                           onPressed: () {
        //                             Navigator.pop(context);
        //                           },
        //                           child: Text("Cancel"))
        //                     ],
        //                   );
        //                 },
        //               );
        //             },
        //             icon: Icon(Icons.logout)),
        //         SizedBox(
        //           width: 14,
        //         ),
        //         Text(' صفحة العملاء الرئيسية ', style: TextStyle(fontSize: 20)),
        //         SizedBox(
        //           width: 22,
        //         ),
        //         TextButton(
        //             onPressed: () {
        //               setState(() {});
        //             },
        //             child: Text(
        //               "تحديث",
        //               style: TextStyle(color: colorprimarywhite),
        //             )),
        //         SizedBox(
        //           width: 6,
        //         )
        //       ],
        //     ),
        //   ],
        //   backgroundColor: colorprimarygreen,
        // ),

        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 150,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                    future: userProvider.getAllBranchesActiveFromAPi(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return Center(child: Text("Empty"));
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return snapshot.data![index].roles == 'branch'
                                ? InkWell(
                                    onTap: () {
                                      final box = GetStorage();
                                      box.write('id_user_branch',
                                          snapshot.data![index].id);
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return ViewPrandPage();
                                        },
                                      ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        color:
                                            Color.fromARGB(255, 140, 220, 173),
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Container(
                                                color: Colors.grey,
                                                width: 200,
                                                height: 200,
                                                child: Image.network(snapshot
                                                    .data![index].image!),
                                              ),
                                              Text(
                                                  snapshot
                                                      .data![index].fullName!,
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                              Text(snapshot.data![index].email!,
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                              Text(snapshot.data![index].phone!,
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                              Text(
                                                  "العنوان : ${snapshot.data![index].location!}",
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                            ],
                                          ),
                                        ),
                                      ),
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
        ),
      ),
    );
  }
}
