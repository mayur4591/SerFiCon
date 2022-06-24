import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:serficon/Bottom_nav/roomOwnerList.dart';

class Photos extends StatefulWidget {
  const Photos({Key? key}) : super(key: key);

  @override
  State<Photos> createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {

  bool list=true;
  check()
  {
    FirebaseDatabase.instance.reference().child(
        'Users/all_users/${FirebaseAuth.instance.currentUser!.uid}/room_photos').once().then((value) => {
      if(value.snapshot.value==null)
        {
          setState((){
            list=false;
          })
        }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }
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
      body: list?buildHome():Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Lottie.asset('assets/lottie/empty.json'),
          Container(
            margin: EdgeInsets.only(left: 25,right: 25),
            child: Center(
                child: Text(
                  'Room owner have not uploaded any photos..!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 25),
                )),
          )
        ],
      ),
    );
  }

  Widget buildHome() {
    return FirebaseAnimatedList(
        // ignore: deprecated_member_use
        query: FirebaseDatabase.instance
            .reference()
            .child('Users/room_owners/$idFromRoomOwnerList/room_photos'),
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
