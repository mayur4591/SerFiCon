import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../List_of_owners/mess_owner_list.dart';

class MessOwnerProfileToVisit extends StatefulWidget {
  const MessOwnerProfileToVisit({Key? key}) : super(key: key);

  @override
  State<MessOwnerProfileToVisit> createState() =>
      _MessOwnerProfileToVisitState();
}

class _MessOwnerProfileToVisitState extends State<MessOwnerProfileToVisit> {
  String fname = 'loading';
  String lname = '';
  String email = '';
  String url = '';
  String city = '';
  String messName = '';
  String locaton = '';
  String mobileNumber = '';
  String btime = 'Not available yet.';
  String ltime = 'Not available yet.';
  String dtime = 'Not available yet.';
  String aboutOwner = 'Not available yet!';
  String aboutrent = 'Not available yet!';
  var image;

  bool veg=false;
  bool nonveg=false;

  final Image owner_profile_image = const Image(
      image: AssetImage("assets/images/profile_png.jpg"),
      fit: BoxFit.cover,
      height: 145,
      width: 145);
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
  Future<void> retriveData() async {
    //print(uid);
    print("Hey your id is ${FirebaseAuth.instance.currentUser!.uid}");
    await FirebaseDatabase.instance
        .reference()
        .child('Users/all_users/$idFromMessList')
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
          mobileNumber = map['mobile_number'];
          aboutOwner = map['about_owner'] ?? 'Not available yet!';
          aboutrent = map['about_mess_rents'] ?? 'Not given.';
          image = map['profile_image'];
          veg=map['veg']??false;
          nonveg=map['nonveg']??false;
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
  Future<void> retriveTiming()async{
    await FirebaseDatabase.instance
    // ignore: deprecated_member_use
        .reference()
        .child('Users/all_users/${FirebaseAuth.instance.currentUser!.uid}/timing').once().then((value) {
      setState((){
        Map<dynamic,dynamic> map=value.snapshot.value as Map;
        btime=map['breakfasttime']??'Give Breakfast time';
        ltime=map['lunchtime']??'Not available yet.';
        dtime=map['dinnertime']??'Not available yet.';
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retriveData();
    //getfoodType();
    retriveTiming();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green.withOpacity(0.6),
        elevation: 0,
      ),
      body: ListView(
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
                          title: const Text(
                            "About",
                            style: TextStyle(fontSize: 25),
                          ),
                          subtitle: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              padding: EdgeInsets.all(15),
                              child: Text(aboutOwner,style: TextStyle(fontSize: 15,color: Colors.black),)),
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
                trailing: veg?Icon(Icons.check,color: Colors.green,):Icon(Icons.close,color: Colors.red,),
                title: Text(
                  'Vegetarian.',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ListTile(
                trailing: nonveg?Icon(Icons.check,color: Colors.green,):Icon(Icons.close,color: Colors.red,),
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
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.all(15),
                  child: Text(aboutrent,style: TextStyle(fontSize: 15,color: Colors.black),)),
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
                  subtitle: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)
                    ),
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
                  subtitle: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)
                    ),
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
                  subtitle: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)
                    ),
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
      ),
    );
  }
}
