// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Bottom_nav/home.dart';
import '../Bottom_nav/mess_owner_list.dart';
import '../Owner/ownerProfile.dart';

class RoomOwnerMenuPage extends StatefulWidget {
  const RoomOwnerMenuPage({Key? key}) : super(key: key);
  static String id = 'MenuPage';
  @override
  State<RoomOwnerMenuPage> createState() =>_RoomOwnerMenuPage();
}

class _RoomOwnerMenuPage extends State<RoomOwnerMenuPage> {
  var role;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ignore: deprecated_member_use
    findRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    goToProfile();
                  },
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundImage:
                    AssetImage('assets/images/profile_png.jpg'),
                  ),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                margin: const EdgeInsets.only(left: 4, right: 4),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                //color: Colors.white,
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Center(
                    child: Text(
                      'Search for',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.blueAccent.withOpacity(0.1),
            expandedHeight: 380,
            flexibleSpace: FlexibleSpaceBar(
                background: Lottie.network(
                    'https://assets3.lottiefiles.com/packages/lf20_t7uqr8of.json')),
          ),
          SliverToBoxAdapter(
            child: Container(
              //padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 6, right: 6),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    },
                    child: Card(
                      elevation: 0,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        leading: const Icon(
                          Icons.home_outlined,
                          size: 30,
                        ),
                        subtitle: const Text(
                          'Find rooms and flats as per your need.',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        title: const Text(
                          'Rooms',
                          style: TextStyle(color: Colors.black, fontSize: 25),
                        ),
                        trailing: const Icon(
                          Icons.arrow_right_outlined,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MessOwners()));
                    },
                    child: Card(
                      elevation: 0,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        leading: const Icon(
                          Icons.food_bank_outlined,
                          size: 30,
                        ),
                        subtitle: const Text(
                          'Find best mess for you..',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        title: const Text(
                          'Mess',
                          style: TextStyle(color: Colors.black, fontSize: 25),
                        ),
                        trailing: const Icon(
                          Icons.arrow_right_outlined,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 450,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void goToProfile() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OwnerProfile()));

  }

  void findRole() {
    if (FirebaseAuth.instance.currentUser != null) {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      // ignore: deprecated_member_use
      FirebaseDatabase.instance
          .reference()
          .child('Users/all_users/$uid')
          .once()
          .then((value) {
        Map<dynamic, dynamic> map = value.snapshot.value as Map;
        role = map['role'];
        print(role);
        print(map['first_name']);
      });
    }
  }
}
