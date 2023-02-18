import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../reusable_widget/reusable_widget.dart';
import 'home_screen.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _userTextController =TextEditingController();
  TextEditingController _passwordTextController =TextEditingController();
  TextEditingController _emailTextController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Sign UP',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),

      ),
      body: Container(
        width:  MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(

        ),
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(20 ,MediaQuery.of(context).size.height*0.2 , 20, 0),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    reusableTextField("Enter UserName", Icons.person_outline, false, _userTextController),
                    SizedBox(height: 20,),
                    reusableTextField("Enter Email", Icons.person_outline, false, _emailTextController),
                    SizedBox(height: 20,),
                    reusableTextField("Enter Password", Icons.person_outline, true, _passwordTextController),
                    SizedBox(height: 20,),
                    signINSignUpButton(context, false, (){
                   FirebaseAuth.instance.createUserWithEmailAndPassword(email:_emailTextController.text, password:_passwordTextController.text ).then((value){
                    print("account created");
                       Navigator.push(context,MaterialPageRoute(builder: (context)=> HomeScreen()));

                  }).onError((error, stackTrace){
                    print("error ${error.toString()}");
                  });
                    
                    })
                  ],
                )
            )
        ),
      ),
    );
  }
}
