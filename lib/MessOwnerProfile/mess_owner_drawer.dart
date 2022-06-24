
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/StartingPage.dart';
import '../Pages/welcomeScreen.dart';

class MessOwnerDrawer extends StatefulWidget {
  const MessOwnerDrawer({Key? key}) : super(key: key);

  @override
  State<MessOwnerDrawer> createState() => _MessOwnerDrawerState();
}

class _MessOwnerDrawerState extends State<MessOwnerDrawer> {
  String fname = 'loading';
  String lname = '';
  String email = '';
  String url='';
  String city='';
  var roomname='';
  var image;
  getMessData() {
    // ignore: deprecated_member_use
    FirebaseDatabase.instance
        .reference()
        .child('Users/all_users/${FirebaseAuth.instance.currentUser!.uid}')
        .once()
        .then((value) {
      setState((){
        Map<dynamic, dynamic> map = value.snapshot.value as Map;
        fname = map['first_name'];
        lname = map['last_name'];
        email = map['email'];
        roomname=map['name'];
        city=map['city'];
        url=map['profile_image']??'';
         image=NetworkImage(url);
        // print(url);
      });
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.4,
      color: Colors.white,
      child: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.green.withOpacity(0.7),
              width: MediaQuery.of(context).size.width,
              height: 270,
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  CircleAvatar(
                      radius: 50,
                      backgroundImage: url!=''?image:AssetImage('assets/images/profile_png.jpg')
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$fname $lname',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                 // Text('$roomname',style: TextStyle(color: Colors.grey,fontSize: 15),),
                 //  const SizedBox(
                 //    height: 10,
                 //  ),
                  Text(
                    '$email',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_rounded,color: Colors.blueAccent,),
                      SizedBox(width: 5,),
                      Text('$city',style: TextStyle(color: Colors.black),)
                    ],
                  ),
                  SizedBox(height: 5,),
                ],
              ),
            ),

            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Want to log out?'),
                        actions: [
                          GestureDetector(
                              onTap: () async {
                                FirebaseAuth.instance.signOut();
                                final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                                print(
                                    'Before removal:- ${sharedPreferences.getString('email')}');
                                sharedPreferences.remove('email');
                                print(
                                    'After removal:- ${sharedPreferences.getString('email')}');
                                // ignore: use_build_context_synchronously
                                Navigator.popUntil(context, (route) => route==StartingPage);
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>StartingPage()));;
                              },
                              child: const Text('Yes ',style: TextStyle(color: Colors.black,fontSize: 20),)),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text(" No",style: TextStyle(color: Colors.black,fontSize: 20),))
                        ],
                      ));
                },
                child: const ListTile(
                  title: Text(
                    'Log out',
                    style: TextStyle(fontSize: 20),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: Colors.grey,
                  ),
                )),
          ],
        ),

      ]),
    );
  }
}
