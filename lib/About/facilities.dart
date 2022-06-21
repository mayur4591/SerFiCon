import 'package:flutter/material.dart';

class Facilities extends StatelessWidget {
  const Facilities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
           Card(
            elevation: 2,
            child: ListTile(
              title: Text(
                'Facilities',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
