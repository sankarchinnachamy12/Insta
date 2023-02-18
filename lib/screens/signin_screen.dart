import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_signinauth/instagram/instagram_screen.dart';
import 'package:firebase_signinauth/screens/home_screen.dart';
import 'package:firebase_signinauth/screens/signup_screen.dart';
//import 'package:firebase_signinauth/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import '../reusable_widget/reusable_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController =TextEditingController();
  TextEditingController _emailTextController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body:Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(),

            child:SingleChildScrollView(
                child:Padding(padding: EdgeInsets.fromLTRB(20,MediaQuery.of(context).size.height*0.2,20,0),
                    child:Column(
                      children: [
                        logoWidget("assets/images/insta.png",),
                        SizedBox(
                          height: 50,
                        ),
                        reusableTextField("Enter Email", Icons.person_outline,false, _emailTextController),
                        SizedBox(height: 30,),
                        reusableTextField("Password", Icons.remove_red_eye_outlined,true, _passwordTextController),
                        SizedBox(height: 20,),
                        signINSignUpButton(context, true, (){
                          FirebaseAuth.instance.signInWithEmailAndPassword(
                            email:_emailTextController.text, password: _passwordTextController.text).then((value)
                            {Navigator.push(context,MaterialPageRoute(builder: (context)=> instagram()));}).onError((error, stackTrace){
                            print("error ${error.toString()}");
                          });
                          
                        }),
                        SizedBox(height: 15,),
                        signUpOption(),



                      ],
                    )
                )
            )
        )
    );
  }
  Row signUpOption(){
    return Row (
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style:TextStyle(color:Colors.white,fontSize: 18)),
        GestureDetector(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpScreen()));
            },
            child:const Text("Sign Up",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),)
        )
      ],
    );
  }
}
