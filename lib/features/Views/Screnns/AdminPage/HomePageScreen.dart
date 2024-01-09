import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking_car_project_flutter/features/ViewModels/PrandVM.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/AddBrandPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/MangeUserScreens.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/SignupPage.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/My_drawerScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int x = 0;
  List<String> imagesAllPath = [
    "assets/prands/pngimg.com - car_logo_PNG1655.png",
    "assets/prands/pngimg.com - car_logo_PNG1656.png",
    "assets/prands/pngimg.com - car_logo_PNG1658.png",
    "assets/prands/prand1.png",
    "assets/prands/prand2.png",
    "assets/prands/prand3.png",
    "assets/prands/pngimg.com - car_logo_PNG1668.png",
    "assets/prands/pngimg.com - car_logo_PNG1669.png",
    "assets/prands/pngimg.com - car_logo_PNG1665.png"
  ];
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserVM>(context);
    final prsndProvider = Provider.of<PrandVM>(context);

    return Scaffold(
      //drawer: Drawer(child: My_drawerScreen()),
      //     Column(
      //   children: [
      //     SizedBox(
      //       height: 40,
      //     ),
      //     const SizedBox(
      //       height: 16,
      //     ),
      //     AnimatedButton(
      //       text: 'Question Dialog',
      //       color: Colors.amber,
      //       pressEvent: () {
      //         AwesomeDialog(
      //           context: context,
      //           dialogType: DialogType.question,
      //           animType: AnimType.rightSlide,
      //           headerAnimationLoop: true,
      //           title: 'Question',
      //           desc:
      //               'Dialog description here..................................................',
      //           btnOkOnPress: () {},
      //         ).show();
      //       },
      //     ),
      //     ElevatedButton(
      //         onPressed: () {
      //           userProvider.logout();
      //         },
      //         child: Text("تسجيل الخروج")),
      //   ],
      // )),

      // appBar: AppBar(actions: [IconButton(
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
      //        ],
      //   backgroundColor: colorprimarygreen,
      //   title: Text("الصفحة الرئيسية"),
      // ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset('assets/images/home.png'),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorprimarygreen),
                    onPressed: () {
                      x = 1;
                      setState(() {});
                    },
                    child: Text(
                      "ادارة الفروع",
                    )),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorprimarygreen),
                    onPressed: () {
                      x = 2;
                      setState(() {});
                    },
                    child: Text(
                      "ادارة الماركات",
                    ))
              ],
            ),
            x == 1
                ? SizedBox(
                    height: (MediaQuery.of(context).size.height / 2),
                    width: MediaQuery.of(context).size.width,
                    child: MangeUserScreens())
                // Card(
                //     child: SizedBox(
                //       height: MediaQuery.of(context).size.height,
                //       width: MediaQuery.of(context).size.width,
                //       child: FutureBuilder(
                //         future: userProvider.allUserslistOfMap(),
                //         builder: (context, snapshot) {
                //           if (snapshot.hasData) {
                //             return ListView.builder(
                //               itemCount: snapshot.data!.length,
                //               itemBuilder: (context, index) {
                //                 return Column(
                //                   children: [
                //                     IconButton(
                //                         onPressed: () {
                //                           // String x =
                //                           //     snapshot.data![index]['roles'][0]['name'];
                //                           // print(x);
                //                           String x =
                //                               snapshot.data![index]['roles'];
                //                           print(x);
                //                         },
                //                         icon: snapshot.data![index]
                //                                     ['roles'] ==
                //                                 'admin'
                //                             ? Icon(Icons.accessible)
                //                             : snapshot.data![index]
                //                                         ['roles'] ==
                //                                     'branch'
                //                                 ? Icon(Icons.delete)
                //                                 : Icon(Icons.edit)),
                //                     Text(snapshot.data![index]['username']),
                //                     Text(snapshot.data![index]['roles']
                //                         .toString()),
                //                   ],
                //                 );
                //               },
                //             );
                //           }
                //           return Center(child: CircularProgressIndicator());
                //         },
                //       ),
                //     ),
                //   )

                : x == 2
                    ? TextButton(
                        child:
                            Center(child: Text("الذهاب لصفحة ادارة الماركات")),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return AddPrandScrrens();
                            },
                          ));
                        },
                      )
                    : Card(
                        child: Center(
                            child: Text(
                          "يرجى اختيار احد الخيارين المتاحة",
                          style: TextStyle(fontSize: 20),
                        )),
                      )

            // FutureBuilder(
            //   future: prsndProvider.getAllPrandsFromAPi(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return Expanded(
            //         child: SizedBox(
            //           height: MediaQuery.of(context).size.height,
            //           width: MediaQuery.of(context).size.width,
            //           child: GridView.builder(
            //             itemCount: snapshot.data!.length,
            //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //                 childAspectRatio: 0.8,
            //                 crossAxisSpacing: 8,
            //                 mainAxisSpacing: 8,
            //                 crossAxisCount: 2),
            //             itemBuilder: (context, index) {
            //               return SizedBox(
            //                 width: MediaQuery.of(context).size.width,
            //                 height: MediaQuery.of(context).size.height,
            //                 child: Card(
            //                   child: Stack(
            //                     clipBehavior: Clip.none,
            //                     children: [
            //                       IconButton(
            //                           onPressed: () {},
            //                           icon: Icon(
            //                             Icons.favorite,
            //                             color: colorprimarygreen,
            //                           )),
            //                       Positioned(
            //                         top: 20,
            //                         right: 20,
            //                         child: SizedBox(
            //                             height: 140,
            //                             width: 140,
            //                             child: Image.network(
            //                                 snapshot.data![index].path ??
            //                                     snapshot.data![1].path!)),
            //                       ),
            //                       Positioned(
            //                         bottom: 20,
            //                         left: 20,
            //                         child: Wrap(
            //                           children: [
            //                             Text("${snapshot.data![index].name}",
            //                                 style: TextStyle(
            //                                   // fontWeight: FontWeight.bold,
            //                                   color: colorprimarygreen,
            //                                   fontSize: 20,
            //                                 )),
            //                           ],
            //                         ),
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //               );
            //             },
            //           ),
            //         ),
            //       );
            //     }
            //     return Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   },
            // )

            // Expanded(
            //   child: SizedBox(
            //     height: MediaQuery.of(context).size.height,
            //     width: MediaQuery.of(context).size.width,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: GridView.builder(
            //         clipBehavior: Clip.none,
            //         itemCount: imagesAllPath.length,
            //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //             childAspectRatio: 0.8,
            //             crossAxisSpacing: 30,
            //             mainAxisSpacing: 30,
            //             crossAxisCount: 2),
            //         itemBuilder: (context, index) {
            //           return SizedBox(
            //             width: MediaQuery.of(context).size.width,
            //             height: MediaQuery.of(context).size.height,
            //             child: Container(
            //               decoration: BoxDecoration(
            //                   color: Color.fromARGB(255, 54, 140, 75),
            //                   borderRadius: BorderRadius.circular(30)),
            //               child: Stack(
            //                 clipBehavior: Clip.none,
            //                 children: [
            //                   IconButton(
            //                       onPressed: () {},
            //                       icon: Icon(
            //                         Icons.favorite,
            //                         color: colorprimarywhite,
            //                       )),
            //                   Positioned(
            //                     top: 20,
            //                     right: 20,
            //                     child: SizedBox(
            //                         height: 140,
            //                         width: 140,
            //                         child: Image.asset(
            //                             fit: BoxFit.contain,
            //                             imagesAllPath[index])),
            //                   ),
            //                   Positioned(
            //                     bottom: 20,
            //                     left: 20,
            //                     child: Wrap(
            //                       children: [
            //                         Text("toyota",
            //                             style: TextStyle(
            //                               // fontWeight: FontWeight.bold,
            //                               color: colorprimarywhite,
            //                               fontSize: 20,
            //                             )),
            //                       ],
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //     ),
            //   ),
            // ),

            //Expanded(
            //   child: SingleChildScrollView(
            //       child: Container(
            //     child: GridView.count(
            //       childAspectRatio: 0.7,
            //       crossAxisSpacing: 7,
            //       mainAxisSpacing: 7,
            //       crossAxisCount: 2,
            //       shrinkWrap: true,
            //       children: List.generate(
            //           imagesAllPath.length,
            //           (index) => SizedBox(
            //                 height: MediaQuery.of(context).size.height,
            //                 child: Card(
            //                     child: Column(
            //                   mainAxisSize: MainAxisSize.min,
            //                   children: [
            //                     IconButton(
            //                         onPressed: () {},
            //                         icon: Icon(
            //                           Icons.favorite,
            //                           color: colorprimarygreen,
            //                         )),
            //                     Image.asset(
            //                       imagesAllPath[index],
            //                     ),
            //                   ],
            //                 )),
            //               )),
            //     ),
            //   )),
            // ),

            // Expanded(
            //   child: SizedBox(
            //     height: MediaQuery.of(context).size.height,
            //     width: MediaQuery.of(context).size.width,
            //     child: Card(
            //       color: colorprimarygreen,
            //       child: ListView.builder(
            //         itemCount: imagesAllPath.length,
            //         itemBuilder: (context, index) {
            //           return SizedBox(
            //             width: MediaQuery.of(context).size.width,
            //             height: MediaQuery.of(context).size.height / 2,
            //             child: Card(
            //               child: Column(
            //                 children: [
            //                   IconButton(
            //                       onPressed: () {},
            //                       icon: Icon(
            //                         Icons.favorite,
            //                         color: colorprimarygreen,
            //                       )),
            //                   SizedBox(
            //                       child: Image.asset(imagesAllPath[index])),
            //                 ],
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //     ),
            //   ),
            // ),

            // SizedBox(
            //   height: 300,
            //   width: 300,
            //   child: FutureBuilder(
            //     future: userProvider.getAllUsersFromAPi(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         if (snapshot.data!.isEmpty) {
            //           return Text("asdfgh");
            //         }
            //         return ListView.builder(
            //           itemCount: snapshot.data!.length,
            //           itemBuilder: (context, index) {
            //             return Text("${snapshot.data![index].email}");
            //           },
            //         );
            //       }
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
