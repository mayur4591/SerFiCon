import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'Userdrawer.dart';
import 'bookmarks.dart';


class UserProfile extends StatefulWidget {

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // ignore: prefer_typing_uninitialized_variables, deprecated_member_use
  final databaseRef = FirebaseDatabase.instance.reference();
  var userImage;
  late FirebaseAuth _auth;
  var fname='loading...';
  var lname='';
  var uid;

  // get databaseRef => null;

  Future<void> fetch() async {
    await databaseRef.child('Users/all_users/$uid').once().then((event) async {
      setState(() {
        Map<dynamic, dynamic>? map = event.snapshot.value as Map?;
        fname = map!['first_name'];
        lname = map['last_name'];
        print(fname);
        print(lname);
      });
    });
  }
  @override

  // ignore: deprecated_member_use
  final Image user_profile_image = const Image(
      image: AssetImage("assets/images/profile_png.jpg"),
      fit: BoxFit.cover,
      height: 145,
      width: 145);

  Future getUserImage(String name) async {
    if (name == 'Gallery') {
      final PickedFile pickedFile = await ImagePicker()
          // ignore: deprecated_member_use
          .getImage(source: ImageSource.gallery) as PickedFile;
      setState(() {
        userImage = File(pickedFile.path);
      });
    } else if (name == 'Camera') {
      final PickedFile pickedFile = await ImagePicker()
          // ignore: deprecated_member_use
          .getImage(source: ImageSource.camera) as PickedFile;
      setState(() {
        userImage = File(pickedFile.path);
      });
    }
  }

  Widget buildUserProfileImage() => ClipOval(
        child: getProfile(),
      );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    // ignore: deprecated_member_use
    final User? user = _auth.currentUser;
    uid = user?.uid;
    fetch();
  }

  Image getProfile() {
    return (userImage != null)
        ? (Image.file(
            userImage,
            height: 145,
            width: 145,
            fit: BoxFit.cover,
          ))
        : (user_profile_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueAccent.withOpacity(0.4),
          title: const Text(
            "Profile",
            style: TextStyle(
                fontSize: 25,color: Colors.black),
          ),
        ),
        endDrawer: const UserDrawer(),
        body: Column(children: [
          Card(
            child: Column(
              children: [
                buildUserProfileImage(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '$fname $lname',
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          getUserImage('Gallery');
                        },
                        child: const Icon(
                          Icons.image,
                          size: 30,
                          color: Colors.blue,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          getUserImage('Camera');
                        },
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 30,
                          color: Colors.green,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const BookMarks()));
              },
              child: const Card(
                  child: ListTile(
                title: Text(
                  'Your bookmarks',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Icon(
                  Icons.bookmark,
                  color: Colors.blueAccent,
                ),
              ))),
        ]));
  }
}

// !(rulesList.isEmpty)
// ?ListView.builder(
// itemBuilder: (BuildContext context, int index) {
// return Card(
// elevation: 2,
// child: ListTile(
// title: ExpandablePanel(
// header: Text(
// '${rulesList[index].title}',
// style: const TextStyle(
// fontSize: 25, color: Colors.black),
// ),
// collapsed: const Text(''),
// expanded: Text(
// '${rulesList[index].rule}',
// style: const TextStyle(
// fontSize: 20, color: Colors.grey),
// ))));
// },
// itemCount: rulesList.length,
// )
// :  Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.center,
// children: const [
// Text(
// 'No bookmarks',
// style: TextStyle(color: Colors.grey, fontSize: 25),
// )
// ],
// )
