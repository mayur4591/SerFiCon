import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serficon/Pages/welcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessOwnerProfile extends StatefulWidget {
  const MessOwnerProfile({Key? key}) : super(key: key);

  @override
  State<MessOwnerProfile> createState() => _MessOwnerProfileState();
}

class _MessOwnerProfileState extends State<MessOwnerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () async {
            FirebaseAuth.instance.signOut();
            final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
            print('Before removal:- ${sharedPreferences.getString('email')}');
            sharedPreferences.remove('email');
            print('After removal:- ${sharedPreferences.getString('email')}');
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Welcome()));
          },
          child: Container(
            color: Colors.blueAccent,
            child: Text('Log out'),
          ),
        ),
      ),
    );
  }
}
