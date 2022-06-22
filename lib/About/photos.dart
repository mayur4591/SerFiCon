import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:serficon/Bottom_nav/roomOwnerList.dart';

class Photos extends StatefulWidget {
  const Photos({Key? key}) : super(key: key);

  @override
  State<Photos> createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.withOpacity(0.5),
        automaticallyImplyLeading: false,
        title: const Text(
          "Photos",
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
      body: buildHome(),
    );
  }

  Widget buildHome() {
    return FirebaseAnimatedList(
        // ignore: deprecated_member_use
        query: FirebaseDatabase.instance.reference().child(
            'Users/room_owners/$idFromRoomOwnerList/room_photos'),
        itemBuilder: (BuildContext cotext, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map<dynamic, dynamic>? owners = snapshot.value as Map?;
          return _buildListView(owners!);
        });
  }

  Widget _buildListView(Map photos) {
    print(photos.length);
    return Container(
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image(
        fit: BoxFit.cover,
        image: NetworkImage(photos['photo_url']),
      ),
    );
  }
}
