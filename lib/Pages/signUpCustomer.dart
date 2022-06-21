import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:serficon/Modals/customerModal.dart';
import 'package:serficon/Pages/signInCustomer.dart';

class SignUpCustomer extends StatefulWidget {
  const SignUpCustomer({Key? key}) : super(key: key);

  @override
  State<SignUpCustomer> createState() => _SignUpCustomerState();
}

class _SignUpCustomerState extends State<SignUpCustomer> {
  // ignore: deprecated_member_use
  final dbRef = FirebaseDatabase.instance.reference();
  late final FirebaseAuth auth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = FirebaseAuth.instance;
  }

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordControll = TextEditingController();
  var data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: const Text(
                  'Sign Up',
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
                  'Give your creidentials to be a part of our familly which is a very good thing.',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: fnameController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.blueAccent.withOpacity(0.2),
                    filled: true,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'First Name',
                    hintStyle: const TextStyle(color: Colors.grey)),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: lnameController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  fillColor: Colors.blueAccent.withOpacity(0.2),
                  filled: true,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: 'Last Name',
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 30,
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
                    suffixIcon: const Icon(
                      Icons.mail_outline_sharp,
                      color: Colors.grey,
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                style: const TextStyle(color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                    fillColor: Colors.blueAccent.withOpacity(0.2),
                    filled: true,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'Set strong password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: const Icon(
                      Icons.vpn_key_outlined,
                      color: Colors.grey,
                    )),
                controller: passwordControll,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    if (fnameController.text.isEmpty ||
                        lnameController.text.isEmpty ||
                        emailController.text.isEmpty ||
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
                      registerUser(emailController.text.toString(),
                          passwordControll.text.toString());
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: 240),
              const Text(
                'Alerady have an account?',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Login',
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

  void registerUser(String email, String password) {
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              data = CustomerSignUpModal(fnameController.text.toString(),
                  lnameController.text.toString(), email, 'customer'),
              insertDate(data),
            })
        .onError((error, stackTrace) => {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('$error')))
            });
  }

  insertDate(CustomerSignUpModal data) {
    dbRef.child('Users').child('all_users').child(auth.currentUser!.uid).set({
      'first_name': data.fname,
      'last_name': data.lname,
      'email': data.email,
      'role': data.role
    }).onError((error, stackTrace) => {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('$error'))),
      print(error)
        });
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SignInCustomer()));
  }
}
