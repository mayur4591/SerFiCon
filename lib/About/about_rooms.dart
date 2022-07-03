import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../List_of_owners/roomOwnerList.dart';

class Rooms extends StatefulWidget {
  const Rooms({Key? key}) : super(key: key);

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  // ignore: deprecated_member_use
  final DatabaseReference reference = FirebaseDatabase.instance.reference();
  late FirebaseAuth auth;
  var availableRoomTypes = 'Not uploaded by owner yet';
  var numberOfRooms = 'Not uploaded by owner yet';
  var currentlyAvailableRooms = 'Not uploaded by owner yet';
  var roomRents = 'Not uploaded by owner yet';
  var roomAvailiblity = 'Not uploaded by owner yet';
  Future<void> getData() async {
    await reference
        .child('Users/all_users/$idFromRoomOwnerList/about_rooms')
        .once()
        .then((value) {
      setState(() {
        if (value.snapshot != null) {
          Map<dynamic, dynamic>? map = value.snapshot.value as Map?;
          availableRoomTypes =
              map!['available_room_types'] ?? 'Not uploaded by owner yet';
          numberOfRooms =
              map['total_number_of_rooms'] ?? 'Not uploaded by owner yet';
          currentlyAvailableRooms =
              map['currently_available_rooms'] ?? 'Not uploaded by owner yet';
          roomRents = map['room_rents'] ?? 'Not uploaded by owner yet';
          roomAvailiblity =
              map['rooms_available_for'] ?? 'Not uploaded by owner yet';
        } else {
          print(value.snapshot.value);
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = FirebaseAuth.instance;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            'About rooms',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView(
          children: [
            Card(
                child: ListTile(
                    title: ExpandablePanel(
              header: const Text(
                "Available room types",
                style: TextStyle(fontSize: 20),
              ),
              expanded: Text(
                availableRoomTypes,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
              collapsed: const Text(''),
            ))),
            Card(
                child: ListTile(
                    title: ExpandablePanel(
              header: const Text(
                "Total number of rooms",
                style: TextStyle(fontSize: 20),
              ),
              expanded: Text(
                numberOfRooms,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
              collapsed: const Text(''),
            ))),
            Card(
                child: ListTile(
                    title: ExpandablePanel(
              header: const Text(
                "Currently available rooms.",
                style: TextStyle(fontSize: 20),
              ),
              expanded: Text(
                currentlyAvailableRooms,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
              collapsed: const Text(''),
            ))),
            Card(
                child: ListTile(
                    title: ExpandablePanel(
              header: const Text(
                "Room rents",
                style: TextStyle(fontSize: 20),
              ),
              expanded: Text(
                roomRents,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
              collapsed: const Text(
                '',
                style: TextStyle(fontSize: 20),
              ),
            ))),
            Card(
                child: ListTile(
                    title: ExpandablePanel(
              header: const Text(
                "Rooms avilable for",
                style: TextStyle(fontSize: 20),
              ),
              expanded: Text(
                roomAvailiblity,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
              collapsed: const Text(
                '',
                style: TextStyle(fontSize: 20),
              ),
            ))),
          ],
        ));
  }
}
