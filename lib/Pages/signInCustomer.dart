import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:serficon/MainScreen/CustomerMenuPage.dart';
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
  // ignore: deprecated_member_use
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  late final FirebaseAuth auth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = FirebaseAuth.instance;
  }

  final emailController = TextEditingController();
  final passwordControll = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        //color: Colors.blueAccent.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
//mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: const Text(
                  'Sign in with your e-mali and password to explore the things.',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.blueAccent.withOpacity(0.2),
                    filled: true,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
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
                    fillColor: Colors.blueAccent.withOpacity(0.2),
                    filled: true,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Fill all cridentials...',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 300),
                        dismissDirection: DismissDirection.up,
                      ));
                    } else {
                      // doSignInCustomer(
                      //     emailController.text, passwordControll.text);
                      auth.signInWithEmailAndPassword(email: emailController.text, password: passwordControll.text);
                      final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                      sharedPreferences.setString('email', emailController.text);
                      // ignore: use_build_context_synchronously
                      databaseReference.child('Users').child('all_users').child(auth.currentUser!.uid).child('role').once().then((value) {
                        var role=value.snapshot.value;
                        if(role=='room_owner')
                        {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=> const RoomOwnerMenuPage()));

                        }
                        else if(role=='mess_owner')
                        {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=> const MessOwnerMenuPage()));

                        }
                        else if(role=='customer')
                        {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=> const MenuPage()));

                        }
                      });
                    }
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
                height: 40,
              ),
              const Text(
                "Don't have an account?",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpCustomer()));
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void doSignInCustomer(String email, String password) {
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MenuPage()))
            });
  }

  final Future<SharedPreferences> sharedPreferences =
      SharedPreferences.getInstance();
}
