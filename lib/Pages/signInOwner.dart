import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:serficon/MainScreen/CustomerMenuPage.dart';
import 'package:serficon/MainScreen/MessOwnerMenuPage.dart';
import 'package:serficon/MainScreen/RoomOwnerMenuPage.dart';
import 'package:serficon/Pages/signUpOwner.dart';
import 'package:serficon/Pages/signUpVerifiedOwner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInOwner extends StatefulWidget {
  const SignInOwner({Key? key}) : super(key: key);

  @override
  State<SignInOwner> createState() => _SignInOwnerState();
}

class _SignInOwnerState extends State<SignInOwner> {
  bool isloding=false;
  // ignore: deprecated_member_use
  DatabaseReference databaseReference=FirebaseDatabase.instance.reference();
  late final FirebaseAuth auth;
  var role;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth=FirebaseAuth.instance;
  }

  final emailController = TextEditingController();
  final passwordControll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isloding==false?Center(
        child: Flexible(
          child: Container(
            color: Colors.orangeAccent.withOpacity(0.7),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: ListView(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      child: Lottie.asset('assets/lottie/signIn.json'),
                    ),
                    SizedBox(height: 60,),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: Center(
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          hintText: 'E-mail',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.mail_outline_sharp,
                            color: Colors.grey,
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: passwordControll,
                      style: const TextStyle(color: Colors.black),
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.vpn_key_outlined,
                            color: Colors.grey,
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () async {
                          if (emailController.text.isEmpty ||
                              passwordControll.text.isEmpty) {
                            Flushbar(
                              message:'Fill all cridentials...' ,
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                            ).show(context);

                          } else {
                            //doSignInOwner(emailController.text, passwordControll.text);
                            setState((){
                              isloding=true;
                            });
                            auth.signInWithEmailAndPassword(email: emailController.text, password: passwordControll.text);
                            setState((){
                              isloding=false;
                            });
                            setState((){
                              isloding=true;
                            });
                            final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                            sharedPreferences.setString('email', emailController.text);
                            databaseReference.child('Users').child('all_users').child(auth.currentUser!.uid).child('role').once().then((value) {
                              var role=value.snapshot.value;
                              if(role=='room_owner')
                                {
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const RoomOwnerMenuPage()));

                                }
                              else if(role=='mess_owner')
                                {
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const MessOwnerMenuPage()));

                                }
                              else if(role=='customer')
                                {
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const MenuPage()));

                                }
                            });
                            setState((){
                              isloding=false;
                            });
                            // ignore: use_build_context_synchronously

                          }
                        },
                        child: Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blueAccent,
                          ),
                          child: const Center(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: const Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const VerifiedOwner()));
                        },
                        child: Center(
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ):Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.blueAccent,),
          SizedBox(height: 20,),
          Text('Loading...',style: TextStyle(color: Colors.grey,fontSize: 20),)

        ],
      )),
    );
  }

  // void doSignInOwner(String email, String password) {
  //   auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
  //     databaseReference.child('Users/all_users/${auth.currentUser!.uid}/role').once().then((value) {
  //       role=value.snapshot.value;
  //       if(role=='room_owner')
  //         {
  //           Navigator.push(context,MaterialPageRoute(builder: (context)=> const RoomOwnerMenuPage()));
  //         }
  //       else if(role=='mess_owner')
  //         {
  //           Navigator.push(context,MaterialPageRoute(builder: (context)=> const MessOwnerMenuPage()));
  //
  //         }
  //     });
  //   });
  // }
}
