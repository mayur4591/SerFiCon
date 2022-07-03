import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  late FirebaseAuth auth;
  var userImage;
  var fname = 'loading...';
  var lname = '';
  var uid;
  var image;
  bool isloding = false;

  // get databaseRef => null;

  Future<void> fetch() async {
    await databaseRef.child('Users/all_users/$uid').once().then((event) async {
      setState(() {
        Map<dynamic, dynamic>? map = event.snapshot.value as Map?;
        fname = map!['first_name'];
        lname = map['last_name'];
        image = map['profile_image'] ;
            // Image(
            //     image: AssetImage("assets/images/profile_png.jpg"),
            //     fit: BoxFit.cover,
            //     height: 145,
            //     width: 145);
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
      String? url;
      final profile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        isloding = true;
      });
      // ignore: deprecated_member_use
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('all_users')
          .child(auth.currentUser!.uid)
          .child('profile_image');
      await ref.putFile(File(profile!.path));
      ref.getDownloadURL().then((value) {
        setState(() {
          // ignore: deprecated_member_use
          Map<String, dynamic> map = {'profile_image': value};
          FirebaseDatabase.instance
              .reference()
              .child(
                  'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}')
              .update(map)
              .then((value) {
            FirebaseDatabase.instance
                // ignore: deprecated_member_use
                .reference()
                .child(
                    'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}/profile_image')
                .once()
                .then((value) {
              setState(() {
                url = value.snapshot.value as String?;
                image = url;
              });
            });
          });
          print(value);
        });
      });
      setState(() {
        isloding = false;
      });
    } else if (name == 'Camera') {
      String? url;
      final profile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        isloding = true;
      });
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('all_users')
          .child(auth.currentUser!.uid)
          .child('profile_image');
      await ref.putFile(File(profile!.path));
      ref.getDownloadURL().then((value) {
        setState(() {
          // ignore: deprecated_member_use
          Map<String, dynamic> map = {'profile_image': value};
          FirebaseDatabase.instance
              .reference()
              .child(
                  'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}')
              .update(map)
              .then((value) {
            FirebaseDatabase.instance
                // ignore: deprecated_member_use
                .reference()
                .child(
                    'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}/profile_image')
                .once()
                .then((value) {
              setState(() {
                url = value.snapshot.value as String?;
                image = url;
              });
            });
          });
          print(value);
        });
      });
      setState(() {
        isloding = false;
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
    auth = FirebaseAuth.instance;
    // ignore: deprecated_member_use
    final User? user = auth.currentUser;
    uid = user?.uid;
    fetch();
  }

  Image getProfile() {
    return (image != null)
        ? (Image.network(
            image,
            height: 145,
            width: 145,
            fit: BoxFit.cover,
          ))
        : user_profile_image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueAccent.withOpacity(0.8),
          title: const Text(
            "Profile",
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
        ),
        endDrawer: const UserDrawer(),
        body: isloding == false
            ? Column(children: [
                Card(
                  child: Column(
                    children: [
                      buildUserProfileImage(),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '$fname $lname',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
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
              ])
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Uploading...',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  )
                ],
              )));
  }
}

