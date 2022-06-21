import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
class Room_Photos extends StatefulWidget {
  const Room_Photos({Key? key}) : super(key: key);

  @override
  State<Room_Photos> createState() => _Room_PhotosState();
}

// ignore: camel_case_types
class _Room_PhotosState extends State<Room_Photos> {
  List _images = [];
  late File imageFile;
  final imagePicker = ImagePicker();
  late String imgPath;

  chooseImage(String name) async {
    if (name == 'Gallery') {
      final PickedFile pickedFile =
          await imagePicker.getImage(source: ImageSource.gallery) as PickedFile;
      if (pickedFile != null) {
        setState(() {
          _images.insert(0, File(pickedFile.path));
        });
      }
    } else if (name == 'Camera') {
      final PickedFile pickedFile =
          await imagePicker.getImage(source: ImageSource.camera) as PickedFile;
      if (pickedFile != null) {
        setState(() {
          _images.insert(0, File(pickedFile.path));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.withOpacity(0.5),
          automaticallyImplyLeading: false,
          title: const Text(
            "Photos",
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.green,
              elevation: 2,
              onPressed: () {
                chooseImage('Gallery');
              },
              child: const Icon(
                Icons.image,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              elevation: 5,
              onPressed: () {
                chooseImage('Camera');
              },
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: _images.length != 0
            ? Container(
                color: Colors.white70,
                padding: EdgeInsets.only(left: 5),
                child: GridView.builder(
                  itemCount: _images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 5.0,
                      mainAxisExtent: 250),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          print(index);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Viewer(image: _images[index])));
                        },
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text(
                                      "Do you want to delete this image?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    actions: [
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _images.removeAt(index);
                                              Navigator.pop(context, false);
                                            });
                                          },
                                          child: Text("Yes")),
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: Text("No"))
                                    ],
                                  ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: FileImage(_images[index]),
                                fit: BoxFit.cover,
                                //filterQuality: FilterQuality.high
                              )),
                        ));
                  },
                ))
            : Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          chooseImage("Gallery");
                        },
                        child: Icon(
                          Icons.add_circle,
                          size: 80,
                          color: Colors.orange.withOpacity(0.5),
                        )),
                    const Text(
                      'Add photos',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                      textAlign: TextAlign.center,
                    )
                  ],
                )));
  }
}

class Viewer extends StatelessWidget {
  final File image;
  const Viewer({Key? key, required this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Card(
                elevation: 2,
                child: Container(
                    color: Colors.black12,
                    alignment: Alignment.center,
                    child: Image(
                      image: FileImage(image),
                      fit: BoxFit.fill,
                    )))));
  }
}
