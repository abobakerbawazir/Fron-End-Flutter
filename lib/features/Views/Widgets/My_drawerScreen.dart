import 'package:booking_car_project_flutter/features/Views/Screnns/SignupPage.dart';
import 'package:booking_car_project_flutter/features/Views/Widgets/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class My_drawerScreen extends StatelessWidget {
  const My_drawerScreen({super.key});
  container_drawer(
      {BuildContext? context,
      required String Name_image,
      required String Name_Person,
      required String Email_Person}) {
    return SizedBox(
      height: 180,
      child: DrawerHeader(
          decoration: const BoxDecoration(
              // color: Color.fromARGB(255, 49, 48, 48),
              ),
          child: Column(
            children: [
              InkWell(
                  onTap: () => Navigator.pop(context!),
                  child: Container(
                      margin: const EdgeInsets.only(right: 250),
                      child: const Icon(
                        Icons.close,
                        // color: Colors.white,
                      ))),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => Navigator.pushNamed(context!, '/editProfile'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(Name_image),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      children: [
                        Text(
                          Name_Person,
                          style: const TextStyle(
                            color: Color(0xFF047921),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          Email_Person,
                          style: const TextStyle(
                            color: Color(0xFF047921),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  ListTile_me(
      {required IconData Name_icon,
      required BuildContext context,
      required String title,
      required String pageNameRoute}) {
    return ListTile(
      leading: Icon(Name_icon, color: Color(0xFF047921)),
      title: Text(
        title,
        style: const TextStyle(color: Color(0xFF047921)),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return SignupPage();
          },
        ));
        Navigator.pushNamed(context, "/$pageNameRoute");
      },
    );
  }

  drawer_Me(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 219, 218, 218),
        // color: const Color.fromARGB(255, 49, 48, 48),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            container_drawer(
                context: context,
                Name_image: "assets/prands/prand1.png",
                Name_Person: "Ahmed Ali",
                Email_Person: "Ahmed@gmail.com"),
            ListTile_me(
                context: context,
                Name_icon: (Icons.person),
                title: 'My Account',
                pageNameRoute: 'login'),
            ListTile_me(
                context: context,
                Name_icon: (Icons.person),
                title: 'About Us',
                pageNameRoute: 'login'),
            ListTile_me(
                context: context,
                Name_icon: (Icons.settings_input_antenna),
                title: 'My Subscriptions',
                pageNameRoute: 'login'),
            ListTile_me(
                context: context,
                Name_icon: (Icons.support),
                title: 'Support',
                pageNameRoute: 'login'),
            ListTile_me(
                context: context,
                Name_icon: (Icons.person),
                title: 'Rate Us',
                pageNameRoute: 'login'),
            ListTile_me(
                context: context,
                Name_icon: (Icons.logout),
                title: 'Log Out',
                pageNameRoute: ''),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return drawer_Me(context);
  }
}
