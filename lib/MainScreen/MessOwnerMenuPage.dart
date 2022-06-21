import 'package:flutter/material.dart';

class MessOwnerMenuPage extends StatefulWidget {
  const MessOwnerMenuPage({Key? key}) : super(key: key);

  @override
  State<MessOwnerMenuPage> createState() => _MessOwnerMenuPageState();
}

class _MessOwnerMenuPageState extends State<MessOwnerMenuPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Mess Owner'),
    );
  }
}
