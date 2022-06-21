import 'dart:io';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../About/about_rooms.dart';
import '../About/facilities.dart';
import '../About/photos.dart';
import '../About/ristrictions.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  static String id = 'Profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final double coverHeight = 280;
  final double profileHeight = 144;
  final double bottom = 80;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white30,
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
              const Text(
                'MAYUR KAMBLE',
                style: TextStyle(
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
                      expanded: const Text(
                        'Hello i am a student at walchand college of enginnering sangli am a second year student of computer science.',
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
            const ListTile(
              leading: Icon(
                Icons.location_on,
                color: Colors.red,
                size: 25,
              ),
              title: Text(
                "Location",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              subtitle: Text(
                'Rui,Maharashtra',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.email_sharp,
                color: Colors.redAccent,
                size: 25,
              ),
              title: Text(
                "E-mail",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              subtitle: Text(
                'mayurkamble847@gmail.com',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.phone,
                color: Colors.green,
                size: 25,
              ),
              title: Text(
                "Phone",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              subtitle: Text(
                '+91 9604221742',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ],
        ),
      );

  Widget buildContent() => Column(
        children: [
          const Text(
            'MAYUR KAMBLE',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: const [
              Icon(
                Icons.call,
                color: Colors.grey,
              ),
              SizedBox(
                width: 10,
              ),
              Text('9786950435',
                  style: TextStyle(fontSize: 20, color: Colors.grey))
            ],
          ),
        ],
      );
}
