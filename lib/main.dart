import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:serficon/MainScreen/CustomerMenuPage.dart';
import 'package:serficon/MainScreen/MessOwnerMenuPage.dart';
import 'package:serficon/MainScreen/RoomOwnerMenuPage.dart';
import 'package:serficon/Pages/StartingPage.dart';
import 'package:serficon/Pages/welcomeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
String id='';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ignore: deprecated_member_use
  late StreamSubscription<User?> user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  @override


  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
            home: Welcome()
          );

  }




}
