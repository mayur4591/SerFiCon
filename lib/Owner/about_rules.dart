import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../Modal Classes/ristrictions_model.dart';

class About_Rules extends StatefulWidget {
  const About_Rules({Key? key}) : super(key: key);

  @override
  State<About_Rules> createState() => _About_RulesState();
}

class _About_RulesState extends State<About_Rules> {
  final titlecontroller = TextEditingController();
  final ruleController = TextEditingController();
  late Query _ref;
  final DatabaseReference reference=FirebaseDatabase.instance.reference();
  bool isloding=false;

  @override
  void dispose() {
    titlecontroller.dispose();
    ruleController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('Users/all_users/${FirebaseAuth.instance.currentUser!.uid}/ristrictions');

  }


  Future openDialoge() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Enter the rules and ristriction'),
          content: Container(
              height: 260,
              width: 200,
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "Ristriction name",
                    ),
                    controller: titlecontroller,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "Write  in short about ristrictions",
                    ),
                    controller: ruleController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('For example:-'),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: ListTile(
                      title: ExpandablePanel(
                        header: const Text(
                          'For Students',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        collapsed: const Text(""),
                        expanded: const Text(
                          'Gate will be closed for all at 11:30 pm',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ),
                    ),
                  )
                ],
              )),
          actions: [
            TextButton(
                onPressed: () {
                  if (ruleController.text.isEmpty ||
                      titlecontroller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Fill both ....',
                        style: TextStyle(fontSize: 20),
                      ),
                      backgroundColor: Colors.redAccent,
                      elevation: 2,
                      behavior: SnackBarBehavior.floating,
                    ));
                  } else {
                    setState((){
                      isloding=true;
                    });
                    var r=Random();
                    var n1=r.nextInt(16);
                    var n2=r.nextInt(15);
                    if(n2>=n1)
                    {
                      n2=n2+1;
                    }
                    Map<String,dynamic> map={'ruletitle':titlecontroller.text.toString(),'ruledisc':ruleController.text.toString()};
                    reference.child('Users/all_users/${FirebaseAuth.instance.currentUser!.uid}/ristrictions').child('rule$n2').update(map).then((value) {
                      reference.child('Users/room_owners/${FirebaseAuth.instance.currentUser!.uid}/ristrictions').child('rule$n2').update(map);
                    });

                    Navigator.of(context, rootNavigator: true).pop('dialog');
                    ruleController.text = '';
                    titlecontroller.text = '';
                  }
                  setState((){
                    isloding=false;
                  });
                },
                child: const Text('ADD'))
          ],
        ),
      );

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
          backgroundColor: Colors.lightGreen.withOpacity(0.5),
          elevation: 1,
          title: const Text(
            'Rules and ristriction',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Colors.red,
          onPressed: () {
            openDialoge();
          },
        ),
        body: isloding==false?buildHome():Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
          CircularProgressIndicator(color: Colors.blueAccent,),
          SizedBox(height: 20,),
          Text('Uploading...',style: TextStyle(color: Colors.grey,fontSize: 20),)
        ],),)
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
