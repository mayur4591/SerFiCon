import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class About_Rooms extends StatefulWidget {
  const About_Rooms({Key? key}) : super(key: key);

  @override
  State<About_Rooms> createState() => _About_RoomsState();
}

// ignore: camel_case_types
class _About_RoomsState extends State<About_Rooms> {
  final roomNumberController = TextEditingController();
  final roomRentController = TextEditingController();
  final roomAvailablityController = TextEditingController();
  final currentlyAvalableRoomsController = TextEditingController();
  final availableRoomTypesController = TextEditingController();

  String numberOfRooms = "Add information.";
  String roomRents = "Add information.";
  String roomAvailiblity = "Add information.";
  String currentlyAvailableRooms = "Add information.";
  String availableRoomTypes = "Add information.";

  @override
  void dispose() {
    roomNumberController.dispose();
    roomRentController.dispose();
    roomAvailablityController.dispose();
    currentlyAvalableRoomsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          title: const Text(
            'About Rooms',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          backgroundColor: Colors.yellow.withOpacity(0.6),
        ),
        body: ListView(
      children: [
        Card(
          elevation: 2,
          child: ListTile(
            title: ExpandablePanel(
                header: const Text('Available room types',
                    style:
                        TextStyle(fontSize: 20)),
                collapsed: const Text(''),
                expanded: Text(
                  availableRoomTypes,
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                )),
            trailing: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Give avilable room types'),
                          content: SizedBox(
                              height: 250,
                              child: Column(
                                children: [
                                  TextField(
                                    decoration: const InputDecoration(
                                      hintText: "Give types.",
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    controller: availableRoomTypesController,
                                    maxLines: 4,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text('For example:'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ExpandablePanel(
                                      header: const Text(
                                        'Availabr room types',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      collapsed: const Text(''),
                                      expanded: const Text(
                                        '1)\tCot basis\n2)\tFlats\n3)\tShort Stay',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                      ))
                                ],
                              )),
                          actions: [
                            // ignore: deprecated_member_use
                            GestureDetector(
                                onTap: () {
                                  if (availableRoomTypesController
                                      .text.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                        'Give the information',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      backgroundColor: Colors.redAccent,
                                      elevation: 2,
                                      behavior: SnackBarBehavior.floating,
                                    ));
                                  } else {
                                    setState(() {
                                      availableRoomTypes =
                                          availableRoomTypesController.text;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            'Information added sucsesfully...',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        backgroundColor: Colors.green,
                                      ));
                                      availableRoomTypesController.text = '';
                                      Navigator.pop(context, false);
                                    });
                                  }
                                },
                                child: const Text('Add', style: TextStyle(fontSize: 20,color: Colors.blueAccent),)),
                            // ignore: deprecated_member_use
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, false);
                                },
                                child: const Text("Cancel",style: TextStyle(fontSize: 20,color: Colors.blueAccent),))
                          ],
                        ));
              },
              child: const Icon(
                Icons.edit,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Card(
            child: ListTile(
                title: ExpandablePanel(
                  header: const Text(
                    'Total number of rooms',
                    style: TextStyle(fontSize: 20),
                  ),
                  expanded: Text(
                    numberOfRooms,
                    style: const TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  collapsed: const Text(''),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text(
                                  'Add information about total number of rooms.'),
                              content: SizedBox(
                                  height: 50,
                                  child: Column(
                                    children: [
                                      TextField(
                                        decoration: const InputDecoration(
                                          hintText:
                                              "Enter total number of rooms.",
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller: roomNumberController,
                                      ),
                                    ],
                                  )),
                              actions: [
                                // ignore: deprecated_member_use
                                GestureDetector(
                                    onTap: () {
                                      if (roomNumberController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                            'Give the information',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          backgroundColor: Colors.redAccent,
                                          elevation: 2,
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                      } else {
                                        setState(() {
                                          numberOfRooms =
                                              roomNumberController.text;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Information added sucsesfully...',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            backgroundColor: Colors.green,
                                          ));
                                          roomNumberController.text = '';
                                          Navigator.pop(context, false);
                                        });
                                      }
                                    },
                                    child: const Text('Add',style: TextStyle(fontSize: 20,color: Colors.blueAccent),)),
                                // ignore: deprecated_member_use
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: const Text('Cancel',style: TextStyle(fontSize: 20,color: Colors.blueAccent),))

                              ],
                            ));
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                ))),
        Card(
            child: ListTile(
                title: ExpandablePanel(
                  header: const Text(
                    'Currentlly available rooms.',
                    style: TextStyle(fontSize: 20),
                  ),
                  expanded: Text(
                    currentlyAvailableRooms,
                    style: const TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  collapsed: const Text(''),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text(
                                  'Give currentlly available rooms.'),
                              content: SizedBox(
                                  height: 50,
                                  child: Column(
                                    children: [
                                      TextField(
                                        decoration: const InputDecoration(
                                          hintText: "Enter rooms number.",
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller:
                                            currentlyAvalableRoomsController,
                                      ),
                                    ],
                                  )),
                              actions: [
                                // ignore: deprecated_member_use
                                GestureDetector(
                                    onTap: () {
                                      if (currentlyAvalableRoomsController
                                          .text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                            'Give the information',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          backgroundColor: Colors.redAccent,
                                          elevation: 2,
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                      } else {
                                        setState(() {
                                          currentlyAvailableRooms =
                                              currentlyAvalableRoomsController
                                                  .text;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Information added sucsesfully...',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            backgroundColor: Colors.green,
                                          ));
                                          currentlyAvalableRoomsController
                                              .text = '';
                                          Navigator.pop(context, false);
                                        });
                                      }
                                    },
                                    child: const Text('Add',style: TextStyle(fontSize: 20,color: Colors.blueAccent),)),
                                // ignore: deprecated_member_use
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: const Text("Cancel",style: TextStyle(fontSize: 20,color: Colors.blueAccent),))
                              ],
                            ));
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                ))),
        SizedBox(height: 10,),
        Card(
          elevation: 2,
            child: ListTile(
                title: ExpandablePanel(
                  header: const Text(
                    'Room rents',
                    style: TextStyle(fontSize: 20),
                  ),
                  expanded: Text(
                    roomRents,
                    style: const TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  collapsed: const Text(''),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('Add information about rents.'),
                              content: SizedBox(
                                  height: 210,
                                  child: Column(
                                    children: [
                                      TextField(
                                        decoration: const InputDecoration(
                                          hintText:
                                              "Give information about room rent.",
                                        ),
                                        controller: roomRentController,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 2,
                                        maxLength: 200,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('For example:'),
                                      ExpandablePanel(
                                          header: const Text(
                                            'Room rents',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          collapsed: const Text(''),
                                          expanded: const Text(
                                            '1)\tCot basis:-\t 1700/month\n2)\tFlat:-\t15000/month\n3)\tShort Stay:-\t500/night',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ))
                                    ],
                                  )),
                              actions: [
                                // ignore: deprecated_member_use
                                GestureDetector(
                                    onTap: () {
                                      if (roomRentController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                            'Give the information',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          backgroundColor: Colors.redAccent,
                                          elevation: 2,
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                      } else {
                                        setState(() {
                                          roomRents = roomRentController.text;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Information added sucsesfully...',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            backgroundColor: Colors.green,
                                          ));
                                          roomRentController.text = '';
                                          Navigator.pop(context, false);
                                        });
                                      }
                                    },
                                    child: const Text('Add',style: TextStyle(fontSize: 20,color: Colors.blueAccent),)),
                                // ignore: deprecated_member_use
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: const Text("Cancel",style: TextStyle(fontSize: 20,color: Colors.blueAccent),))
                              ],
                            ));
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                ))),
        Card(
            child: ListTile(
                title: ExpandablePanel(
                  header: const Text(
                    'Rooms available for',
                    style: TextStyle(fontSize: 20),
                  ),
                  expanded: Text(
                    roomAvailiblity,
                    style: const TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  collapsed: const Text(''),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text(
                                  'Rooms available for? (students/familly etc.)'),
                              content: SizedBox(
                                  height: 120,
                                  child: Column(
                                    children: [
                                      TextField(
                                        decoration: const InputDecoration(
                                          hintText:
                                              "Give description about it.",
                                        ),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 4,
                                        maxLength: 250,
                                        controller: roomAvailablityController,
                                      )
                                    ],
                                  )),
                              actions: [
                                // ignore: deprecated_member_use
                                GestureDetector(
                                    onTap: () {
                                      if (roomAvailablityController
                                          .text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                            'Give the information',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          backgroundColor: Colors.redAccent,
                                          elevation: 2,
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                      } else {
                                        setState(() {
                                          roomAvailiblity =
                                              roomAvailablityController.text;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Information added sucsesfully...',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            backgroundColor: Colors.green,
                                          ));
                                          Navigator.pop(context, false);
                                        });
                                      }
                                    },
                                    child: const Text('Add',style: TextStyle(fontSize: 20,color: Colors.blueAccent),)),
                                // ignore: deprecated_member_use
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: const Text("Cancel",style: TextStyle(fontSize: 20,color: Colors.blueAccent),))
                              ],
                            ));
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                ))),
      ],
    ));
  }
}
