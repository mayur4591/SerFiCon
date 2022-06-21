import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 33,),
          buildSearch(),
        ],
      ),
    );
  }

  Widget buildSearch() =>
       Container(
         height: 55,
           padding: EdgeInsets.all(8),
          child:
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
                icon: Icon(Icons.search_rounded, color: Colors.blueAccent,),
                hintText: 'Search here...',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18)

                )
            ),
          )
      );
}
