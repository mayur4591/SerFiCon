import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:serficon/Owner/room_owner_profile_to_visit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

// ignore: deprecated_member_use
String idFromRoomOwnerList = '';

class _HomeState extends State<Home> {
  late Query _ref;
  var url;
  bool isloding=false;
bool list=true;
check()
{
  _ref.once().then((value) => {
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
    // ignore: deprecated_member_use
    //getProfileImage();
    // ignore: deprecated_member_use
    _ref = FirebaseDatabase.instance.reference().child('Users/room_owners');
    check();
  }

  Widget _buildListView(Map owners) {
    print(owners.values);
    return  Card(
            elevation: 2,
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.2),
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(
                          '${owners['name']}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      trailing: Container(
                        margin: const EdgeInsets.only(right: 10, bottom: 2),
                        child: ElevatedButton(
                          onPressed: () {
                            print(owners.keys);
                            setState((){
                              isloding=true;
                            });
                            setState(() {
                              idFromRoomOwnerList = owners['id'];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OwnerProfileToVisit()));
                            });
                            setState((){
                              isloding=false;
                            });
                          },
                          child: const Text('View this'),
                        ),
                      ),
                    ),
                  ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10,left: 20),
                                child: const Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Center(
                                        child: Text(
                                          owners['city'],
                                          style: const TextStyle(color: Colors.black),
                                        ),

                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10,left: 20),
                                child: const Icon(
                                  Icons.add_ic_call_rounded,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Center(
                                      child: Text(
                                        '+91 ${owners['mobile_number']}',
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                    ),

                                  ],
                                ),
                              ), //SizedBox(width: 10,),

                        ],
                      ),
                ],
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.orangeAccent.withOpacity(.4),
        title: Center(
          child: Text(
            'Available room owners',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body:  list ? buildHome()
          :Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Lottie.asset('assets/lottie/empty.json'),
          Container(
            margin: EdgeInsets.only(left: 25,right: 25),
            child: Center(
                child: Text(
                  'No owner has registered yet please wait until they do,we will inform if they registered...',
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
        query: _ref,
        itemBuilder: (BuildContext cotext, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map<dynamic, dynamic>? owners = snapshot.value as Map?;
          return _buildListView(owners!);
        });
  }
}
