import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:serficon/Modals/ownerModal.dart';
import 'package:serficon/Pages/signInOwner.dart';
import 'package:serficon/Pages/signUpVerifiedOwner.dart';

import 'emailverificationpage.dart';

class SignUpOwner extends StatefulWidget {
  const SignUpOwner({Key? key}) : super(key: key);

  @override
  State<SignUpOwner> createState() => _SignUpOwnerState();
}

class _SignUpOwnerState extends State<SignUpOwner> {
  // ignore: deprecated_member_use

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return EmailVerificationPage();
          } else {
            return VerifiedOwner();
          }
        },
      ),
    );
  }
}
