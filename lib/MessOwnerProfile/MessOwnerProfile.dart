import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serficon/MessOwnerProfile/mess_owner_drawer.dart';

class MessOwnerProfile extends StatefulWidget {
  const MessOwnerProfile({Key? key}) : super(key: key);

  @override
  State<MessOwnerProfile> createState() => _MessOwnerProfileState();
}

class _MessOwnerProfileState extends State<MessOwnerProfile> {
  final aboutOwnerController = TextEditingController();
  final breakfastController = TextEditingController();
  final lunchController = TextEditingController();
  final dinnerControoler = TextEditingController();
  final aboutrentController = TextEditingController();

  bool veg = false;
  bool nonveg = false;
  String fname = 'loading';
  String lname = '';
  String email = '';
  String url = '';
  String city = '';
  String messName = '';
  String locaton = '';
  String mobileNumber = '';
  String btime = 'Give timing';
  String ltime = 'Give timing';
  String dtime = 'Give timing';
  String aboutOwner = 'Add about your self..';
  String aboutrent = 'Give information about rents.';

  var image;

  final Image owner_profile_image = const Image(
      image: AssetImage("assets/images/profile_png.jpg"),
      fit: BoxFit.cover,
      height: 145,
      width: 145);

  bool isloding = false;

  Future<void> retriveData() async {
    //print(uid);
    print("Hey your id is ${FirebaseAuth.instance.currentUser!.uid}");
    await FirebaseDatabase.instance
        .reference()
        .child('Users/all_users/${FirebaseAuth.instance.currentUser!.uid}')
        .once()
        .then((value) {
      setState(() {
        if (value.snapshot != null) {
          Map<dynamic, dynamic>? map = value.snapshot.value as Map?;
          fname = map!['first_name'];
          lname = map['last_name'];
          email = map['email'];
          locaton = map['location'];
          messName = map['name'];
          veg = map['veg'] ?? false;
          nonveg = map['nonveg'] ?? false;
          mobileNumber = map['mobile_number'];
          aboutOwner = map['about_owner'] ?? 'Add about your self.';
          aboutrent =
              map['about_mess_rents'] ?? 'Give information about rents.';
          image = map['profile_image'];
          print(fname);
          print(lname);
          print(email);
          print(locaton);
          print(mobileNumber);
        } else {
          print(value.snapshot.value);
        }
      });
    });
  }

