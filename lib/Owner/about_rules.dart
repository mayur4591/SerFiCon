import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../Modal Classes/ristrictions_model.dart';

class About_Rules extends StatefulWidget {
  const About_Rules({Key? key}) : super(key: key);

  @override
  State<About_Rules> createState() => _About_RulesState();
}

class _About_RulesState extends State<About_Rules> {
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

    print(titlecontroller.text + ruleController.text);
    setState(() {
      rulesList.insert(0, ristrictionModel);
    });
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
        body: rulesList.isNotEmpty
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      elevation: 2,
                      margin: const EdgeInsets.all(12),
                      child: ListTile(
                          title: ExpandablePanel(
                              header: Text(
                                rulesList[index].title,
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
                        child: const Icon(
                          Icons.add_circle,
                          size: 80,
                          color: Colors.grey,
                        )),
                    const Text(
                      'Add Rules',
                      style: TextStyle(fontSize: 25, color: Colors.grey),
                      textAlign: TextAlign.center,
                    )
                  ],
                ))
        //],
        );
  }
}
