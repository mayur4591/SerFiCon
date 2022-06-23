import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:serficon/Pages/signInOwner.dart';
import 'package:serficon/Pages/signUpVerifiedOwner.dart';
import '../Modals/ownerModal.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  @override
  State<EmailVerificationPage> createState() => _State();
}

class _State extends State<EmailVerificationPage> {
  bool isEmailVerified=false;
  Timer? timer;
  // ignore: deprecated_member_use
  final DatabaseReference dataBRef=FirebaseDatabase.instance.reference();
  late FirebaseAuth auth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth=FirebaseAuth.instance;
    isEmailVerified==FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified)
      {
        sendVerificationEmail();

        timer=Timer.periodic(Duration(seconds: 3), (_) =>checkEmailVerified());
      }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState((){
      isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if(isEmailVerified){
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
    }catch(e)
    {
      Flushbar(
        message: '$e',
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ).show(context);
    }

  }
  @override
  Widget build(BuildContext context) =>
      isEmailVerified
  ? returnWidget():
      Scaffold(
        backgroundColor: Colors.grey.shade50,
    appBar: AppBar(
      title: Text('Verify email',),
      backgroundColor: Colors.teal,
    ),
    body:Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mark_email_read_outlined,size: 60,color: Colors.grey,),
              SizedBox(width: 10,),
              Text('Sent',style: TextStyle(color: Colors.grey,fontSize: 30),),
            ],
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(left: 20,right: 20),
              child: Text('Check  your inbox/spam folder and click on link given to verify your email..',style: TextStyle(color: Colors.grey,fontSize: 20))),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            height: 55,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(5)
            ),
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
                    Icon(Icons.email_outlined,color: Colors.white,size: 30,),
                    SizedBox(width: 10,),
                    Text(
                      'Resend email',style: TextStyle(color: Colors.white,fontSize: 30),
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
    insertOwnerInfo(data);
  }
  insertOwnerInfo(OwnerSignUpModal data) {
        dataBRef.child('Users')
        .child('all_users')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'first_name': data.fname,
      'last_name': data.lname,
      'email': data.email,
      'location': data.location,
      'mobile_number': data.mobileNo,
      'role': data.role
    }).then((value) => {
      if (data.role == 'room_owner')
        {
          dataBRef
              .child('Users')
              .child('room_owners')
              .child(auth.currentUser!.uid)
              .set({
            'first_name': data.fname,
            'last_name': data.lname,
            'email': data.email,
            'location': data.location,
            'mobile_number': data.mobileNo,
            'role': data.role,
            'id': auth.currentUser!.uid
          })
        }
      else if (data.role == 'mess_owner')
        {
          dataBRef
              .child('Users')
              .child('mess_owners')
              .child(auth.currentUser!.uid)
              .set({
            'first_name': data.fname,
            'last_name': data.lname,
            'email': data.email,
            'location': data.location,
            'mobile_number': data.mobileNo,
            'role': data.role,
            'id': auth.currentUser!.uid
          })
        }
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignInOwner()));
    Flushbar(
      message: 'Account created succesfully login to get started.',
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ).show(context);


  }

}
