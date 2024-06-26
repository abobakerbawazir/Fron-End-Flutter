import 'package:booking_car_project_flutter/features/ViewModels/UserVM.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/BranchProfilesPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/MonyBranchPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/ViewBrandPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/branchPage/getBookingByBranchId.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/customerpage/HomeCustomerPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/customerpage/ProfileCustomerPage.dart';
import 'package:booking_car_project_flutter/features/Views/Screnns/customerpage/getBookingByBranchIdByCustomerIdForCoustomerPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class BranchHomeNav extends StatefulWidget {
  const BranchHomeNav({
    Key? key,
  }) : super(key: key);

  @override
  State<BranchHomeNav> createState() => _BranchHomeNavState();
}

class _BranchHomeNavState extends State<BranchHomeNav> {
  dynamic selected;
  var heart = false;
  PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserVM>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBody: true, //to make floating action button notch transparent

        //to avoid the floating action button overlapping behavior,
        // when a soft keyboard is displayed
        // resizeToAvoidBottomInset: false,

        bottomNavigationBar: StylishBottomBar(
          option: AnimatedBarOptions(
            padding: EdgeInsets.all(12),
            iconSize: 32,
            barAnimation: BarAnimation.fade,
            iconStyle: IconStyle.animated,
            // opacity: 0.3,
          ),
          items: [
            BottomBarItem(
              icon: const Icon(
                Icons.house_outlined,
              ),
              selectedIcon: const Icon(Icons.house_rounded),
              selectedColor: Colors.teal,
              //backgroundColor: Colors.teal,
              title: const Text('الرئيسية'),
              //badge: const Text('9+'),
              //showBadge: true,
            ),
            BottomBarItem(
              icon: const Icon(Icons.wallet),
              selectedIcon: const Icon(Icons.star_rounded),
              selectedColor: Colors.red,
              // unSelectedColor: Colors.purple,
              // backgroundColor: Colors.orange,
              title: const Text('محفظتي'),
            ),
            BottomBarItem(
                icon: const Icon(
                  Icons.style_outlined,
                ),
                selectedIcon: const Icon(
                  Icons.style,
                ),
                //backgroundColor: Colors.amber,
                selectedColor: Colors.deepOrangeAccent,
                title: const Text('حجوزاتي')),
            BottomBarItem(
                icon: const Icon(
                  Icons.person_outline,
                ),
                selectedIcon: const Icon(
                  Icons.person,
                ),
                //backgroundColor: Colors.purpleAccent,
                selectedColor: Colors.deepPurple,
                title: const Text('حسابي')),
          ],
          hasNotch: true,
          // fabLocation: StylishBarFabLocation.center,
          currentIndex: selected ?? 0,
          onTap: (index) {
            controller.jumpToPage(index);
            setState(() {
              selected = index;
            });
          },
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     setState(() {
        //       heart = !heart;
        //     });
        //   },
        //   backgroundColor: Colors.white,
        //   child: Icon(
        //     heart ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
        //     color: Colors.red,
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(
          child: PageView(
            controller: controller,
            children: const [
              ViewPrandPage(),
              MonyBranchPage(),
              getBookingByBranchIdPage(),
              BranchProfilesPage()
            ],
          ),
        ),
      ),
    );
  }
}

//
//Example to setup Bubble Bottom Bar with PageView
class BubbelBarExample extends StatefulWidget {
  const BubbelBarExample({Key? key}) : super(key: key);

  @override
  State<BubbelBarExample> createState() => _BubbelBarExampleState();
}

class _BubbelBarExampleState extends State<BubbelBarExample> {
  PageController controller = PageController(initialPage: 0);
  var selected = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: const [
          // Home(),
          // Add(),
          // Profile(),
        ],
      ),
      bottomNavigationBar: StylishBottomBar(
        option: BubbleBarOptions(
          // barStyle: BubbleBarStyle.vertical,
          barStyle: BubbleBarStyle.horizotnal,
          bubbleFillStyle: BubbleFillStyle.fill,
          // bubbleFillStyle: BubbleFillStyle.outlined,
          opacity: 0.3,
        ),
        items: [
          BottomBarItem(
            icon: const Icon(Icons.abc),
            title: const Text('Abc'),
            backgroundColor: Colors.red,

            // selectedColor: Colors.pink,
            selectedIcon: const Icon(Icons.read_more),
            badge: const Badge(),
            showBadge: true,
          ),
          BottomBarItem(
            icon: const Icon(Icons.safety_divider),
            title: const Text('Safety'),
            selectedColor: Colors.orange,
            backgroundColor: Colors.orange,
          ),
          BottomBarItem(
            icon: const Icon(Icons.cabin),
            title: const Text('Cabin'),
            backgroundColor: Colors.purple,
          ),
        ],
        // fabLocation: StylishBarFabLocation.end,
        // hasNotch: true,
        currentIndex: selected,
        onTap: (index) {
          setState(() {
            selected = index;
            controller.jumpToPage(index);
          });
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.emoji_emotions),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
