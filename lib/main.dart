import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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


class _MyAppState extends State<MyApp> {
  // ignore: deprecated_member_use
   late final FirebaseAuth auth;
    var role;
   late Map<dynamic,dynamic> map;
   String string='hello';
   var page;
   // ignore: deprecated_member_use
   final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();


   @override
  void initState() {
    // TODO: implement initState
     map={'room_owner':const RoomOwnerMenuPage(),'mess_owner':const MessOwnerMenuPage(),'customer':const MenuPage()};
     auth=FirebaseAuth.instance;
     if(auth.currentUser!=null) {
       getRole();
       page=map[role];
       setState((){});
     }
     else {
       page=const Welcome();
     }
     super.initState();
     getLoginStatus();

   }

  // void getWidget()
  // {
  //   if(map.containsKey(role)) {
  //     page = map[role.toString()];
  //   }
  //   else
  //     page=Welcome();
  //   // if(role=='customer')
  //   //   {
  //   //     page= const MenuPage();
  //   //     string='menupage';
  //   //   }
  //   // else if(role=='room_owner')
  //   //   {
  //   //     page= const RoomOwnerMenuPage();
  //   //     string='room';
  //   //   }
  //   // else if(role=='mess_owner')
  //   //   {
  //   //     page= const MessOwnerMenuPage();
  //   //     string='mess';
  //   //   }
  //     setState((){});
  //   //
  //   // print(string);
  //   // return page;
  //
  // }
    getRole()  {
     databaseReference.child('Users').child('all_users').child(auth.currentUser!.uid).child('role').once().then((value)  {
       role=value.snapshot.value;
       print('In in it state :-$role');
       if(role==null)
         {
           print('role is null');
         }
     });
   }

  Future getLoginStatus() async  {
    final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var obtainedEmail=sharedPreferences.getString('email');
    if(obtainedEmail!=null) {
      setState(() {
        finalEmail = obtainedEmail;
        print(finalEmail);
      });
    }
    else{
      finalEmail=null;
    }

  }

  @override
  Widget build(BuildContext context) {
     setState((){
       page=map[role];
     });
    return
      const MaterialApp(
      debugShowCheckedModeBanner: false,
            home: Welcome()
          );

  }

}
