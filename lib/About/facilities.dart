import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:serficon/Bottom_nav/roomOwnerList.dart';

class Facilities extends StatefulWidget {
  const Facilities({Key? key}) : super(key: key);

  @override
  State<Facilities> createState() => _FacilitiesState();
}

class _FacilitiesState extends State<Facilities> {
  late Query _ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('Users/room_owners/$idFromRoomOwnerList/facilities');
  }

  Widget _buildListView(Map facility) {
    return Card(
        elevation: 2,
        margin: const EdgeInsets.all(12),
        child: ListTile(
            title: ExpandablePanel(
                header: Text(
                  facility['title'],
                  style: const TextStyle(
                      fontSize: 25, color: Colors.black),
                ),
                collapsed: const Text(''),
                expanded: Text(
                  facility['facility'],
                  style: const TextStyle(
                      fontSize: 20, color: Colors.grey),
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.withOpacity(0.6),
        elevation: 0,
        title: const Text('Facilities',style: TextStyle(color: Colors.black),),),
      body: buildHome(),
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
