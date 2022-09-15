import 'package:flutter/material.dart';
import 'package:moviesapp/model/genre.dart';
import 'package:moviesapp/screens/main_screen.dart';
import 'package:moviesapp/widgets/genres.dart';
import 'package:moviesapp/widgets/genres_list.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg8.jpg"), fit: BoxFit.cover)),
        child: AnimatedContainer(
          curve: Curves.easeInOutCubic,
          duration: const Duration(milliseconds: 500),
          width: 300,
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                      child:
                          Image(image: AssetImage("assets/logos/logo7.png"))),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: const Text('Home'),
                  //To perform action on tapping at tile
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(Icons.movie),
                  title: const Text('Choose Your Movie Type'),
                  //To perform action on tapping at tile
                  onTap: () {},
                ),
                const Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: const Text('Trending Characters'),
                  //To perform action on tapping at tile
                  onTap: () {},
                ),
                const Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: const Text('Settings'),
                  //To perform action on tapping at tile
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Divider(color: Colors.grey),
                const Spacer(),
                ListTile(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainScreen()));
                      },
                      icon: Icon(
                        size: 25,
                        Icons.logout,
                        color: Colors.black,
                      )),
                  title: const Text(
                    'LogOut',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  //To perform action on tapping at tile
                  // onTap: () {
                  //   Navigator.pop(context);
                  // },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
