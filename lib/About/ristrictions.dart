import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Bottom_nav/roomOwnerList.dart';
import '../Modal Classes/ristrictions_model.dart';

class Ristrictions extends StatefulWidget {
  const Ristrictions({Key? key}) : super(key: key);

  @override
  State<Ristrictions> createState() => _RistrictionsState();
}

class _RistrictionsState extends State<Ristrictions> {
  late Query _ref;

  final DatabaseReference reference = FirebaseDatabase.instance.reference();
  late FirebaseAuth auth;
  final titlecontroller = TextEditingController();
  final ruleController = TextEditingController();

  var title = 'Not given by owner yet';
  var rule = 'Not given by owner yet';

  bool list = true;
  check() {
    FirebaseDatabase.instance
        .reference()
        .child(
        'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}/ristrictions')
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
    // ignore: deprecated_member_use
    check();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('Users/room_owners/$idFromRoomOwnerList/ristrictions');
  }

  @override
  void dispose() {
    titlecontroller.dispose();
    ruleController.dispose();
    super.dispose();
  }

  Widget _buildListView(Map rule) {
    return Card(
        elevation: 2,
        margin: const EdgeInsets.all(12),
        child: ListTile(
            title: ExpandablePanel(
                header: Text(
                  rule['ruletitle'],
                  style: const TextStyle(fontSize: 25, color: Colors.black),
                ),
                collapsed: const Text(''),
                expanded: Text(
                  rule['ruledisc'],
                  style: const TextStyle(fontSize: 20, color: Colors.grey),
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            'Rules and ristrictions',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.lightGreen.withOpacity(0.5),
        ),
        body: list?buildHome() :Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Lottie.asset('assets/lottie/empty.json'),
    Container(
    margin: EdgeInsets.only(left: 25, right: 25),
    child: Center(
    child: Text(
    'Not uploaded yet ..!',
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.grey, fontSize: 25),
    )),
    )
    ],
    )
    );
  }

  Widget buildHome() {
    return FirebaseAnimatedList(
        query: _ref,
        itemBuilder: (BuildContext cotext, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map<dynamic, dynamic>? owners = snapshot.value as Map?;
          return _buildListView(owners!);
        });
  }
}
