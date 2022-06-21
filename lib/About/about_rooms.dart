import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class Rooms extends StatelessWidget {
  const Rooms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        const Card(
            elevation: 2,
            child: ListTile(
                title: Text(
              'About Rooms',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ))),
        Card(
            child: ListTile(
                title: ExpandablePanel(
          header: const Text(
            "Available room types",
            style: TextStyle(fontSize: 20),
          ),
          expanded: const Text(
            '',
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          collapsed: const Text(''),
        ))),
        Card(
            child: ListTile(
                title: ExpandablePanel(
          header: const Text(
            "Total number of rooms",
            style: TextStyle(fontSize: 20),
          ),
          expanded: const Text(
            '',
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          collapsed: const Text(''),
        ))),
        Card(
            child: ListTile(
                title: ExpandablePanel(
          header: const Text(
            "Currently available rooms.",
            style: TextStyle(fontSize: 20),
          ),
          expanded: const Text(
            '',
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          collapsed: const Text(''),
        ))),
        Card(
            child: ListTile(
                title: ExpandablePanel(
          header: const Text(
            "Room rents",
            style: TextStyle(fontSize: 20),
          ),
          expanded: const Text(
            '',
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          collapsed: const Text(
            '',
            style: TextStyle(fontSize: 20),
          ),
        ))),
        Card(
            child: ListTile(
                title: ExpandablePanel(
          header: const Text(
            "Rooms avilable for",
            style: TextStyle(fontSize: 20),
          ),
          expanded: const Text(
            '',
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          collapsed: const Text(
            '',
            style: TextStyle(fontSize: 20),
          ),
        ))),
      ],
    ));
  }
}
