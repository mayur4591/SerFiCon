import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:serficon/MainScreen/CustomerMenuPage.dart';
import 'package:serficon/Pages/forgetPasswordPage.dart';
import 'package:serficon/Pages/signUpCustomer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../MainScreen/MessOwnerMenuPage.dart';
import '../MainScreen/RoomOwnerMenuPage.dart';

class SignInCustomer extends StatefulWidget {
  const SignInCustomer({Key? key}) : super(key: key);

  @override
  State<SignInCustomer> createState() => _SignInCustomerState();
}

class _SignInCustomerState extends State<SignInCustomer> {
  late StreamSubscription<InternetConnectionStatus> listener;

  // ignore: deprecated_member_use
  bool loading = false;
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  late final FirebaseAuth auth;
  bool hasConnection = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listener = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          setState(() {
            hasConnection = true;
          });
          break;
        case InternetConnectionStatus.disconnected:
          setState(() {
            hasConnection = false;
          });
          // TODO: Handle this case.
          break;
      }
    });
    auth = FirebaseAuth.instance;
  }

  final emailController = TextEditingController();
  final passwordControll = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return hasConnection
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            body: loading == false
                ? Container(
                    color: Colors.teal.withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Lottie.asset('assets/lottie/signIn.json'),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Center(
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: emailController,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                hintText: 'E-mail',
                                hintStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: const Icon(
                                  Icons.mail_outline_sharp,
                                  color: Colors.grey,
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: passwordControll,
                            style: const TextStyle(color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                hintText: 'Enter password',
                                hintStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: const Icon(
                                  Icons.vpn_key_outlined,
                                  color: Colors.grey,
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                              onTap: () async {
                                if (emailController.text.isEmpty ||
                                    passwordControll.text.isEmpty) {
                                  Flushbar(
                                    message: 'Fill all cridentials...',
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 3),
                                  ).show(context);
                                } else {
                                  setState(() {
                                    loading = true;
                                    Future.delayed(const Duration(seconds: 10),
                                        () {
                                      if (loading == true) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignInCustomer()));
                                        setState(() {
                                          loading = false;
                                        });
                                        Flushbar(
                                          message:
                                              'Something went wrong please  try to sign in again..',
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 3),
                                        ).show(context);
                                      }
                                    });
                                  });
                                  await auth
                                      .signInWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordControll.text).then((value) => {
                                    Flushbar(
                                      message: 'Wait we are signing you in...',
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 3),
                                    ).show(context)
                                  }).onError((error, stackTrace) => {
                                    Flushbar(
                                      message: '$error',
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3),
                                    ).show(context)
                                  });
                                  setState(() {
                                    loading = true;
                                  });
                                  final SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  sharedPreferences.setString(
                                      'email', emailController.text);
                                  // ignore: use_build_context_synchronously
                                  await databaseReference
                                      .child('Users')
                                      .child('all_users')
                                      .child(auth.currentUser!.uid)
                                      .child('role')
                                      .once()
                                      .then((value) {
                                    var role = value.snapshot.value;
                                    if (role == 'room_owner') {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RoomOwnerMenuPage()));

                                    } else if (role == 'mess_owner') {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MessOwnerMenuPage()));

                                    } else if (role == 'customer') {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MenuPage()));
                                    }
                                  }).onError((error, stackTrace) {
                                    Flushbar(
                                      message: '$error',
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3),
                                    ).show(context);
                                  });
                                }
                                setState(() {
                                  loading = false;
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blueAccent,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgetPassword()));
                            },
                            child: Center(
                              child: const Text(
                                "Forget Password?",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.blueAccent),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: const Text(
                              "Don't have an account?",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SignUpCustomer()));
                              },
                              child: Center(
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Loading...',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      )
                    ],
                  )),
          )
        : MaterialApp(
            color: Colors.white,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 80),
                      child: Center(
                        child: Text(
                          'Check your connectivity..!',
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Lottie.asset('assets/lottie/connectionerror.json')
                ],
              )),
            ),
          );
    ;
  }
}
