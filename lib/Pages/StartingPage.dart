import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:serficon/Pages/signInCustomer.dart';
import 'package:serficon/Pages/signInOwner.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({Key? key}) : super(key: key);

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Container(
          color: Colors.blueAccent.withOpacity(0.3),
          child: Center(
            child: ListView(
                children: [
                  SizedBox(height: 20,),
                  Container(
                    child: Lottie.asset('assets/lottie/welcome.json'),
                  ),
                  SizedBox(height: 30,),

                  const SizedBox(height: 30),
                  const Center(child: Text('Who are you?',style: TextStyle(fontSize: 24,color: Colors.black,fontWeight: FontWeight.bold),)),
                  const SizedBox(height: 30,),
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignInOwner()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      height: 60,
                      margin: EdgeInsets.only(left: 30,right: 30),
                      decoration:  BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(25)

                    ),
                      child: Center(child: const Text('Owner',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),)),
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignInCustomer()));

                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 30,right: 30),
                      height: 60,
                      width: MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.blueAccent.withOpacity(0.8)
                      ),
                      child: const Center(child: Text('Customer',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold))),
                    ),
                  )
                ],
              ),
          ),
        ),
      ),

    );
  }
}

