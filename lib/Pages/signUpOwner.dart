import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:serficon/Modals/ownerModal.dart';

class SignUpOwner extends StatefulWidget {
  const SignUpOwner({Key? key}) : super(key: key);

  @override
  State<SignUpOwner> createState() => _SignUpOwnerState();
}

class _SignUpOwnerState extends State<SignUpOwner> {
  // ignore: deprecated_member_use
  DatabaseReference dataBRef = FirebaseDatabase.instance.reference();
  late final FirebaseAuth auth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = FirebaseAuth.instance;
  }

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final mobileController = TextEditingController();
  final locationController = TextEditingController();
  final emailController = TextEditingController();
  final passwordControll = TextEditingController();
  String selectedItem = '';
  var data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: const Text(
                'Give your creidentials to be a part of our familly.',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: fnameController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.blueAccent.withOpacity(0.2),
                  filled: true,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: 'First Name',
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: lnameController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                fillColor: Colors.blueAccent.withOpacity(0.2),
                filled: true,
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                hintText: 'Last Name',
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: mobileController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.blueAccent.withOpacity(0.2),
                  filled: true,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: 'Mobile number',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: const Icon(
                    Icons.phone,
                    color: Colors.grey,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: locationController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.blueAccent.withOpacity(0.2),
                  filled: true,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: 'Location or Adress',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: const Icon(
                    Icons.location_on,
                    color: Colors.grey,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.blueAccent.withOpacity(0.2),
                  filled: true,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: 'E-mail',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: const Icon(
                    Icons.mail_outline_sharp,
                    color: Colors.grey,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordControll,
              style: const TextStyle(color: Colors.black),
              obscureText: true,
              decoration: InputDecoration(
                  fillColor: Colors.blueAccent.withOpacity(0.2),
                  filled: true,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: 'Set strong password',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: const Icon(
                    Icons.vpn_key_outlined,
                    color: Colors.grey,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Radio(
                    value: 'room_owner',
                    groupValue: selectedItem,
                    onChanged: (val) {
                      setState(() {
                        selectedItem = val as String;
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(selectedItem)));
                      });
                    }),
                const Text(
                  'Room owner',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 20,
                ),
                Radio(
                    value: 'mess_owner',
                    groupValue: selectedItem,
                    onChanged: (val) {
                      setState(() {
                        selectedItem = val as String;
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(selectedItem)));
                      });
                    }),
                const Text(
                  'Mess owner',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: GestureDetector(
                  onTap: () {
                    if (fnameController.text.isEmpty ||
                        lnameController.text.isEmpty ||
                        mobileController.text.isEmpty ||
                        locationController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        passwordControll.text.isEmpty ||
                        selectedItem == '') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Fill all cridentials...',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 300),
                        dismissDirection: DismissDirection.up,
                      ));
                    } else {
                      data = OwnerSignUpModal(
                          fnameController.text.toString(),
                          lnameController.text.toString(),
                          emailController.text.toString(),
                          mobileController.text.toString(),
                          locationController.text.toString(),
                          selectedItem.toString());
                      registerOwner(emailController.text.toString(),
                          passwordControll.text.toString());
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
            ),
            const SizedBox(height: 30),
            const Center(
              child: Text(
                'Alerady have an account?',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void registerOwner(String email, String password) {
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {insertOwnerInfo(data)})
        .onError((error, stackTrace) => {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('$error')))
            });
  }

  insertOwnerInfo(OwnerSignUpModal data) {
    dataBRef
        .child('Users')
        .child('all_users')
        .child(auth.currentUser!.uid)
        .set({
      'first_name': data.fname,
      'last_name': data.lname,
      'email': data.email,
      'location': data.location,
      'mobile_number': data.mobileNo,
      'role': data.role
    }).then((value) => {
              if (data.role == 'room_owner')
                {
                  dataBRef
                      .child('Users')
                      .child('room_owners')
                      .child(auth.currentUser!.uid)
                      .set({
                    'first_name': data.fname,
                    'last_name': data.lname,
                    'email': data.email,
                    'location': data.location,
                    'mobile_number': data.mobileNo,
                    'role': data.role
                  })
                }
              else if (data.role == 'mess_owner')
                {
                  dataBRef
                      .child('Users')
                      .child('mess_owners')
                      .child(auth.currentUser!.uid)
                      .set({
                    'first_name': data.fname,
                    'last_name': data.lname,
                    'email': data.email,
                    'location': data.location,
                    'mobile_number': data.mobileNo,
                    'role': data.role
                  })
                }
            });
  }
}
