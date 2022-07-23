import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:serficon/MainScreen/CustomerMenuPage.dart';
import 'package:serficon/MainScreen/MessOwnerMenuPage.dart';
import 'package:serficon/MainScreen/RoomOwnerMenuPage.dart';
import 'package:serficon/Pages/welcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
bool isloding=false;
class _MyAppState extends State<MyApp> {
  // ignore: deprecated_member_use
  late StreamSubscription<InternetConnectionStatus> listener;
  late final FirebaseAuth auth;
  var role;
  var page;
  // ignore: deprecated_member_use
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();
  bool hasConnection = false;
  Connectivity connectivity = Connectivity();
  @override
  void initState() {
    // TODO: implement initState
    listener = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          setState(() {
            hasConnection = true;
          });
          break;
        case InternetConnectionStatus.disconnected:
          setState(() {
            hasConnection = false;
          });
          // TODO: Handle this case.
          break;
      }
    });

    auth = FirebaseAuth.instance;
    super.initState();
    //checkConnection();
    getLoginStatus();
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
    return hasConnection
        ? isloding==false? MaterialApp(debugShowCheckedModeBanner: false, home: FirebaseAuth.instance.currentUser==null?Welcome():HomePage()):
    Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(color: Colors.blueAccent,),
        SizedBox(height: 20,),
        Text('Loading...',style: TextStyle(color: Colors.grey,fontSize: 20),)

      ],
    )): MaterialApp(
            color: Colors.white,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 80),
                      child: Center(
                        child: Text(
                          'Check your connectivity..!',
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Lottie.asset('assets/lottie/connectionerror.json')
                ],
              )),
            ),
          );
    ;
  }

}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String role='';
   var page;
  getRole() {
    setState((){
      isloding=true;
    });
    FirebaseDatabase.instance.reference()
        .child('Users')
        .child('all_users')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child('role')
        .once()
        .then((value) {
      setState(() {
        role = value.snapshot.value as String;
      });

      print('In in it state :-$role');
      if (role == null) {
        print('role is null');
      }
    });
    setState((){
      isloding=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState((){
      isloding=true;
    });
    getRole();
    print(role);
    setState((){
      isloding=false;
    });

  //checkScreen();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: role=='mess_owner'?MessOwnerMenuPage():role=='room_owner'?RoomOwnerMenuPage():role=='customer'?MenuPage():Scaffold(
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.blueAccent,),
            SizedBox(height: 20,),
            Text('Loading...',style: TextStyle(color: Colors.grey,fontSize: 20),)

          ],
        )),
      ),
    );
  }

}

