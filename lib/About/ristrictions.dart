import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

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

  var title='Not given by owner yet';
  var rule='Not given by owner yet';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ignore: deprecated_member_use
    _ref = FirebaseDatabase.instance.reference().child('Users/room_owners/$idFromRoomOwnerList/ristrictions');

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
                  style: const TextStyle(
                      fontSize: 25, color: Colors.black),
                ),
                collapsed: const Text(''),
                expanded: Text(
                  rule['ruledisc'],
                  style: const TextStyle(
                      fontSize: 20, color: Colors.grey),
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('Rules and ristrictions',style:TextStyle(color: Colors.black),),
        backgroundColor: Colors.lightGreen.withOpacity(0.5),
      ),
        body:buildHome()
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
