import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serficon/Pages/signUpCustomer.dart';
import 'package:serficon/Pages/verifyCustomerEmail.dart';

class VerifyCustomer extends StatefulWidget {
  const VerifyCustomer({Key? key}) : super(key: key);

  @override
  State<VerifyCustomer> createState() => _VerifyCustomer();
}

class _VerifyCustomer extends State<VerifyCustomer> {
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
            return CustomerEmailVerification();
          } else {
            return SignUpCustomer();
          }
        },
      ),
    );
  }
}
