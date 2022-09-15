import 'package:flutter/material.dart';
import 'package:moviesapp/screens/login_screen.dart';
import 'package:moviesapp/screens/registration_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg2.jpg"), fit: BoxFit.cover)),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 35,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Welcome",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: "Merienda"),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  " Movie app that offers a great collection of\n movies. The app presents you with a \nwall of free movies, sorted by\n categories, with the new\n arrivals shown right \non top.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 43, 41, 41),
                    fontSize: 15,
                  ),
                )
              ],
            ),
            // Container(
            //   height: 150,
            //   decoration: const BoxDecoration(
            //       image: DecorationImage(
            //           image: AssetImage("assets/logos/loginlogo.png"))),
            // ),
            SizedBox(height: 200),
            Center(
              child: Column(
                children: [
                  MaterialButton(
                    elevation: 10,
                    color: Colors.grey,
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    elevation: 10,
                    color: Colors.grey,
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationScreen()));
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Ink(
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Image.asset(
                              "assets/logos/instagram.png",
                              height: 30,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Sign in with Instangram',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Ink(
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Image.asset(
                              "assets/logos/facebook.png",
                              height: 30,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Sign in with FaceBook',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Ink(
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Image.asset(
                              "assets/logos/twitter.png",
                              height: 30,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Sign in with Twitter',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
