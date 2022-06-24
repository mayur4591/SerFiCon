import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: camel_case_types
class Room_Photos extends StatefulWidget {
  const Room_Photos({Key? key}) : super(key: key);

  @override
  State<Room_Photos> createState() => _Room_PhotosState();
}

// ignore: camel_case_types
bool isloding = false;

class _Room_PhotosState extends State<Room_Photos> {
  final imagePicker = ImagePicker();
  late FirebaseAuth auth;
  var image;
  bool isloding = false;

  Future chooseImage(String name) async {
    if (name == 'Gallery') {
      final profile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      // ignore: deprecated_member_use
      var r = Random();
      var n1 = r.nextInt(16);
      var n2 = r.nextInt(15);
      if (n2 >= n1) {
        n2 = n2 + 1;
      }
      setState(() {
        isloding = true;
      });
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('room_owner')
          .child(auth.currentUser!.uid)
          .child('room_photos')
          .child('photo$n2');
      await ref.putFile(File(profile!.path));
      ref.getDownloadURL().then((value) {
        setState(() {
          // ignore: deprecated_member_use
          Map<String, dynamic> map = {'photo_url': value};
          FirebaseDatabase.instance
              // ignore: deprecated_member_use
              .reference()
              .child(
                  'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}/room_photos')
              .child('photo$n2')
              .update(map)
              .then((value) {
            FirebaseDatabase.instance
                // ignore: deprecated_member_use
                .reference()
                .child(
                    'Users/room_owners/${FirebaseAuth.instance.currentUser!.uid}/room_photos')
                .child('photo$n2')
                .update(map);
          });
        });
      });
      setState(() {
        isloding = false;
      });
    } else if (name == 'Camera') {
      String? url;
      var r = Random();
      var n1 = r.nextInt(16);
      var n2 = r.nextInt(15);
      if (n2 >= n1) {
        n2 = n2 + 1;
      }
      final profile = await ImagePicker().pickImage(source: ImageSource.camera);

      setState(() {
        isloding = true;
      });
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('room_owner')
          .child(auth.currentUser!.uid)
          .child('profile_image')
          .child('photo$n2');
      await ref.putFile(File(profile!.path));
      ref.getDownloadURL().then((value) {
        setState(() {
          // ignore: deprecated_member_use
          Map<String, dynamic> map = {'photo_url': value};
          FirebaseDatabase.instance
              // ignore: deprecated_member_use
              .reference()
              .child(
                  'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}/room_photos')
              .child('photo$n2')
              .update(map)
              .then((value) {
            FirebaseDatabase.instance
                // ignore: deprecated_member_use
                .reference()
                .child(
                    'Users/room_owners/${FirebaseAuth.instance.currentUser!.uid}/room_photos')
                .child('photo$n2')
                .update(map);
          });
          // print(value);
          // image = url;
        });
      });
      setState(() {
        isloding = false;
      });
    }
  }

  bool list = true;
  check() {
    FirebaseDatabase.instance
        .reference()
        .child(
            'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}/room_photos')
        .once()
        .then((value) => {
              if (value.snapshot.value == null)
                {
                  setState(() {
                    list = false;
                  })
                }
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = FirebaseAuth.instance;
    check();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.teal.withOpacity(0.5),
          automaticallyImplyLeading: false,
          title: const Text(
            "Photos",
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'btn1',
              backgroundColor: Colors.green,
              elevation: 2,
              onPressed: () {
                chooseImage('Gallery');
              },
              child: const Icon(
                Icons.image,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              heroTag: 'btn2',
              elevation: 5,
              onPressed: () {
                chooseImage('Camera');
              },
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: isloding == false
            ? list
                ? buildHome()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/lottie/empty.json'),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        child: Center(
                            child: Text(
                          'You have not uploaded anything..!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 25),
                        )),
                      )
                    ],
                  )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitThreeBounce(
                      size: 40,
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
                ),
              ));
  }
}

Widget buildHome() {
  return isloding == false
      ? FirebaseAnimatedList(
          query: FirebaseDatabase.instance.reference().child(
              'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}/room_photos'),
          itemBuilder: (BuildContext cotext, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map<dynamic, dynamic>? owners = snapshot.value as Map?;
            return _buildListView(owners!);
          })
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
          ),
        );
}

Widget _buildListView(Map photos) {
  print(photos.length);
  return Container(
    height: 280,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Image(
      fit: BoxFit.cover,
      image: NetworkImage(photos['photo_url']),
    ),
  );
}
