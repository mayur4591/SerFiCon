import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:serficon/Pages/signInOwner.dart';
import 'package:serficon/Pages/signUpOwner.dart';

import '../Modals/ownerModal.dart';

class VerifiedOwner extends StatefulWidget {
  const VerifiedOwner({Key? key}) : super(key: key);

  @override
  State<VerifiedOwner> createState() => _VerifiedOwnerState();
}

String selectedItem = '';
var data;

class _VerifiedOwnerState extends State<VerifiedOwner> {
  DatabaseReference dataBRef = FirebaseDatabase.instance.reference();
  late final FirebaseAuth auth;
  bool isloding = false;

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final mobileController = TextEditingController();
  final locationController = TextEditingController();
  final emailController = TextEditingController();
  final passwordControll = TextEditingController();
  final cityController = TextEditingController();
  final nameController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = FirebaseAuth.instance;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orangeAccent.withOpacity(0.6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              const SizedBox(height: 40),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Center(
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: fnameController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'First Name',
                    hintStyle: const TextStyle(color: Colors.grey)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: lnameController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  fillColor: Colors.white,
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
                height: 10,
              ),
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: 'Room/Mess name..',
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: mobileController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'Mobile number',
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: const Icon(
                      Icons.phone,
                      color: Colors.grey,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: locationController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'Location or Adress',
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: const Icon(
                      Icons.location_on,
                      color: Colors.grey,
                    )),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: cityController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'City',
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: const Icon(
                      Icons.location_on,
                      color: Colors.grey,
                    )),
              ),
              const SizedBox(
                height: 10,
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
                height: 10,
              ),
              TextField(
                controller: passwordControll,
                style: const TextStyle(color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                    fillColor: Colors.white,
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
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Radio(
                      value: 'room_owner',
                      groupValue: selectedItem,
                      onChanged: (val) {
                        setState(() {
                          selectedItem = val as String;
                        });
                      }),
                  const Text(
                    'Room owner',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Radio(
                      value: 'mess_owner',
                      groupValue: selectedItem,
                      onChanged: (val) {
                        setState(() {
                          selectedItem = val as String;
                        });
                      }),
                  const Text(
                    'Mess owner',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: GestureDetector(
                    onTap: () {
                      if (fnameController.text.isEmpty ||
                          lnameController.text.isEmpty ||
                          mobileController.text.isEmpty ||
                          locationController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordControll.text.isEmpty ||
                          cityController.text.isEmpty ||
                          nameController.text.isEmpty ||
                          selectedItem == '') {
                        Flushbar(
                          message: 'Fill all cridentials...',
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ).show(context);
                      } else {
                        data = OwnerSignUpModal(
                            fnameController.text.toString(),
                            lnameController.text.toString(),
                            emailController.text.toString(),
                            mobileController.text.toString(),
                            locationController.text.toString(),
                            selectedItem.toString(),
                            cityController.text,
                            nameController.text);
                        registerOwner(emailController.text.toString(),
                            passwordControll.text.toString());
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 10,
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
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Alerady have an account?',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
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
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void registerOwner(String email, String password) {
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignUpOwner()))
            }).onError((error, stackTrace) => {
      Flushbar(
      message: '$error',
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
      ).show(context)
    });
  }

  // insertOwnerInfo(OwnerSignUpModal data) {
  //   setState(() {
  //     isloding = true;
  //   });
  //   dataBRef
  //       .child('Users')
  //       .child('all_users')
  //       .child(auth.currentUser!.uid)
  //       .set({
  //     'first_name': data.fname,
  //     'last_name': data.lname,
  //     'email': data.email,
  //     'location': data.location,
  //     'mobile_number': data.mobileNo,
  //     'role': data.role
  //   }).then((value) => {
  //     if (data.role == 'room_owner')
  //       {
  //         dataBRef
  //             .child('Users')
  //             .child('room_owners')
  //             .child(auth.currentUser!.uid)
  //             .set({
  //           'first_name': data.fname,
  //           'last_name': data.lname,
  //           'email': data.email,
  //           'location': data.location,
  //           'mobile_number': data.mobileNo,
  //           'role': data.role,
  //           'id': auth.currentUser!.uid
  //         })
  //       }
  //     else if (data.role == 'mess_owner')
  //       {
  //         dataBRef
  //             .child('Users')
  //             .child('mess_owners')
  //             .child(auth.currentUser!.uid)
  //             .set({
  //           'first_name': data.fname,
  //           'last_name': data.lname,
  //           'email': data.email,
  //           'location': data.location,
  //           'mobile_number': data.mobileNo,
  //           'role': data.role,
  //           'id': auth.currentUser!.uid
  //         })
  //       }
  //   });
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => const SignInOwner()));
  //   Flushbar(
  //     message: 'Account created succesfully login to get started.',
  //     flushbarPosition: FlushbarPosition.TOP,
  //     backgroundColor: Colors.green,
  //     duration: Duration(seconds: 3),
  //   ).show(context);
  //
  //   setState(() {
  //     isloding = false;
  //   });
  // }
}