  Future<void> retriveTiming() async {
    await FirebaseDatabase.instance
        // ignore: deprecated_member_use
        .reference()
        .child(
            'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}/timing')
        .once()
        .then((value) {
      setState(() {
        Map<dynamic, dynamic> map = value.snapshot.value as Map;
        btime = map['breakfasttime'] ?? 'Give Breakfast time';
        ltime = map['lunchtime'] ?? 'Give Lunch time';
        dtime = map['dinnertime'] ?? 'Give Dinner time';
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retriveData();
    retriveTiming();
  }

  Future getOwnerImage(String name) async {
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
          .child('mess_owner')
          .child(FirebaseAuth.instance.currentUser!.uid)
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
                    'Users/mess_owners/${FirebaseAuth.instance.currentUser!.uid}')
                .update(map);
            FirebaseDatabase.instance
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
          image = url;
        });
      });
      setState(() {
        isloding = false;
      });
    } else if (name == 'Camera') {
      String? url;
      final profile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        isloding = true;
      });
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('mess_owner')
          .child(FirebaseAuth.instance.currentUser!.uid)
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
                    'Users/mess_owners/${FirebaseAuth.instance.currentUser!.uid}')
                .update(map);
            FirebaseDatabase.instance
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
          image = url;
        });
      });
      setState(() {
        isloding = false;
      });
    }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green.withOpacity(0.7),
        elevation: 0,
      ),
      endDrawer: MessOwnerDrawer(),
      body: isloding==false? ListView(
        children: [
          Card(
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
                    Text(
                      '$messName',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            shadowColor: Colors.grey,
            elevation: 0,
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
                                              focusedBorder:
                                                  OutlineInputBorder(),
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
                                              setState(() async {
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
                                                  aboutOwnerController.text =
                                                      '';
                                                  Map<String, dynamic> map = {
                                                    'about_owner':
                                                        aboutOwner.toString()
                                                  };
                                                  FirebaseDatabase.instance
                                                      .reference()
                                                      .child(
                                                          'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}')
                                                      .update(map)
                                                      .then((value) {
                                                    FirebaseDatabase.instance
                                                        .reference()
                                                        .child(
                                                            'Users/mess_owners/${FirebaseAuth.instance.currentUser!.uid}')
                                                        .update(map);
                                                  });
                                                  await FirebaseDatabase
                                                      .instance
                                                      .reference()
                                                      .child(
                                                          'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}')
                                                      .once()
                                                      .then((value) {
                                                    setState(() {
                                                      Map<dynamic, dynamic>?
                                                          map = value.snapshot
                                                              .value as Map?;
                                                      aboutOwner =
                                                          map!['about_owner'];
                                                    });
                                                  });
                                                  Navigator.pop(context, false);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        'Information updated...'),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ));
                                                }
                                              });
                                            },
                                            child: const Text(
                                              'Save ',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  Navigator.pop(context, false);
                                                });
                                              },
                                              child: const Text(
                                                ' Cancel',
                                                style: TextStyle(fontSize: 20),
                                              ))
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
                          subtitle: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(15),
                              child: Text(
                                aboutOwner,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              )),
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
                    '+91 $mobileNumber',
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          Card(
              child: Column(
            children: [
              ListTile(
                title: Text(
                  'Food type:',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              ListTile(
                trailing: Checkbox(
                  value: veg,
                  onChanged: (bool? value) {
                    Map<String, dynamic> map = {'veg': value};
                    FirebaseDatabase.instance
                        .reference()
                        .child(
                            'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}')
                        .update(map)
                        .then((value) {
                      FirebaseDatabase.instance
                          .reference()
                          .child(
                              'Users/mess_owners/${FirebaseAuth.instance.currentUser!.uid}')
                          .update(map);
                    });
                    print(value);
                    setState(() {
                      this.veg = value as bool;
                    });
                  },
                ),
                title: Text(
                  'Vegetarian.',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ListTile(
                trailing: Checkbox(
                  value: nonveg,
                  onChanged: (bool? value) {
                    Map<String, dynamic> map = {'nonveg': value};
                    // ignore: deprecated_member_use
                    FirebaseDatabase.instance
                        .reference()
                        .child(
                            'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}')
                        .update(map)
                        .then((value) {
                      FirebaseDatabase.instance
                          .reference()
                          .child(
                              'Users/mess_owners/${FirebaseAuth.instance.currentUser!.uid}')
                          .update(map);
                    });
                    print(value);
                    setState(() {
                      this.nonveg = value as bool;
                    });
                  },
                ),
                title: Text(
                  'Non-vegetarian.',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          )),
          Card(
            elevation: 0,
            child: ListTile(
              title: Text(
                'About rent',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              subtitle: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(15),
                  child: Text(
                    aboutrent,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )),
              trailing: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text(
                                "Write about mess rents.",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              content: TextField(
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder()),
                                keyboardType: TextInputType.multiline,
                                maxLines: 4,
                                controller: aboutrentController,
                                maxLength: 500,
                              ),
                              actions: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() async {
                                      if (aboutrentController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              'Fill the above information.'),
                                          backgroundColor: Colors.red,
                                        ));
                                      } else {
                                        setState(() {
                                          aboutrent = aboutrentController.text;
                                        });
                                        Map<String, dynamic> map = {
                                          'about_mess_rents':
                                              aboutrent.toString()
                                        };
                                        FirebaseDatabase.instance
                                            .reference()
                                            .child(
                                                'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}')
                                            .update(map)
                                            .then((value) {
                                          FirebaseDatabase.instance
                                              .reference()
                                              .child(
                                                  'Users/mess_owners/${FirebaseAuth.instance.currentUser!.uid}')
                                              .update(map);
                                        });

                                        Navigator.pop(context, false);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text('Information updated...'),
                                          backgroundColor: Colors.green,
                                        ));
                                      }
                                    });
                                  },
                                  child: const Text(
                                    'Save ',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.pop(context, false);
                                      });
                                    },
                                    child: const Text(
                                      ' Cancel',
                                      style: TextStyle(fontSize: 20),
                                    ))
                              ],
                            ));
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.grey,
                  )),
            ),
          ),
          Card(
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Timing',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                ListTile(
                  title: Text('Breakfast time'),
                  leading: Icon(
                    Icons.timer,
                    color: Colors.grey,
                  ),
                  trailing: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text(
                                    "Give breakfast timing.",
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
                                    controller: breakfastController,
                                    maxLength: 500,
                                  ),
                                  actions: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() async {
                                          if (breakfastController
                                              .text.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Fill the above information.'),
                                              backgroundColor: Colors.red,
                                            ));
                                          } else {
                                            setState(() {
                                              btime = breakfastController.text;
                                            });
                                            Map<String, dynamic> map = {
                                              'breakfasttime':
                                                  breakfastController.text
                                                      .toString()
                                            };
                                            // ignore: deprecated_member_use
                                            FirebaseDatabase.instance
                                                .reference()
                                                .child(
                                                    'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}')
                                                .child('timing')
                                                .update(map)
                                                .then((value) => {
                                                      FirebaseDatabase.instance
                                                          .reference()
                                                          .child(
                                                              'Users/mess_owners/${FirebaseAuth.instance.currentUser!.uid}')
                                                          .child('timing')
                                                          .update(map)
                                                          .then((value) => {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        const SnackBar(
                                                                  content: Text(
                                                                      'Information added sucsesfully...',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                ))
                                                              })
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
                                      child: const Text(
                                        'Save ',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            Navigator.pop(context, false);
                                          });
                                        },
                                        child: const Text(
                                          ' Cancel',
                                          style: TextStyle(fontSize: 20),
                                        ))
                                  ],
                                ));
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      )),
                  subtitle: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(15),
                    child: Text(
                      btime,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Lunch time'),
                  leading: Icon(
                    Icons.timer,
                    color: Colors.grey,
                  ),
                  trailing: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text(
                                    "Give lunch timing.",
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
                                    controller: lunchController,
                                    maxLength: 500,
                                  ),
                                  actions: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() async {
                                          if (lunchController.text.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Fill the above information.'),
                                              backgroundColor: Colors.red,
                                            ));
                                          } else {
                                            setState(() {
                                              ltime = lunchController.text;
                                            });
                                            Map<String, dynamic> map = {
                                              'lunchtime': lunchController.text
                                                  .toString()
                                            };
                                            // ignore: deprecated_member_use
                                            FirebaseDatabase.instance
                                                .reference()
                                                .child(
                                                    'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}')
                                                .child('timing')
                                                .update(map)
                                                .then((value) => {
                                                      // ignore: deprecated_member_use
                                                      FirebaseDatabase.instance
                                                          .reference()
                                                          .child(
                                                              'Users/mess_owners/${FirebaseAuth.instance.currentUser!.uid}')
                                                          .child('timing')
                                                          .update(map)
                                                          .then((value) => {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        const SnackBar(
                                                                  content: Text(
                                                                      'Information added sucsesfully...',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                ))
                                                              })
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
                                      child: const Text(
                                        'Save ',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            Navigator.pop(context, false);
                                          });
                                        },
                                        child: const Text(
                                          ' Cancel',
                                          style: TextStyle(fontSize: 20),
                                        ))
                                  ],
                                ));
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      )),
                  subtitle: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(15),
                    child: Text(
                      ltime,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Dinner time'),
                  leading: Icon(
                    Icons.timer,
                    color: Colors.grey,
                  ),
                  trailing: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text(
                                    "Give dinner timing.",
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
                                    controller: dinnerControoler,
                                    maxLength: 500,
                                  ),
                                  actions: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() async {
                                          if (dinnerControoler.text.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Fill the above information.'),
                                              backgroundColor: Colors.red,
                                            ));
                                          } else {
                                            setState(() {
                                              dtime = dinnerControoler.text;
                                            });
                                            Map<String, dynamic> map = {
                                              'dinnertime': dinnerControoler
                                                  .text
                                                  .toString()
                                            };
                                            // ignore: deprecated_member_use
                                            FirebaseDatabase.instance
                                                .reference()
                                                .child(
                                                    'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}')
                                                .child('timing')
                                                .update(map)
                                                .then((value) => {
                                                      FirebaseDatabase.instance
                                                          .reference()
                                                          .child(
                                                              'Users/mess_owners/${FirebaseAuth.instance.currentUser!.uid}')
                                                          .child('timing')
                                                          .update(map)
                                                          .then((value) => {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        const SnackBar(
                                                                  content: Text(
                                                                      'Information added sucsesfully...',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                ))
                                                              })
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
                                      child: const Text(
                                        'Save ',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            Navigator.pop(context, false);
                                          });
                                        },
                                        child: const Text(
                                          ' Cancel',
                                          style: TextStyle(fontSize: 20),
                                        ))
                                  ],
                                ));
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      )),
                  subtitle: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(15),
                    child: Text(
                      dtime,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ):Center(
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
          )),
    );
  }
}
