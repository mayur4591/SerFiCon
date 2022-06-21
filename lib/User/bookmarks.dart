import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';


import '../Modal Classes/bookmark_modal.dart';
import '../Modal Classes/ristrictions_model.dart';

class BookMarks extends StatefulWidget {
  const BookMarks({Key? key}) : super(key: key);

  @override
  State<BookMarks> createState() => _BookMarksState();
}
List<BookmarkModal> bookmarkModallist=[];


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
       body:
      // !(bookmarkModallist.isEmpty)
      //     ? ListView.builder(
      //   shrinkWrap: true,
      //         itemBuilder: (BuildContext context, int index) {
      //           return Container(
      //               padding: EdgeInsets.all(5),
      //               child: SizedBox(
      //                   child: Card(
      //                     elevation: 2,
      //                     child: ListTile(
      //                       trailing: GestureDetector(
      //                           onTap: () {
      //                           },
      //                           child: Icon(
      //                             Icons.bookmark,
      //                             color: tempList[index],
      //                           )),
      //                       leading: CircleAvatar(
      //                         radius: 32,
      //                         backgroundImage: list[index].backImage,
      //                       ),
      //                       title: Text(
      //                         list[index].title,
      //                         style: const TextStyle(fontSize: 25),
      //                       ),
      //                       subtitle: Text(list[index].subTitle,
      //                           style: const TextStyle(
      //                               fontSize: 15, color: Colors.grey)),
      //                     ),
      //                   )));
      //         },
      //         itemCount: bookmarkModallist.length,
      //       )
      //     :
          Column(
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
