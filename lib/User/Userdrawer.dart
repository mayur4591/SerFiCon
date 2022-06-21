import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:serficon/Pages/signInOwner.dart';

import 'Edit_profile_user.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  // ignore: deprecated_member_use
  final ref = FirebaseDatabase.instance.reference();
  var uid = FirebaseAuth.instance.currentUser!.uid;
  var fname = 'loading...', lname = '', email = 'loading...';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    fetch();
    return Container(
        width: MediaQuery.of(context).size.width / 1.4,
        color: Colors.white,
        child: ListView(children: [
          Container(
            height: 250,
            color: Colors.blue.withOpacity(0.7),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile_png.jpg'),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '$fname $lname',
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                email,
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ]),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
              child: const ListTile(
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
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignInOwner()));
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
                title: Text(
                  'Log out',
                  style: TextStyle(fontSize: 20),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Colors.grey,
                ),
              )),
        ]));
  }

  Future<void> fetch() async {
    await ref.child('Users/all_users/$uid').once().then((event) async {
      Map<dynamic, dynamic> map = event.snapshot.value as Map;
      fname = map['first_name'];
      lname = map['last_name'];
      email = map['email'];
    });
  }
}
