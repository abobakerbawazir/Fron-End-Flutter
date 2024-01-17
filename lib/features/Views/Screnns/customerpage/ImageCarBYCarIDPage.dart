import 'package:booking_car_project_flutter/features/ViewModels/CarVM.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class ImageCarByCarIdPage extends StatefulWidget {
  const ImageCarByCarIdPage({super.key});

  @override
  State<ImageCarByCarIdPage> createState() => _ImageCarByCarIdPageState();
}

class _ImageCarByCarIdPageState extends State<ImageCarByCarIdPage> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarVM>(context);
    final car_id_Image = box.read("car_id_ImageAll") ?? 0;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text("جميع صور السيارة")),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  future:
                      carProvider.getallImageCarBYCarId(car_id: car_id_Image),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return Center(
                            child: Text(
                          "ليس هناك صور لهذه السيارة",
                          style: TextStyle(fontSize: 17),
                        ));
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  (index + 1).toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      child: Image.network(snapshot
                                          .data![index].url
                                          .toString())),
                                )
                              ],
                            ),
                          );
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
    );
  }
}
