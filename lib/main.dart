import 'package:booking_car_project_flutter/features/ViewModels/TransactionVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/FillterPage/FillterPagePrand.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/Nav/AdminHoemNav.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/Nav/BranchHomeNav.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/Nav/CustomerHoemNav.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/SignUpPageWithImage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/asd.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/customerpage/ImageCarBYCarIDPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/customerpage/ProfileCustomerPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/customerpage/editProfile.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:booking_car_project_flutter/features/Models/Booking/BookingCoustomerByBranch.dart';
import 'package:booking_car_project_flutter/features/ViewModels/BookingCoustomerByBranchVM.dart';
import 'package:booking_car_project_flutter/features/ViewModels/BookingVM.dart';
import 'package:booking_car_project_flutter/features/ViewModels/CarVM.dart';
import 'package:booking_car_project_flutter/features/ViewModels/PrandVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/AddBrandPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/BookingPage/BookingCoustomerByBranchPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/BookingPage/BookingHomePage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/BookingPage/getByIDInformationBookingForAllCustomerPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/AddCars.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AddimageApi/addImageApi.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/MangeUserScreens.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/AdminPage/HomePageScreen.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/Login_Page_Ui.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/PrandPageScreens.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/SignupPage.dart';
import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/Test_page_Screens.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/awasome_dialog_page.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/AddCarsByUserAndBrand.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/BranchPageIsNotActive.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/ViewBrandPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/getBookingByBranchId.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/customerpage/HomeCustomerPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/customerpage/ViewCarsCustomer.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getBool('token') ?? false;

  runApp(MyApp(
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  final bool token;

  MyApp({super.key, required this.token});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext contextt) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserVM(),
        ),
        ChangeNotifierProvider(
          create: (context) => PrandVM(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookingVM(),
        ),
        ChangeNotifierProvider(
          create: (context) => CarVM(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookingCoustomerByBranchVM(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionVM(),
        )
      ],
      child: ChangeNotifierProvider(
          create: (context) => UserVM(),
          child: Consumer(
            builder: (context, value, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: MaterialApp(
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate
                  ],
                  locale: Locale('ar'),
                  supportedLocales: const [Locale('en'), Locale('ar')],
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    textTheme: GoogleFonts.tajawalTextTheme(
                        Theme.of(context).textTheme),

                    colorScheme:
                        ColorScheme.fromSeed(seedColor: colorprimarygreen),
                    //useMaterial3: true,
                  ),
                  home: Directionality(
                      textDirection: TextDirection.rtl,
                      child: token
                          ? Directionality(
                              textDirection: TextDirection.rtl,
                              child: Test_page_Screens())
                          : Directionality(
                              textDirection: TextDirection.rtl,
                              child: SignUpPageWithImage())),
                ),
              );
            },
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
