import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/screens/home_screen.dart';
import 'package:moviesapp/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  late String emailEditingController;
  late String passwordEditingController;

  @override
  Widget build(BuildContext context) {
    final emailField = Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(54, 0, 0, 0),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          emailEditingController = value;
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
          passwordEditingController = value;
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
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      // color: Color.fromARGB(255, 223, 42, 26),
      child: MaterialButton(
        elevation: 10,
        color: Colors.grey,
        minWidth: double.infinity,
        height: 60,
        onPressed: () {
          signUp();
          // FirebaseAuth.instance.createUserWithEmailAndPassword(
          //     email: emailEditingController,
          //     password: passwordEditingController);
        },
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          "SignUp",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg2.jpg"), fit: BoxFit.cover)),
        child: Center(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            height: 200,
                            child: Image.asset(
                              "assets/logos/registerlogo.png",
                              fit: BoxFit.contain,
                            )),
                        const SizedBox(height: 30),
                        emailField,
                        const SizedBox(height: 30),
                        passwordField,
                        // SizedBox(height: 30),
                        // confirmPasswordField,
                        const SizedBox(height: 30),
                        signUpButton,
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Already have an acoount?",
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
                                            const LoginScreen()));
                              },
                              child: const Text(
                                "SignIn",
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

  Future signUp() async {
    // log(email);
    // log(password);
    try {
      final newUser = await auth.createUserWithEmailAndPassword(
          email: emailEditingController, password: passwordEditingController);
      if (newUser != null) {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      print("#############");
      print(e);
      print("#############");
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(e.code),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
