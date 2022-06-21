import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final fnameEditingController = TextEditingController();
  final lnameEditingController = TextEditingController();
  final blockNameEditingController = TextEditingController();
  final phoneNoEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final locationEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.all(20),
            child: ListView(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Edit your information',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: fnameEditingController,
                    decoration: const InputDecoration(
                        hintText: 'First Name',
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: lnameEditingController,
                    decoration: const InputDecoration(
                        hintText: 'Last Name',
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: blockNameEditingController,
                    decoration: const InputDecoration(
                        hintText: 'Your room block name',
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: phoneNoEditingController,
                    decoration: const InputDecoration(
                        hintText: 'Phone no.',
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: emailEditingController,
                    decoration: const InputDecoration(
                        hintText: 'e-mail adress',
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: locationEditingController,
                    decoration: const InputDecoration(
                        hintText: 'Location',
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ignore: deprecated_member_use
                      GestureDetector(
                          onTap: () {},
                          child: Container(child: const Text('Save'), color: Colors.blue,
                          ),
                         ),
                      const SizedBox(
                        width: 35,
                      ),
                      // ignore: deprecated_member_use
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: const Text('Cancel'),
                          color: Colors.blue,
                        ),
                      )
                    ],
                  )
                ],
              )
            ])));
  }
}
