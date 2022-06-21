import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:serficon/Pages/signInOwner.dart';
import 'Settings.dart';

class  NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _State();
}

class _State extends State<NavigationDrawer> {
  String fname='loading';
  String lname='';
  String email='';
  late FirebaseAuth _auth;
  String id='';
  getData()
  {
    // ignore: deprecated_member_use
    FirebaseDatabase.instance.reference().child('Users/room_owners/$id').once().then((value) {
      Map<dynamic,dynamic> map=value.snapshot.value as Map;
      fname=map['first_name'];
      lname=map['last_name'];
      email=map['email'];
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth=FirebaseAuth.instance;
    id=_auth.currentUser!.uid;
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(top: 88),
      width: MediaQuery.of(context).size.width / 1.4,
      color: Colors.blueGrey,
      child: ListView(children: [
        ListTile(
            leading: const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/profile_png.jpg'),
            ),
            title: Text(
              '$fname $lname',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle:  Text(
              '$email',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            )),
        const Padding(
          padding:  EdgeInsets.only(left: 15, right: 15),
          child:  Divider(
            thickness: 1,
            color: Colors.white,
          ),
        ),
        GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
            },
            child:const ListTile(
              title: Text(
                'Edit profile',
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(
                Icons.edit,
                color: Colors.grey,
              ),
            )),
        GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Want to log out?'),
                    actions: [
                      GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pop(context);
                            Navigator.push(context,MaterialPageRoute(builder: (context)=> SignInOwner()));
                          },
                          child: const Text('Yes')),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text("No"))
                    ],
                  ));
            },
            child: const ListTile(
              title:  Text(
                'Log out',
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(
                Icons.logout,
                color: Colors.grey,
              ),
            )),
      ]),
    );

  }
}








