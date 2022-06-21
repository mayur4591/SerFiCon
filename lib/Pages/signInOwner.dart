import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:serficon/MainScreen/MessOwnerMenuPage.dart';
import 'package:serficon/MainScreen/RoomOwnerMenuPage.dart';
import 'package:serficon/Pages/signUpOwner.dart';

class SignInOwner extends StatefulWidget {
  const SignInOwner({Key? key}) : super(key: key);

  @override
  State<SignInOwner> createState() => _SignInOwnerState();
}

class _SignInOwnerState extends State<SignInOwner> {
  // ignore: deprecated_member_use
  DatabaseReference databaseReference=FirebaseDatabase.instance.reference();
  late final FirebaseAuth auth;
  var role;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth=FirebaseAuth.instance;
  }

  final emailController = TextEditingController();
  final passwordControll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
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
                    hintText: 'Password',
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
                  onTap: () {
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
                      doSignInOwner(emailController.text, passwordControll.text);
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
                            builder: (context) => const SignUpOwner()));
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

  void doSignInOwner(String email, String password) {
    auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
      databaseReference.child('Users/all_users/${auth.currentUser!.uid}/role').once().then((value) {
        role=value.snapshot.value;
        if(role=='room_owner')
          {
            Navigator.push(context,MaterialPageRoute(builder: (context)=> const RoomOwnerMenuPage()));
          }
        else if(role=='mess_owner')
          {
            Navigator.push(context,MaterialPageRoute(builder: (context)=> const MessOwnerMenuPage()));

          }
      });
    });
  }
}
