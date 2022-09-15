import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/screens/drawer_screen.dart';
import 'package:moviesapp/style/theme.dart' as Style;
import 'package:moviesapp/widgets/genres.dart';
import 'package:moviesapp/widgets/genres_list.dart';
import 'package:moviesapp/widgets/now_playing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: CustomDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        // title:  Text(
        //   "Movie APP",
        //   style: TextStyle(color: Colors.white),
        // ),
        actions: const [
          IconButton(
            icon: Icon(
              EvaIcons.search,
              color: Colors.white,
            ),
            onPressed: null,
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            NowPlaying(),
            GenresScreen(),
          ],
        ),
      ),
    );
  }
}
