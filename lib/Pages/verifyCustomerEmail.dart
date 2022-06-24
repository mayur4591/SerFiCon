import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:serficon/Pages/signInCustomer.dart';
import 'package:serficon/Pages/signUpCustomer.dart';

import '../Modals/customerModal.dart';

class CustomerEmailVerification extends StatefulWidget {
  const CustomerEmailVerification({Key? key}) : super(key: key);

  @override
  State<CustomerEmailVerification> createState() => _CustomerEmailVerificationState();
}

class _CustomerEmailVerificationState extends State<CustomerEmailVerification> {
  bool isEmailVerified = false;
  Timer? timer;
  // ignore: deprecated_member_use
  final DatabaseReference dataBRef = FirebaseDatabase.instance.reference();
  late FirebaseAuth auth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = FirebaseAuth.instance;
    isEmailVerified == FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer!.cancel();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer!.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      Flushbar(
        message: '$e',
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? returnWidget()
      : Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            title: Text(
              'Verify email',
            ),
            backgroundColor: Colors.teal,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mark_email_read_outlined,
                      size: 60,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Sent',
                      style: TextStyle(color: Colors.grey, fontSize: 30),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                        'Check  your mail inbox/spam folder and click on link  to verify your email..',
                        style: TextStyle(color: Colors.grey, fontSize: 20))),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(5)),
                  child: GestureDetector(
                    onTap: () async {
                      final user = FirebaseAuth.instance.currentUser!;
                      await user.sendEmailVerification().then((value) => {
                            Flushbar(
                              message: 'Email sent...',
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 3),
                            ).show(context)
                          });
                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Resend email',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );

  returnWidget() {
    insertDate(customerdata);
    return SignInCustomer();
  }

  insertDate(CustomerSignUpModal data) {
    dataBRef
        .child('Users')
        .child('all_users')
        .child(auth.currentUser!.uid)
        .set({
      'first_name': data.fname,
      'last_name': data.lname,
      'email': data.email,
      'role': data.role
    }).onError((error, stackTrace) {
      Flushbar(
              message: 'Something went wrong try again...',
              duration: Duration(seconds: 3),
              backgroundColor: Colors.red,
              flushbarPosition: FlushbarPosition.TOP)
          .show(context);
      print(error);
    });
  }
}
