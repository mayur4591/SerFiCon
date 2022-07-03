import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/StartingPage.dart';

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
  var image;
  String url = '';
  @override
  Future<void> fetch() async {
    await ref.child('Users/all_users/$uid').once().then((event) async {
      setState(() {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        fname = map['first_name'];
        lname = map['last_name'];
        email = map['email'];
        url = map['profile_image'] ?? '';
        image = NetworkImage(url);
      });
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.4,
        color: Colors.white,
        child: ListView(children: [
          Container(
            height: 250,
            color: Colors.blue.withOpacity(0.7),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CircleAvatar(
                  radius: 50,
                  backgroundImage: url != ''
                      ? image
                      : AssetImage('assets/images/profile_png.jpg')),
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
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Want to log out?',
                              style: TextStyle(fontSize: 20)),
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
                                  Navigator.popUntil(context,
                                      (route) => route == StartingPage);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StartingPage()));
                                },
                                child: const Text(
                                  'Yes ',
                                  style: TextStyle(fontSize: 18),
                                )),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, false);
                                },
                                child: const Text(" No",
                                    style: TextStyle(fontSize: 18)))
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
}
