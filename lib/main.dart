import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:serficon/MainScreen/CustomerMenuPage.dart';
import 'package:serficon/MainScreen/MessOwnerMenuPage.dart';
import 'package:serficon/MainScreen/RoomOwnerMenuPage.dart';
import 'package:serficon/Owner/ownerProfile.dart';
import 'package:serficon/Pages/signInCustomer.dart';
import 'package:serficon/Pages/signInOwner.dart';
import 'package:serficon/Pages/signUpCustomer.dart';
import 'package:serficon/Pages/signUpOwner.dart';
import 'package:serficon/Pages/welcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pages/emailverificationpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

var finalEmail;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ignore: deprecated_member_use
  late final FirebaseAuth auth;
  var role;
  late Map<dynamic, dynamic> map;
  String string = 'hello';
  var page;
  // ignore: deprecated_member_use
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();

  @override
  void initState() {
    // TODO: implement initState
    map = {
      'room_owner': const RoomOwnerMenuPage(),
      'mess_owner': const MessOwnerMenuPage(),
      'customer': const MenuPage()
    };
    auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      setState(() {
        getRole();
      });
    }
    super.initState();
    getLoginStatus();
  }

  getRole() {
    databaseReference
        .child('Users')
        .child('all_users')
        .child(auth.currentUser!.uid)
        .child('role')
        .once()
        .then((value) {
      role = value.snapshot.value;
      print('In in it state :-$role');
      if (role == null) {
        print('role is null');
      }
    });
  }

  Future getLoginStatus() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    if (obtainedEmail != null) {
      setState(() {
        finalEmail = obtainedEmail;
        print(finalEmail);
      });
    } else {
      finalEmail = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      page = map[role];
    });
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  Welcome()
    );
  }
}
