import 'dart:io';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serficon/Owner/room_photos.dart';
import 'Drawer.dart';
import 'about_facilities.dart';
import 'about_room.dart';
import 'about_rules.dart';

class OwnerProfile extends StatefulWidget {
  const OwnerProfile({Key? key}) : super(key: key);
  static String id = "owner_profile";

  @override
  State<OwnerProfile> createState() => _OwnerProfileState();
}

class _OwnerProfileState extends State<OwnerProfile> {
  var image;
  var fname = 'loading...';
  var lname = '';
  var locaton = '';
  var phoneNumber = '';
  var email = '';
  String uid = '';
  late FirebaseAuth auth;
  // ignore: deprecated_member_use
  DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
  // ignore: deprecated_member_use

  var aboutOwner = 'Add about your self';
  final aboutOwnerController = TextEditingController();
  final Image owner_profile_image = const Image(
      image: AssetImage("assets/images/profile_png.jpg"),
      fit: BoxFit.cover,
      height: 145,
      width: 145);

  Future getOwnerImage(String name) async {
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

  @override
  void dispose() {
    // TODO: implement dispose
    aboutOwnerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ignore: deprecated_member_use
    auth = FirebaseAuth.instance;
    try{
      uid = auth.currentUser!.uid;
    }catch(e)
    {
      print(e);
    }
    //retriveData();
  }

  @override
  Widget build(BuildContext context) {
    retriveData();
    print(uid);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Mali Blocks',
          ),
          backgroundColor: Colors.blueAccent.withOpacity(0.5),
        ),
        endDrawer: NavigationDrawer(),
        body: ListView(
          children: [
            buildTop(),
            buildInfo(),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => About_Rooms()));
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => About_Facilities()));
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Room_Photos()));
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
                    MaterialPageRoute(builder: (context) => About_Rules()));
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
        : (owner_profile_image);
  }

  Widget buildProfileImage() => ClipOval(
        child: getProfile(),
      );

  Widget buildTop() => Card(
        elevation: 5,
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildProfileImage(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          getOwnerImage('Gallery');
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
                          getOwnerImage('Camera');
                        },
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 30,
                          color: Colors.green,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  fname + " " + lname,
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
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
          ),
        ),
      );

  Widget buildInfo() => Card(
        shadowColor: Colors.grey,
        elevation: 2,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      ListTile(
                        trailing: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text(
                                        "Write about your self.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      content: TextField(
                                        decoration: const InputDecoration(
                                            focusedBorder: OutlineInputBorder(),
                                            enabledBorder:
                                                OutlineInputBorder()),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 4,
                                        controller: aboutOwnerController,
                                        maxLength: 500,
                                      ),
                                      actions: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (aboutOwnerController
                                                  .text.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                      'Fill the above information.'),
                                                  backgroundColor: Colors.red,
                                                ));
                                              } else {
                                                aboutOwner =
                                                    aboutOwnerController.text;
                                                aboutOwnerController.text = '';
                                                Navigator.pop(context, false);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                      'Information updated...'),
                                                  backgroundColor: Colors.green,
                                                ));
                                              }
                                            });
                                          },
                                          child: const Text('Save'),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                Navigator.pop(context, false);
                                              });
                                            },
                                            child: const Text('Cancel'))
                                      ],
                                    ));
                          },
                          child: Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                        title: ExpandablePanel(
                          header: const Text(
                            "About",
                            style: TextStyle(fontSize: 25),
                          ),
                          expanded: Text(
                            aboutOwner,
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          collapsed: const Text(''),
                        ),
                      ),
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
                  locaton,
                  style: TextStyle(color: Colors.grey, fontSize: 15),
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
                  email,
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
                  '$phoneNumber',
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      );

  Future<void> retriveData() async {
    print(uid);
    setState(() {
      print("Hey your id is $uid");
      databaseRef.child('Users/all_users/$uid').once().then((value) {

        if(value.snapshot!=null) {
          Map<dynamic, dynamic>? map = value.snapshot.value as Map?;
          fname = map!['first_name'];
          lname = map['last_name'];
          email = map['email'];
          locaton = map['location'];
          phoneNumber = map['mobile_number'];
          print(fname);
          print(lname);
          print(email);
          print(locaton);
          print(phoneNumber);
        }
        else{
          print(value.snapshot.value);
        }

      });
    });
  }
}

// const Card(
//   child: ListTile(
//     tileColor: Colors.white,
//     title: Text(
//       'Mali blocks',
//       style: TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.bold,
//           fontSize: 25),
//     ),
//     leading: Icon(
//       Icons.edit,
//       color: Colors.grey,
//     ),
//     trailing: Icon(
//       Icons.menu,
//       color: Colors.grey,
//     ),
//   ),
// ),
