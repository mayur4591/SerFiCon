import 'package:flutter/material.dart';

import '../Modal Classes/ristrictions_model.dart';

class Ristrictions extends StatefulWidget {
  const Ristrictions({Key? key}) : super(key: key);

  @override
  State<Ristrictions> createState() => _RistrictionsState();
}

class _RistrictionsState extends State<Ristrictions> {
  List<RistrictionModel> rulesList = [];
  final titlecontroller = TextEditingController();
  final ruleController = TextEditingController();

  @override
  void dispose() {
    titlecontroller.dispose();
    ruleController.dispose();
    super.dispose();
  }

  void addToList() {
    RistrictionModel ristrictionModel =
        RistrictionModel(titlecontroller.text, ruleController.text);

    setState(() {
      rulesList.insert(0, ristrictionModel);
    });
  }

  // Future openDialoge() => showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text('Enter the rules and ristriction'),
  //         content: Container(
  //             height: 100,
  //             child: Column(
  //               children: [
  //                 TextField(
  //                   decoration: InputDecoration(
  //                     hintText: "Title",
  //                   ),
  //                   controller: titlecontroller,
  //                 ),
  //                 TextField(
  //                   decoration: InputDecoration(hintText: "Enter rules"),
  //                   controller: ruleController,
  //                 ),
  //               ],
  //             )),
  //         actions: [
  //           TextButton(
  //               onPressed: () {
  //                 if (ruleController.text.isEmpty ||
  //                     titlecontroller.text.isEmpty) {
  //                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                       content: Text(
  //                         'Fill both ....',
  //                         style: TextStyle(fontSize: 20),
  //                       ),
  //                       backgroundColor: Colors.redAccent,
  //                       elevation: 2,
  //                       behavior: SnackBarBehavior.floating));
  //                 } else {
  //                   addToList();
  //                   Navigator.of(context, rootNavigator: true).pop('dialog');
  //                   ruleController.text = '';
  //                   titlecontroller.text = '';
  //                 }
  //               },
  //               child: const Text('ADD'))
  //         ],
  //       ),
  //     );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children:const [
            Card(
                elevation: 2,
                child: ListTile(
                    title: Text(
                      'Rules and ristriction',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                )
            ),
        // ListView.builder(
        //   itemBuilder: (BuildContext context, int index) {
        //     return Card(
        //         elevation: 2,
        //         margin: EdgeInsets.all(12),
        //         child: ListTile(
        //             title: ExpandablePanel(
        //                 header: Text(
        //                   '${rulesList[index].title}',
        //                   style: const TextStyle(
        //                       fontSize: 25, color: Colors.black),
        //                 ),
        //                 collapsed: const Text(''),
        //                 expanded: Text(
        //                   '${rulesList[index].rule}',
        //                   style:
        //                       const TextStyle(fontSize: 20, color: Colors.grey),
        //                 ))));
        //   },
        //   itemCount: rulesList.length,
        // )
        ],
        ));
    //],
    // ),
  }
}
