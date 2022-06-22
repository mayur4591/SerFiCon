import 'dart:io';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serficon/Bottom_nav/roomOwnerList.dart';

import '../About/about_rooms.dart';
import '../About/facilities.dart';
import '../About/photos.dart';
import '../About/ristrictions.dart';


class OwnerProfileToVisit extends StatefulWidget {
  const OwnerProfileToVisit({Key? key}) : super(key: key);
  static String id = 'Profile';

  @override
  State<OwnerProfileToVisit> createState() => _OwnerProfileToVisitState();
}

class _OwnerProfileToVisitState extends State<OwnerProfileToVisit> {
  final double coverHeight = 280;
  final double profileHeight = 144;
  final double bottom = 80;
  // ignore: deprecated_member_use
  final DatabaseReference reference=FirebaseDatabase.instance.reference();
  late FirebaseAuth auth;
  var fname;
  var lname;
  var email;
  var phoneNumber;
  var location;
  var aboutOwner='Not available yet..Wait until owner upload it.';
  // ignore: prefer_typing_uninitialized_variables
  var image;

  // ignore: non_constant_identifier_names
  final Image profile_image = const Image(
      image: AssetImage("assets/images/profile_png.jpg"),
      fit: BoxFit.cover,
      height: 145,
      width: 145);
  Future getImage(String name) async {
    if (name == 'Gallery') {
      final PickedFile pickedFile = await ImagePicker()
          // ignore: deprecated_member_use
          .getImage(source: ImageSource.gallery) as PickedFile;
      setState(() {
        image = File(pickedFile.path);
      });
    } else if (name == 'Camera') {
      final PickedFile pickedFile = await ImagePicker()
          // ignore: deprecated_member_use
          .getImage(source: ImageSource.camera) as PickedFile;
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }
  Future<void> getData() async {
    await reference.child('Users/room_owners/$idFromRoomOwnerList').once().then((value) {
      setState((){
        print(idFromRoomOwnerList);
        if(value.snapshot!=null) {
          Map<dynamic, dynamic>? map = value.snapshot.value as Map?;
          fname = map!['first_name'];
          lname = map['last_name'];
          email = map['email'];
          location = map['location'];
          phoneNumber = map['mobile_number'];
          aboutOwner=map['about_owner'] ?? 'Not available yet..Wait until owner upload it.';
          print(fname);
          print(lname);
          print(email);
          print(location);
          print(phoneNumber);
        }
        else{
          print(value.snapshot.value);
        }
      });
    });

  }
  var uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth=FirebaseAuth.instance;
    final User? user = auth.currentUser;
    uid = user!.uid;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            const Card(
              child: ListTile(
                tileColor: Colors.white,
                title: Text(
                  'Mali blocks',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
            ),
            buildTop(),
            buildInfo(),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Rooms()));
                },
                child: const Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text('About Rooms',
                          style: TextStyle(color: Colors.black, fontSize: 25)),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.grey,
                        size: 25,
                      ),
                    ))),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Facilities()));
              },
              child: const Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text('Facilities',
                        style: TextStyle(color: Colors.black, fontSize: 25)),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                      size: 25,
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const Photos()));
              },
              child: const Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text('Photos',
                        style: TextStyle(color: Colors.black, fontSize: 25)),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                      size: 25,
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Ristrictions()));
              },
              child: const Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text('Rules & Ristrictions',
                        style: TextStyle(color: Colors.black, fontSize: 25)),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                      size: 25,
                    ),
                  )),
            )
          ],
        ));
  }

  Image getProfile() {
    return (image != null)
        ? (Image.file(
            image,
            height: 145,
            width: 145,
            fit: BoxFit.cover,
          ))
        : (profile_image);
  }

  Widget buildProfileImage() => ClipOval(
        child: getProfile(),
      );

  Widget buildTop() => Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.29,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildProfileImage(),
              const SizedBox(
                height: 10,
              ),
              // Container(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       GestureDetector(
              //           onTap: () {
              //             getImage('Gallery');
              //           },
              //           child: const Icon(
              //             Icons.image,
              //             size: 30,
              //             color: Colors.blue,
              //           )),
              //       const SizedBox(
              //         width: 20,
              //       ),
              //       GestureDetector(
              //           onTap: () {
              //             getImage('Camera');
              //           },
              //           child: const Icon(
              //             Icons.camera_alt_outlined,
              //             size: 30,
              //             color: Colors.green,
              //           )),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
               Text(
                '$fname $lname',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Mali blocks',
                style:  TextStyle(color: Colors.grey, fontSize: 15),
              )
            ],
          ),
        ),
      );

  Widget buildInfo() => Card(
        shadowColor: Colors.grey,
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
                elevation: 0,
                child: Column(
                  children: [
                    ListTile(
                        title: ExpandablePanel(
                      header: const Text(
                        "About owner",
                        style: TextStyle(fontSize: 25),
                      ),
                      expanded:  Text(
                        '$aboutOwner',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      collapsed: const Text(''),
                    )),
                  ],
                )),
            const ListTile(
              title: Text('Contacts:',
                  style: TextStyle(color: Colors.black, fontSize: 25)),
            ),
             ListTile(
              leading: const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 25,
              ),
              title: const Text(
                "Location",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              subtitle: Text(
                '$location',
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
             ListTile(
              leading: const Icon(
                Icons.email_sharp,
                color: Colors.redAccent,
                size: 25,
              ),
              title: const Text(
                "E-mail",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              subtitle: Text(
                '$email',
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
             ListTile(
              leading: const Icon(
                Icons.phone,
                color: Colors.green,
                size: 25,
              ),
              title: const Text(
                "Phone",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              subtitle: Text(
                '+91 $phoneNumber',
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ],
        ),
      );

  Widget buildContent() => Column(
        children: [
           Text(
            '$fname $lname',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.call,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 10,
              ),
              Text('+91 $phoneNumber',
                  style: const TextStyle(fontSize: 20, color: Colors.grey))
            ],
          ),
        ],
      );
}
