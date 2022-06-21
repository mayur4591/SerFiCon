import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../Modal Classes/ristrictions_model.dart';

class About_Facilities extends StatefulWidget {
  const About_Facilities({Key? key}) : super(key: key);

  @override
  State<About_Facilities> createState() => _About_FacilitiesState();
}

class _About_FacilitiesState extends State<About_Facilities> {
  List<RistrictionModel> rulesList = [];
  final titlecontroller = TextEditingController();
  final ruleController = TextEditingController();

  void dispose() {
    titlecontroller.dispose();
    ruleController.dispose();
    super.dispose();
  }

  void addToList() {
    RistrictionModel ristrictionModel =
        RistrictionModel(titlecontroller.text, ruleController.text);

    print(titlecontroller.text + ruleController.text);
    setState(() {
      rulesList.insert(0, ristrictionModel);
    });
  }

  Future openDialoge() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Enter Facility'),
          content: Container(
              height: 260,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Facility name",
                    ),
                    controller: titlecontroller,
                  ),
                  TextField(
                    decoration:
                        InputDecoration(hintText: "Facility discription"),
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
                          'Electricity',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        collapsed: const Text(""),
                        expanded: const Text(
                          'We provide free electricity to students.',
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
                        behavior: SnackBarBehavior.floating));
                  } else {
                    addToList();
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                    ruleController.text = '';
                    titlecontroller.text = '';
                  }
                },
                child: const Text('ADD'))
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green.withOpacity(0.6),
          elevation: 1,
          title: Text(
            'Facilities',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            openDialoge();
          },
        ),
        body: rulesList.length != 0
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      elevation: 2,
                      margin: EdgeInsets.all(12),
                      child: ListTile(
                          title: ExpandablePanel(
                              header: Text(
                                '${rulesList[index].title}',
                                style: const TextStyle(
                                    fontSize: 25, color: Colors.black),
                              ),
                              collapsed: const Text(''),
                              expanded: Text(
                                '${rulesList[index].rule}',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.grey),
                              ))));
                },
                itemCount: rulesList.length,
              )
            : Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          openDialoge();
                        },
                        child: Icon(
                          Icons.add_circle,
                          size: 80,
                          color: Colors.grey,
                        )),
                    Text(
                      'Add Facilities',
                      style: TextStyle(fontSize: 25, color: Colors.grey),
                      textAlign: TextAlign.center,
                    )
                  ],
                ))
        //],
        );
  }
}
