import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/main.dart';
import 'package:moviesapp/screens/home_screen.dart';
import 'package:moviesapp/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final emailField = Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(54, 0, 0, 0),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        validator: (email) => email != null && !EmailValidator.validate(email)
            ? 'Enter a vali Email'
            : null,
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          email = value;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            hintStyle: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            prefixIcon: const Icon(Icons.mail),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );

    final passwordField = Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(54, 0, 0, 0),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        validator: (value) {
          if (value != null && value.length < 7) {
            return 'Enter min. 7 characters';
          } else {
            return null;
          }
        },
        autofocus: false,
        obscureText: true,
        onChanged: (value) {
          password = value;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            hintStyle: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            prefixIcon: const Icon(Icons.vpn_key),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      // color: Color.fromARGB(255, 223, 42, 26),
      child: MaterialButton(
        elevation: 10,
        color: Colors.grey,
        minWidth: double.infinity,
        height: 60,
        onPressed: () {
          signIn();
          final isValidForm = _formKey.currentState!.validate();
          if (isValidForm) {}
        },
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          "Login",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg2.jpg"), fit: BoxFit.cover)),
        child: Center(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 108, 107, 107),
              ),
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              "It's Movie Time",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  fontFamily: "Merienda"),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        emailField,
                        SizedBox(height: 10),
                        passwordField,
                        SizedBox(height: 20),
                        loginButton,
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Don't have an acoount?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegistrationScreen()));
                              },
                              child: const Text(
                                "Signup",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 203, 14, 0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ),
        )),
      ),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      final newUser = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      if (newUser != null) {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } on FirebaseException catch (e) {
      print(e);
      return showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text(e.code),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                      },
                      child: Text('OK'))
                ],
              ));
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
