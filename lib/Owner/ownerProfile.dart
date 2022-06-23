import 'dart:io';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  bool isloding=false;
  var image;
  var fname = 'loading...';
  var lname = '';
  var locaton = '';
  var phoneNumber = '';
  var email = '';
  String uid = '';
  late FirebaseAuth auth;
  // ignore: deprecated_member_use
  final DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
  // ignore: deprecated_member_use
  Future<void> retriveData() async {
    print(uid);
    print("Hey your id is $uid");
    await databaseRef.child('Users/all_users/$uid').once().then((value) {
      setState(() {
        if (value.snapshot != null) {
          Map<dynamic, dynamic>? map = value.snapshot.value as Map?;
          fname = map!['first_name'];
          lname = map['last_name'];
          email = map['email'];
          locaton = map['location'];
          phoneNumber = map['mobile_number'];
          aboutOwner = map['about_owner'] ?? 'Add about your self.';
          image = map['profile_image'];
          print(fname);
          print(lname);
          print(email);
          print(locaton);
          print(phoneNumber);
        } else {
          print(value.snapshot.value);
        }
      });
    });
  }

  var aboutOwner = 'Add about your self..';
  final aboutOwnerController = TextEditingController();
  final Image owner_profile_image = const Image(
      image: AssetImage("assets/images/profile_png.jpg"),
      fit: BoxFit.cover,
      height: 145,
      width: 145);

  Future getOwnerImage(String name) async {
    if (name == 'Gallery') {
      String? url;

      final profile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      setState((){
        isloding=true;
      });
      // ignore: deprecated_member_use
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('room_owner')
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
                .reference()
                .child(
                    'Users/room_owners/${FirebaseAuth.instance.currentUser!.uid}')
                .update(map);
            FirebaseDatabase.instance
                .reference()
                .child(
                    'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}/profile_image')
                .once()
                .then((value) {
              setState(() {
                url = value.snapshot.value as String?;
              });
            });
          });
          print(value);
          image = url;
        });
      });
      setState((){
        isloding=false;
      });
    } else if (name == 'Camera') {
      String? url;
      final profile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      setState((){
        isloding=true;
      });
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('room_owner')
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
                .reference()
                .child(
                    'Users/room_owners/${FirebaseAuth.instance.currentUser!.uid}')
                .update(map);
            FirebaseDatabase.instance
                .reference()
                .child(
                    'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}/profile_image')
                .once()
                .then((value) {
              setState(() {
                url = value.snapshot.value as String?;
              });
            });
          });
          print(value);
          image = url;
        });
      });
      setState((){
        isloding=false;
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
    // ignore: deprecated_member_use
    final User? user = auth.currentUser;
    uid = user!.uid;
    setState((){
      isloding=true;
    });
    getProfile();
    retriveData();
    setState((){
      isloding=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Profile',
          ),
          backgroundColor: Colors.deepPurple.withOpacity(0.4),
        ),
        endDrawer: const NavigationDrawer(),
        body: isloding == false? ListView(
          children: [
            buildTop(),
            buildInfo(),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const About_Rooms()));
                },
                child: const Card(
                    elevation: 1,
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
                        builder: (context) => const About_Facilities()));
              },
              child: const Card(
                  elevation: 1,
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
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Room_Photos()));
              },
              child: const Card(
                  elevation: 1,
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const About_Rules()));
              },
              child: const Card(
                  elevation: 1,
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
        ):Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.blueAccent,),
              SizedBox(height: 10,),
              Text('Loading...',style: TextStyle(color: Colors.grey,fontSize: 20),),
            ],
          ),
        ));
  }

  Image getProfile() {
    return (image != null)
        ? (Image.network(
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
        elevation: 1,
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            color: Colors.white,
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
                  "$fname $lname",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildInfo() => Card(
        shadowColor: Colors.grey,
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
                elevation: 0,
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
                                          enabledBorder: OutlineInputBorder()),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 4,
                                      controller: aboutOwnerController,
                                      maxLength: 500,
                                    ),
                                    actions: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() async {
                                            if (aboutOwnerController
                                                .text.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Fill the above information.'),
                                                backgroundColor: Colors.red,
                                              ));
                                            } else {
                                              aboutOwner =
                                                  aboutOwnerController.text;
                                              aboutOwnerController.text = '';
                                              Map<String, dynamic> map = {
                                                'about_owner':
                                                    aboutOwner.toString()
                                              };
                                              databaseRef
                                                  .child(
                                                      'Users/all_users/${auth.currentUser!.uid}')
                                                  .update(map)
                                                  .then((value) {
                                                databaseRef
                                                    .child(
                                                        'Users/room_owners/${auth.currentUser!.uid}')
                                                    .update(map);
                                              });
                                              await databaseRef
                                                  .child('Users/all_users/$uid')
                                                  .once()
                                                  .then((value) {
                                                setState(() {
                                                  if (value.snapshot != null) {
                                                    Map<dynamic, dynamic>? map =
                                                        value.snapshot.value
                                                            as Map?;
                                                    aboutOwner =
                                                        map!['about_owner'];
                                                  } else {
                                                    print(value.snapshot.value);
                                                  }
                                                });
                                              });
                                              Navigator.pop(context, false);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
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
                        child: const Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                      title: const Text(
                        "About",
                        style: TextStyle(fontSize: 25),
                      ),
                      subtitle: Text(aboutOwner),
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
                '+91 $phoneNumber',
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ],
        ),
      );
}
