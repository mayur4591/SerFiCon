import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookmarkModal{
  late final String title;
  late final String subTitle;
  var backImage;
  bool flag;
  Color bookmarkIconColor=Colors.grey;


  BookmarkModal(this.title, this.subTitle, this.backImage, this.flag);
}