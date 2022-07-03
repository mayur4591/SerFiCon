import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:lottie/lottie.dart';
import 'package:serficon/MessOwnerProfile/MessOwnerProfileToVisit.dart';

class MessOwners extends StatefulWidget {
  const MessOwners({Key? key}) : super(key: key);

  @override
  State<MessOwners> createState() => _MessOwners();
}

// ignore: deprecated_member_use

String idFromMessList = '';

class _MessOwners extends State<MessOwners> {
  late Query _ref;
  bool list = true;
  bool veg = false;
  bool nonveg = false;

  check() {
    _ref.once().then((value) => {
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
    _ref = FirebaseDatabase.instance.reference().child('Users/mess_owners').orderByChild('name'); 
    check();
  }

  bool getVegStatus(String id) {
    FirebaseDatabase.instance
        .reference()
        .child('Users/mess_owners/$idFromMessList/food_type')
        .once()
        .then((value) {
      setState(() {
        Map<dynamic, dynamic> map = value.snapshot.value as Map;
        veg = map['veg'] ?? false;
      });
    });
    return veg;
  }

  bool getNonVegStateus(String id) {
    FirebaseDatabase.instance
        // ignore: deprecated_member_use
        .reference()
        .child('Users/mess_owners/$idFromMessList/')
        .once()
        .then((value) {
      setState(() {
        Map<dynamic, dynamic> map = value.snapshot.value as Map;
        nonveg = map['nonveg'] ?? false;
      });
    });
    return nonveg;
  }

  Widget _buildListView(Map owners) {
    return Card(
      elevation: 1,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(
                  Icons.food_bank_outlined,
                  color: Colors.orangeAccent,
                  size: 40,
                ),
                title: Text(
                  '${owners['name']}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                trailing: Container(
                  margin: const EdgeInsets.only(right: 10, bottom: 2),
                  child: ElevatedButton(
                    onPressed: () {
                      print(owners.keys);

                      setState(() {
                        idFromMessList = owners['id'];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MessOwnerProfileToVisit()));
                      });
                    },
                    child: const Text('View this'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10, left: 10),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.2),
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
                  ],
                ),

                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10, left: 10),
                      child: const Icon(
                        Icons.add_ic_call_rounded,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.2),
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
                    ),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                //SizedBox(width: 10,),
                (owners['veg'] != null && owners['veg'] == true)
                    ? Visibility(
                        visible: owners['veg'] != null
                            ? owners['veg']
                            : false, //getVegStatus(owners['id']),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10, left: 3),
                              child: const Icon(
                                Icons.verified,
                                color: Colors.green,
                                size: 20,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: 10, left: 3, right: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.teal.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Center(
                                    child: Text(
                                      'Vegetarian',
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Visibility(
                        visible: (owners['nonveg'] != null &&
                                owners['nonveg'] == true)
                            ? owners['nonveg']
                            : false, //getNonVegStateus(owners['id']),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: const Icon(
                                Icons.verified,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10, left: 2),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.teal.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Center(
                                    child: Text(
                                      'Non-Vegetarian',
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
            (owners['veg'] != null &&
                    owners['veg'] == true &&
                    owners['nonveg'] == true)
                ? Visibility(
                    visible:
                        owners['nonveg'] != null ? owners['nonveg'] : false,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10, left: 10),
                          child: const Icon(
                            Icons.verified,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 10,
                          ),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Center(
                                child: Text(
                                  'Non-Vegetarian',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Text('')
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
          title: Text('Available Mess Owners',style: TextStyle(color: Colors.black),)),
      body: list
          ? buildHome()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/empty.json'),
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
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
