import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:serficon/Modals/customerModal.dart';
import 'package:serficon/Pages/signInCustomer.dart';
import 'package:serficon/Pages/verifyCustomer.dart';

class SignUpCustomer extends StatefulWidget {
  const SignUpCustomer({Key? key}) : super(key: key);

  @override
  State<SignUpCustomer> createState() => _SignUpCustomerState();
}
var customerdata;

class _SignUpCustomerState extends State<SignUpCustomer> {
  // ignore: deprecated_member_use
  final dbRef = FirebaseDatabase.instance.reference();
  late final FirebaseAuth auth;
  bool isloding = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isloding == false
          ? Container(
              color: Colors.orangeAccent.withOpacity(0.7),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                      height: 10,
                    ),
                    const SizedBox(
                      height: 20,
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
                      height: 30,
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
                      height: 30,
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
                      height: 30,
                    ),
                    TextField(
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
                            Flushbar(
                              message: 'Fill all cridentials...',
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                            ).show(context);
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
                  'Uploding information...',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                )
              ],
            )),
    );
  }

  void registerUser(String email, String password) {
    // setState(() {
    //   isloding = true;
    // });
    setState((){
      customerdata=CustomerSignUpModal(fnameController.text.toString(), lnameController.text.toString(), email, 'customer');
    });

    auth
        .createUserWithEmailAndPassword(email: email, password: password).then((value) => {
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>VerifyCustomer()))

    });

  }

  // insertDate(CustomerSignUpModal data) {
  //   setState(() {
  //     isloding = true;
  //   });
  //   dbRef.child('Users').child('all_users').child(auth.currentUser!.uid).set({
  //     'first_name': data.fname,
  //     'last_name': data.lname,
  //     'email': data.email,
  //     'role': data.role
  //   }).onError((error, stackTrace) => {
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(SnackBar(content: Text('$error'))),
  //         setState(() {
  //           isloding = false;
  //         }),
  //         print(error)
  //       });
  //   isloding
  //       ? Flushbar(
  //       message:'Account created succesfully login to get started.' ,
  //       flushbarPosition: FlushbarPosition.TOP,
  //       backgroundColor: Colors.green,
  //       duration: Duration(seconds: 3),
  //   ).show(context)        : print('error');
  //   Navigator.pushReplacement(context,
  //       MaterialPageRoute(builder: (context) => const SignInCustomer()));
  //
  //   setState(() {
  //     isloding = false;
  //   });
  // }
}
