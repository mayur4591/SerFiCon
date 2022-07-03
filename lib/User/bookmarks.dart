import 'package:flutter/material.dart';
import '../Modal Classes/bookmark_modal.dart';
import '../Modal Classes/ristrictions_model.dart';

class BookMarks extends StatefulWidget {
  const BookMarks({Key? key}) : super(key: key);

  @override
  State<BookMarks> createState() => _BookMarksState();
}

List<BookmarkModal> bookmarkModallist = [];

class _BookMarksState extends State<BookMarks> {
  RistrictionModel ristrictionModel = RistrictionModel('Water', 'electricity');

  @override
  Widget build(BuildContext context) {
    // rulesList.add(ristrictionModel);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Bookmarks",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
              child: Text(
            'No bookmarks yet',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 30),
          ))
        ],
      ),
    );
  }
}
