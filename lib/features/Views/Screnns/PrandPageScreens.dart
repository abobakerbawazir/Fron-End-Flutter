import 'package:booking_car_project_flutter/features/ViewModels/PrandVM.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrandPageScreen extends StatefulWidget {
  const PrandPageScreen({super.key});

  @override
  State<PrandPageScreen> createState() => _PrandPageScreenState();
}

class _PrandPageScreenState extends State<PrandPageScreen> {
  @override
  Widget build(BuildContext context) {
    final prandProvider = Provider.of<PrandVM>(context);

    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: prandProvider.getAllPrandsFromAPi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Text("Empty");
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              child: Image.network(snapshot.data![index].path!,
                                  scale: 1.0),
                            ),
                            Text("${snapshot.data![index].name}"),
                          ],
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
